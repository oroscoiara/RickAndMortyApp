//
//  CharactersListViewModelTest.swift
//  RickAndMorty-AppTests
//
//  Created by Iara Denise Orosco on 15/08/2023.
//

import Quick
import Nimble
@testable import RickAndMorty_App

// MARK: - CharactersListViewModelTest Section

/// Tests de CharactersListViewModel.
class CharactersListViewModelTest: QuickSpec {
    override func spec() {
        describe("CharactersListViewModel") {
            var viewModel: CharactersListViewModel!
            var mockService: MockRMService!

            beforeEach {
                viewModel = CharactersListViewModel()
                mockService = MockRMService()
            }

            context("when characters are fetched successfully") {
                beforeEach {
                    let character1 = SomeCharacterMock.makeMockCharacter()
                    let character2 = SomeCharacterMock.makeMockCharacter()
                    let mockCharacters = [character1, character2]
                    viewModel.characters = mockCharacters
                    viewModel.getCharacters()
                }

                it("should provide correct number of items for collection view") {
                    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
                    let numberOfItems = viewModel.collectionView(collectionView, numberOfItemsInSection: 0)
                    expect(numberOfItems).to(equal(2))
                }
            }

            beforeEach {

                mockService.mockResult = .success(AllCharacterResponse(info: AllCharacterResponse.Info(count: 0, pages: 0, next: "", prev: ""), results: []))

                   viewModel.getCharacters()
               }

                it("should not provide any items for collection view") {
                    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
                    let numberOfItems = viewModel.collectionView(collectionView, numberOfItemsInSection: 0)
                    expect(numberOfItems).to(equal(0))
                }
            }

        }
    }


class MockRMService: RMService {
    var mockResult: Result<Decodable, Error>?

    override func execute<T: Decodable>(_ request: RMRequest, expecting responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        if let mockResult = mockResult as? Result<T, Error> {
            completion(mockResult)
        } else {
            //do nothing
        }
    }
}
