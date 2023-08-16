//
//  CharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import UIKit

protocol EpisodeDataRender {
    var name: String { get }
    var air_date: String { get }
    var episode: String { get }
    
}

class CharacterEpisodeCollectionViewCellViewModel {
    
    private let episodeDataUrl: URL?
    private var isAlreadyFetched = false
    private var dataBlock: ((EpisodeDataRender) -> Void)?
    
    public let borderColor: UIColor
    
    private var episode: Episode? {
        didSet {
            guard let model = episode else {
                return
            }
            dataBlock?(model)
        }
    }
    
    init(episodeDataUrl: URL?, borderColor: UIColor = .systemGray2) {
        self.episodeDataUrl = episodeDataUrl
        self.borderColor = borderColor
    }

    public func registerForData(_ block: @escaping (EpisodeDataRender) -> Void) {
        self.dataBlock = block
    }
    
    public func getEpisode() {
        guard !isAlreadyFetched else {
            if let model = episode {
                dataBlock?(model)
            }
            return
        }
        
        guard let url = episodeDataUrl,
              let request = RMRequest(url: url) else {
            return
        }
        
        isAlreadyFetched = true
        
        RMService.shared.execute(request, expecting: Episode.self) { [weak self] result in
            switch result {
                
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                    
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
}
