//
//  CasheScreenshotService.swift
//  Lite_iTunes
//
//  Created by Eduard on 31.08.2021.
//

import UIKit
import Alamofire

enum TypePhoto {
    case screenshot
    case songs
}


final class CasheScreenshotService {
    private init() {}
    static let single = CasheScreenshotService()
    
    private var memoryCache: [String: (UIImage,Int)]=[:] {
        didSet {
            //Если колличество фотографий в памяти превышает определенное количество (50 шт), то удаляется половина более ранее записанных фото
            if memoryCache.count>50 {
                var tempMemoryCaсhe: [String: (UIImage,Int)]=[:]
                for value in memoryCache {
                    if value.value.1 > 25 {
                        tempMemoryCaсhe[value.key] = (value.value.0, tempMemoryCaсhe.count)
                    }
                }
                memoryCache = tempMemoryCaсhe
            }
        }
    }
    
    private let cacheLifeTime: TimeInterval = 60 * 60 * 24 * 7
    
    private let isolationQ = DispatchQueue(label: "CasheScreenshotService")
    
    private static let pathName: String = {
        let pathName = "Images"
        guard
            let cacheDir = FileManager
            .default
            .urls(
                for: .cachesDirectory,
                in: .userDomainMask)
            .first
        else { return pathName }
        let url = cacheDir
            .appendingPathComponent(
                pathName,
                isDirectory: true)
        if !FileManager
            .default
            .fileExists(atPath: url.path) {
            try? FileManager
                .default
                .createDirectory(
                    at: url,
                    withIntermediateDirectories: true,
                    attributes: nil)
        }
        
        return pathName
    }()
    
    private func getFilePath(at urlString: String, typePhoto: TypePhoto) -> String? {
        guard
            let cacheDir = FileManager
                .default
                .urls(
                    for: .cachesDirectory,
                    in: .userDomainMask)
                .first
        else { return nil }
        let arrayOfUrlString = urlString.split(separator: "/")
        var fileName = ""
        if typePhoto == .screenshot {
            fileName = String(arrayOfUrlString[arrayOfUrlString.count-2]) }
        else {
            fileName = String(arrayOfUrlString[arrayOfUrlString.count-3])
        }
        return cacheDir
            .appendingPathComponent("\(CasheScreenshotService.pathName)/\(fileName)")
            .path
    }
    
    // MARK: Remove cache image
    private func removeImageFromDisk(urlString: String, typePhoto: TypePhoto) {
        guard
            let fileName = getFilePath(at: urlString, typePhoto: typePhoto),
            FileManager.default.fileExists(atPath: fileName)
        else { return }
        do {
            try FileManager
                .default
                .removeItem(atPath: fileName)
        } catch {
            print("🚩🚩🚩 \(error) 🚩🚩🚩")
        }
        
    }
    
    // MARK: Save cache image
    private func saveImageToDisk(
        urlString: String,
        typePhoto: TypePhoto,
        image: UIImage) {
        guard let fileName = getFilePath(at: urlString, typePhoto: typePhoto) else { return }
        let data = image.pngData()
        FileManager
            .default
            .createFile(
                atPath: fileName,
                contents: data,
                attributes: nil)
    }
    
    // MARK: Load image cache
    private func getImageFromDisk(urlString: String, typePhoto: TypePhoto) -> UIImage? {
        guard
            let fileName = getFilePath(at: urlString, typePhoto: typePhoto),
            let fileInfo = try? FileManager
                .default
                .attributesOfItem(atPath: fileName),
            let modificationDate = fileInfo[FileAttributeKey.modificationDate]
                as? Date
        else { return nil }
        let lifetime = Date()
            .timeIntervalSince(modificationDate)
        guard
            lifetime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName)
        else {
            removeImageFromDisk(urlString: urlString, typePhoto: typePhoto)
            return nil
        }
        
        isolationQ.async {
            self.memoryCache[urlString] = (image, self.memoryCache.count)
        }
        
        return image
    }
    
    private func loadImage(
        urlString: String,
        typePhoto: TypePhoto,
        complition: @escaping (UIImage?) -> Void) {
        AF
            .request(urlString)
            .responseData(queue: .global()) { [weak self] response in
                guard
                    let self = self,
                    let data = response.data,
                    let image = UIImage(data: data)
                else {
                    return complition(nil)
                }
                
                self.isolationQ.async {
                    self.memoryCache[urlString] = (image, self.memoryCache.count)
                }
                self.saveImageToDisk(
                    urlString: urlString,
                    typePhoto: typePhoto,
                    image: image)
                
                complition(image)
            }
    }
    
    // MARK: - Public API
    public func getImage(
        urlString: String,
        typePhoto: TypePhoto,
        completion: @escaping (UIImage?) -> Void) {
        if let image = memoryCache[urlString]?.0 {
            completion(image)
        } else if let image = getImageFromDisk(urlString: urlString, typePhoto: typePhoto) {
            completion(image)
        } else {
            loadImage(
                urlString: urlString,
                typePhoto: typePhoto,
                complition: completion)
        }
    }
}
