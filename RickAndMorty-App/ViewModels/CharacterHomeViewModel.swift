//
//  CharacterHomeViewModel.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//


import UIKit

enum StreamingService: Int, CaseIterable {
    case youtube
    case hbo
    
    var iconName: String {
        switch self {
        case .youtube:
            return "play.tv"
        case .hbo:
            return "sparkles.tv"
        }
    }
    
    var url: URL? {
        switch self {
        case .youtube:
            return URL(string: "https://www.youtube.com/watch?v=P9WZhGMlDBE")
        case .hbo:
            return URL(string: "https://www.hbomax.com/ar/es/series/urn:hbo:series:GXkRjxwjR68PDwwEAABKJ")
        }
    }
}

class CharacterHomeViewModel {
    func getUrl(for service: StreamingService) -> URL? {
        return service.url
    }
}
