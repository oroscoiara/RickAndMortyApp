//
// HomeViewDelegateSpy.swift
//  RickAndMorty-AppTests
//
//  Created by Iara Denise Orosco on 14/08/2023.
//

import Foundation
@testable import RickAndMorty_App

class HomeViewDelegateSpy: HomeViewDelegate {

    var didTapStreamingServiceCallCount = 0
    var lastTappedStreamingService: StreamingService?
    var lastTappedURL: URL?

    func didTapStreamingService(_ service: StreamingService, openURL url: URL) {
        didTapStreamingServiceCallCount += 1
        lastTappedStreamingService = service
        lastTappedURL = url
    }
}
