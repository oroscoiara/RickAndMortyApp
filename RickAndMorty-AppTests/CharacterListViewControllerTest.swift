//
//  CharacterListViewControllerTest.swift
//  RickAndMorty-AppTests
//
//  Created by Iara Denise Orosco on 15/08/2023.
//

import Quick
import Nimble
@testable import RickAndMorty_App

// MARK: - CharactersListViewControllerTest Section

/// Tests de CharactersListViewController.
class CharactersListViewControllerTest: QuickSpec {
    override func spec() {
        describe("CharactersListViewController") {
            var viewController: CharactersListViewController!

            beforeEach {
                viewController = CharactersListViewController()
                _ = viewController.view
            }

            it("should set the title correctly") {
                expect(viewController.title).to(equal("Characters"))
            }

            it("should add charactersListView as subview") {
                expect(viewController.view.subviews).to(contain(viewController.charactersListView))
            }

            it("should set charactersListView delegate") {
                expect(viewController.charactersListView.delegate).to(beIdenticalTo(viewController))
            }

            it("should set up constraints properly") {
                let charactersListViewTopConstraint = viewController.charactersListView.constraints.first { $0.firstAttribute == .top }
                let charactersListViewBottomConstraint = viewController.charactersListView.constraints.first { $0.firstAttribute == .bottom }
                let charactersListViewLeadingConstraint = viewController.charactersListView.constraints.first { $0.firstAttribute == .leading }
                let charactersListViewTrailingConstraint = viewController.charactersListView.constraints.first { $0.firstAttribute == .trailing }

                expect(charactersListViewTopConstraint?.constant).to(equal(0))
                expect(charactersListViewBottomConstraint?.constant).to(equal(0))
                expect(charactersListViewLeadingConstraint?.constant).to(equal(0))
                expect(charactersListViewTrailingConstraint?.constant).to(equal(0))
            }

            it("should set up search bar correctly") {
                expect(viewController.navigationItem.searchController).to(beIdenticalTo(viewController.searchController))
                expect(viewController.searchController.searchResultsUpdater).to(beIdenticalTo(viewController))
                expect(viewController.searchController.obscuresBackgroundDuringPresentation).to(beFalse())
                expect(viewController.searchController.searchBar.placeholder).to(equal("Search Characters"))

            }
        }
    }
}
