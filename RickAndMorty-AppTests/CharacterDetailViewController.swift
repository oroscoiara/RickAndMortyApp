//
//  CharacterDetailViewControllerTest.swift
//  RickAndMorty-AppTests
//
//  Created by Iara Denise Orosco on 14/08/2023.
//

import Quick
import Nimble
@testable import RickAndMorty_App

// MARK: - CharacterDetailViewControllerTest Section

/// Tests de CharacterDetailViewController.
class CharacterDetailViewControllerTest: QuickSpec {
    override func spec() {
        describe("CharacterDetailViewController") {
            var mockCharacter: Character!
            var viewController: CharacterDetailViewController!
            var mockViewModel: CharacterDetailViewModelMock!

            beforeEach {
                mockCharacter = SomeCharacterMock.makeMockCharacter()

                mockViewModel = CharacterDetailViewModelMock(character: mockCharacter)
                viewController = CharacterDetailViewController(viewModel: mockViewModel)
                _ = viewController.view

            }

            it("should have correct title from mockViewModel") {
                expect(viewController.title).to(equal(mockViewModel.mockTitle))
            }

            it("should add detailView as subview") {
                expect(viewController.view.subviews).to(contain(viewController.detailView))
            }

            it("should set up constraints properly") {
                let detailViewTopConstraint = viewController.detailView.constraints.first { $0.firstAttribute == .top }
                let detailViewBottomConstraint = viewController.detailView.constraints.first { $0.firstAttribute == .bottom }
                let detailViewLeadingConstraint = viewController.detailView.constraints.first { $0.firstAttribute == .leading }
                let detailViewTrailingConstraint = viewController.detailView.constraints.first { $0.firstAttribute == .trailing }

                expect(detailViewTopConstraint?.constant).to(equal(0))
                expect(detailViewBottomConstraint?.constant).to(equal(0))
                expect(detailViewLeadingConstraint?.constant).to(equal(0))
                expect(detailViewTrailingConstraint?.constant).to(equal(0))
            }

            it("should set up collectionView delegate and dataSource") {
                expect(viewController.detailView.collectionView?.delegate).to(beIdenticalTo(viewController))
                expect(viewController.detailView.collectionView?.dataSource).to(beIdenticalTo(viewController))
            }

            it("should have correct number of sections in collectionView") {
                let numberOfSections = viewController.numberOfSections(in: viewController.detailView.collectionView!)
                expect(numberOfSections).to(equal(mockViewModel.mockSections.count))
            }

            it("should have correct number of items in each section") {
                let collectionView = viewController.detailView.collectionView!
                for (sectionIndex, sectionType) in mockViewModel.mockSections.enumerated() {
                    let numberOfItems = viewController.collectionView(collectionView, numberOfItemsInSection: sectionIndex)

                    switch sectionType {
                    case .photo:
                        expect(numberOfItems).to(equal(1))
                    case .information(let viewModels):
                        expect(numberOfItems).to(equal(viewModels.count))
                    case .episodes(_):
                        break
                        //do nothing
                    }
                }
            }
        }
    }
}

