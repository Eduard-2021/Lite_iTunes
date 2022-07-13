//
//  NetworkManager.swift
//  Lite_iTunes
//
//  Created by Eduard on 24.08.2021.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    public typealias DataCompletion = (Result<Data,Error>) -> Void
    public typealias JSONCompletion = (Result<[String: Any]?, Error>) -> Void
    
    public func dataRequest(_ request: WebRequest, then completion: DataCompletion?) {
        AF.request(request.url, method: request.method, parameters: request.parameters).validate().responseData { [weak self] response in
            switch response.result {
            case let .success(data):
                completion?(.success(data))
            case let .failure(error):
                completion?(.failure(error))
            }
        }
    }
    
    private func logError(_ error: Error, request: WebRequest) {
        print("Error while executing request \(request.url), error: \(error.localizedDescription)")
    }
}


