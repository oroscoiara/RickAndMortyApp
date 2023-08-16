//
//  ImageLoader.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import Foundation

class ImageLoader {
    static let shared = ImageLoader()

    private var imageCache = NSCache<NSString, NSData>()

    private init() {}

    public func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void ){
        let key = url.absoluteString as NSString

        if let data = imageCache.object(forKey: key) {
            completion(.success(data as Data))
            return
        }

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            let value = data as NSData
            self?.imageCache.setObject(value, forKey: key)
            completion(.success(data))
        }
        task.resume()
    }
}
