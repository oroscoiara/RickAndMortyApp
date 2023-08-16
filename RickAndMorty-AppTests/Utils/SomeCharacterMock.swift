//
//  SomeCharacterMock.swift
//  RickAndMorty-AppTests
//
//  Created by Iara Denise Orosco on 14/08/2023.
//

import Foundation
@testable import RickAndMorty_App

struct SomeCharacterMock {
    static func makeMockCharacter() -> Character {
        return Character(
            id: 1,
            name: "Rick Sanchez",
            status: .alive,
            species: "Human",
            type: "",
            gender: .male,
            origin: Origin(name: "Earth", url: "rick_url"),
            location: SingleLocation(name: "Earth", url: "rick_url"),
            image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
            episode: [],
            url: "rick_url",
            created: ""
        )
    }

    static func makeMockEmptyCharacter() -> Character? {
        return nil
    }
}
