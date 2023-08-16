//
//  CharacterPhotoCollectionViewCellViewModel.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import Foundation

class CharacterPhotoCollectionViewCellViewModel {
    
    private let image: URL?
    
    init(image: URL) {
        self.image = image
    }
    
    public func getImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = image else {
            completion(.failure(URLError(.badURL)))
            return
        }
        /// Read from cache
        ImageLoader.shared.downloadImage(imageUrl, completion: completion)
    }
    
}
