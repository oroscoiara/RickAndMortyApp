//
//  CharacterDetailViewModelTest.swift
//  RickAndMorty-AppTests
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import Quick
import Nimble
@testable import RickAndMorty_App

// MARK: - CharacterDetailViewModelTest Section

/// Tests de CharacterDetailViewModel.
class CharacterDetailViewModelTest: QuickSpec {
    override func spec() {
        describe("CharacterDetailViewModel") {
            var sut: CharacterDetailViewModel!
            var mockCharacter: Character!

            beforeEach {
                mockCharacter = SomeCharacterMock.makeMockCharacter()
                sut = CharacterDetailViewModel(character: mockCharacter)
            }

            it("correctly sets up the amount of sections") {
                expect(sut.sections.count).to(equal(3))

            }

            it("provides correct title") {
                expect(sut.title).to(equal("Rick Sanchez"))
            }

            it("provides correct request URL") {
                expect(sut.requestUrl).to(equal(URL(string: "rick_url")))
            }

            context("when creating photo section layout") {
                var sectionLayout: NSCollectionLayoutSection!

                beforeEach {
                    sectionLayout = sut.createPhotoSectionLayout()
                }

                it("creates a valid layout") {
                    expect(sectionLayout).notTo(beNil())
                }
            }

            context("when creating info section layout") {
                var sectionLayout: NSCollectionLayoutSection!

                beforeEach {
                    sectionLayout = sut.createInfoSectionLayout()
                }

                it("creates a valid layout") {
                    expect(sectionLayout).notTo(beNil())

                }
            }

            context("when creating episodes section layout") {
                var sectionLayout: NSCollectionLayoutSection!

                beforeEach {
                    sectionLayout = sut.createEpisodesSectionLayout()
                }

                it("creates a valid layout") {
                    expect(sectionLayout).notTo(beNil())

                    let scrollingBehavior = sectionLayout.orthogonalScrollingBehavior
                    expect(scrollingBehavior).to(equal(.groupPaging))
                }
            }
        }
    }
}
