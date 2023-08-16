//
//  CharactersCollectionViewCellModel.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import UIKit

class CharactersCollectionViewCellModel {
    
    public let characterName: String
    public let characterStatus: CharacterStatus
    public let characterImage: URL?
    
    init (
        characterName: String,
        characterStatus: CharacterStatus,
        characterImage: URL?
    ) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImage = characterImage
    }
    
    public var characterStatusString: String {
        return characterStatus.rawValue
    }
    
    public func getImage(completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = characterImage else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let request = URLRequest(url: url)
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
}
