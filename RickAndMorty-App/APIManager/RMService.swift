//
//  RMService.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import Foundation

/// Service to connect with the Rick and Morty' API.
class RMService {

    ///Singleton
    static let shared = RMService()

    internal init() {}

    /// Trigger the API call
    /// - Parameters:
    ///   - request: request instance
    ///   - type: expected objetc' type
    ///   - completition: Holds the callback
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(ServiceError.requestFailed))
            return
        }

        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceError.requestFailed))
                return
            }

            /// Decode response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }


    enum ServiceError: Error {
        case requestFailed
    }

    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
}
