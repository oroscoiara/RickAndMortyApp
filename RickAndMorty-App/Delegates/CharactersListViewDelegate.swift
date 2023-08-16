//
//  CharactersListViewDelegate.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

protocol CharactersListViewDelegate: AnyObject {

    func characterListView(
        characterListView: CharactersListView,
        didSelectCharacter character: Character
    )
}
