//
//  CharacterStatus.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case  `unknown` = "unknown"

    var text: String {
            switch self {
            case .alive, .dead:
                return rawValue
            case .unknown:
                return "Unknown"
            }
        }
}
