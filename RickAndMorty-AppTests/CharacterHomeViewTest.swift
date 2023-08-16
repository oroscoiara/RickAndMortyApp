//
//  CharacterHomeViewTest.swift
//  RickAndMorty-AppTests
//
//  Created by Iara Denise Orosco on 14/08/2023.
//

import Quick
import Nimble
@testable import RickAndMorty_App

// MARK: - CharacterHomeViewTest Section

/// Tests de CharacterHomeView.
class HomeViewTest: QuickSpec {
    override func spec() {
        describe("HomeView") {
            var homeView: HomeView!
            var mockViewModel: CharacterHomeViewModel!
            var mockDelegate: HomeViewDelegateSpy!

            beforeEach {
                mockViewModel = CharacterHomeViewModel()
                mockDelegate = HomeViewDelegateSpy()
                homeView = HomeView(viewModel: mockViewModel)
                homeView.delegate = mockDelegate
            }

            context("When youtube streaming service button is tapped") {
                it("notifies the delegate with the corresponding URL") {
                    let streamingServiceButton = UIButton()
                    streamingServiceButton.tag = StreamingService.youtube.rawValue
                    homeView.streamingButtonTapped(streamingServiceButton)

                    expect(mockDelegate.didTapStreamingServiceCallCount) == 1
                    expect(mockDelegate.lastTappedStreamingService) == .youtube
                    expect(mockDelegate.lastTappedURL?.absoluteString) == StreamingService.youtube.url?.absoluteString
                }
            }
        }
    }
}

