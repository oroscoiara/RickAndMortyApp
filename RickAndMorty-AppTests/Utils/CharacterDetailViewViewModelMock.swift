//
//  CharacterDetailViewViewModelMock.swift
//  RickAndMorty-AppTests
//
//  Created by Iara Denise Orosco on 14/08/2023.
//

import Foundation
import Quick
import Nimble
@testable import RickAndMorty_App

class CharacterDetailViewModelMock: CharacterDetailViewModel {
    var mockSections: [SectionType] = []
    var mockTitle: String = "Rick Sanchez"
    var mockRequestUrl: URL?

    override init(character: Character) {
        super.init(character: character)
        setUpMockData()
    }

    private func setUpMockData() {
        mockSections = [
            .photo(viewModel: CharacterPhotoCollectionViewCellViewModel(image: URL(string: "mock_image_url")!)),
            .information(viewModels: [
                .init(type: .status, value: "Mock Status"),
                .init(type: .gender, value: "Mock Gender"),
                .init(type: .species, value: "Mock Species"),
                .init(type: .location, value: "Mock Location"),
            ]),
            .episodes(viewModels: [
                CharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: "mock_episode_url")),
                CharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: "mock_episode_url"))
            ])
        ]
        mockTitle = "Rick Sanchez"
        mockRequestUrl = URL(string: "mock_request_url")
    }
}
