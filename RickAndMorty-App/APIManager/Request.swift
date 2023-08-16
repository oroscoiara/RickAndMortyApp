//
//  Request.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import Foundation

/// Rick and Morty API Request
///
class RMRequest {

    /// Base URL for API Request
    private struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api"
    }

    /// Selected HTTP Method
    public let httpMethod = "GET"

    /// Selected endpoint
    private let endpoint: RMEndpoint

    /// Path components
    private let path: [String]

    /// Query parameters
    private let parameters: [URLQueryItem]

    /// URL Constructor
    private var urlString: String {
        var string = Constants.baseURL
        string += "/"
        string += endpoint.rawValue

        if !path.isEmpty {
            path.forEach({
                string += "/\($0)"
            })
        }

        if !parameters.isEmpty {
            string += "?"
            let parametersString = parameters.compactMap({
                guard let value = $0.value else {return nil}
                return "\($0.name) = \(value)"
            }).joined(separator: "&")

            string += parametersString
        }
        return string
    }

    /// Final constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }


    /// Description
    /// - Parameters:
    ///   - endpoint: Desired endpoint
    ///   - path: Path componentes
    ///   - parameters: Query parameters
    public init(
        endpoint: RMEndpoint,
        path: [String] = [],
        parameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.path = path
        self.parameters = parameters
    }

    /// Attempt to create request
    /// - Parameter url: URL to parse
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseURL) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseURL+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0] 
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let rmEndpoint = RMEndpoint(
                    rawValue: endpointString
                ) {
                    self.init(endpoint: rmEndpoint, path: pathComponents)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")

                    return URLQueryItem(
                        name: parts[0],
                        value: parts[1]
                    )
                })

                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint)
                    return
                }
            }
        }

        return nil
    }
}

extension RMRequest {
    
    static let charactersListURLRequest = RMRequest(endpoint: .character)
    static let listEpisodesRequest = RMRequest(endpoint: .episode)
}
