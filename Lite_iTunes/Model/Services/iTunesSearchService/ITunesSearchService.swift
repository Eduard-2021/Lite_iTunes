//
//  ITunesSearchService.swift
//  Lite_iTunes
//
//  Created by Eduard on 25.08.2021.
//

import Alamofire
import UIKit

final class ITunesSearchService {
    
    public typealias CompletionApps = (Result<[ITunesApp],Error>) -> Void
    public typealias CompletionSongs = (Result<[ITunesSong],Error>) -> Void
    
    private let networkManager = NetworkManager()
    private let decoder = JSONDecoder()
    
    private let baseUrl = "https://itunes.apple.com/search"
    private let defaultRegionCode = "RU"
    
    private enum MediaType: String {
        case apps = "software"
        case music = "music"
    }
    
    private struct Parameter {
        static let query = "term"
        static let regionCode = "country"
        static let mediaType = "media"
    }
    
    public func getApps(forQuery query: String, then completion: CompletionApps?) {
        let regionCode = Locale.current.regionCode ?? defaultRegionCode
        var parameters: Parameters = [:]
        parameters[Parameter.query] = query
        parameters[Parameter.regionCode] = regionCode
        parameters[Parameter.mediaType] = MediaType.apps.rawValue
        
        let request = WebRequest(method: .get, url: baseUrl, parameters: parameters)
        
        networkManager.dataRequest(request) { [weak self] result in
            guard let self = self else {
                completion?(.success([]))
                return
            }
            switch result {
            case let .success(data):
                do {
                    let result = try self.decoder.decode(ITunesSearchResult<ITunesApp>.self, from: data)
                    let apps = result.results
                    completion?(.success(apps))
                } catch {
                    print(error)
                    completion?(.failure(error))
                }
            case let .failure(error):
                completion?(.failure(error))
            }
        }
    }
    
    public func getSongs(forQuery query: String, completion: CompletionSongs?) {
        let regionCode = Locale.current.regionCode ?? defaultRegionCode
        var parameters: Parameters = [:]
        parameters[Parameter.query] = query
        parameters[Parameter.regionCode] = regionCode
        parameters[Parameter.mediaType] = MediaType.music.rawValue

        let request = WebRequest(method: .get, url: baseUrl, parameters: parameters)

        networkManager.dataRequest(request) { [weak self] result in
            guard let self = self else {
                completion?(.success([]))
                return
            }
            switch result {
            case let .success(data):
                do {
                    let result = try self.decoder.decode(ITunesSearchResult<ITunesSong>.self, from: data)
                    let apps = result.results
                    completion?(.success(apps))
                } catch {
                    print(error)
                    completion?(.failure(error))
                }
            case let .failure(error):
                completion?(.failure(error))
                
            }
        }
    }
}


