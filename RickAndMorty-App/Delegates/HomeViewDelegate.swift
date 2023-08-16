//
//  HomeViewDelegate.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import Foundation

protocol HomeViewDelegate: AnyObject {

    func didTapStreamingService(
        _ service: StreamingService,
        openURL url: URL
    )
}

