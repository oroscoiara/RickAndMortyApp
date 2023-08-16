//
//  CharacterDetailViewModel.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import UIKit

class CharacterDetailViewModel {
    
    let character: Character
    
    public var episodes: [String] {
        character.episode
    }
    enum SectionType {
        case photo(viewModel: CharacterPhotoCollectionViewCellViewModel)
        case information(viewModels:  [CharacterInfoCollectionViewCellViewModel])
        case episodes(viewModels: [CharacterEpisodeCollectionViewCellViewModel])
    }
    
    public var sections: [SectionType] = []
    public var title: String {
        character.name
    }
    
    public var requestUrl: URL? {
        return URL(string: character.url)
    }
    
    init(character: Character) {
        self.character = character
        setUpSections()
    }
    
    private func setUpSections() {
        sections = [
            .photo(viewModel: .init(image: URL(string: character.image)!)),
            .information(viewModels: [
                .init(type: .status , value: character.status.text),
                .init(type: .gender , value: character.gender.rawValue),
                .init(type: .species , value: character.species),
                .init(type: .location , value: character.location.name),
            ]),
            .episodes(viewModels: character.episode.compactMap ({
                return CharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: $0))
            }))
        ]
    }
    
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.4)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)),
            subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    public func createEpisodesSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 5,
            bottom: 10,
            trailing: 7)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(110)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
}

