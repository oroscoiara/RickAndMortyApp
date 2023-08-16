//
//  CharacterHomeViewControllerTest.swift
//  RickAndMorty-AppTests
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import Quick
import Nimble
@testable import RickAndMorty_App

// MARK: - CharacterHomeViewControllerTest Section

/// Tests de CharacterHomeViewController.
class CharacterHomeViewControllerTest: QuickSpec {
    override func spec() {
        describe("CharacterHomeViewController") {
            var sut: CharacterHomeViewController!

            beforeEach {
                sut = CharacterHomeViewController()
                _ = sut.view
                sut.setupView()
            }

            context("When view loads") {
                it("Sets up the view") {
                    _ = sut.view
                    expect(sut.view.subviews.contains(sut.homeView)).to(beTrue())
                }

                it("sets the view background color to system background color") {
                    expect(sut.view.backgroundColor).to(equal(UIColor.systemBackground))
                }
            }

            context("when setting up the view") {
                it("adds the homeView as a subview") {
                    expect(sut.view.subviews.contains(sut.homeView)).to(beTrue())
                }

                it("sets up the designated constraints") {
                    let constraints = sut.view.constraints
                    let homeViewConstraints = constraints.filter { constraint in
                        return constraint.firstItem as? UIView == sut.homeView || constraint.secondItem as? UIView == sut.homeView
                    }

                    expect(constraints).toNot(beEmpty())
                    expect(homeViewConstraints.contains { $0.firstAttribute == .top }).to(beTrue())
                    expect(homeViewConstraints.contains { $0.firstAttribute == .leading }).to(beTrue())
                    expect(homeViewConstraints.contains { $0.firstAttribute == .trailing }).to(beTrue())
                    expect(homeViewConstraints.contains { $0.firstAttribute == .bottom }).to(beTrue())
                }
            }
        }
    }
}
