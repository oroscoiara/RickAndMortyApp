//
//  CharacterListViewViewModelDelegate.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

protocol CharacterListViewViewModelDelegate: AnyObject {

    func didLoadInitialCharacters()
    func didSelectCharacter(
        _ character: Character
    )
}
