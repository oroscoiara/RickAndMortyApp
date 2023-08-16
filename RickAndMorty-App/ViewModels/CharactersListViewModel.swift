//
//  CharactersListViewModel.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import UIKit

class CharactersListViewModel: NSObject {
    
    var characters: [Character] = [] {
        didSet {
            for character in characters {
                let viewModel = CharactersCollectionViewCellModel(characterName: character.name, characterStatus: character.status, characterImage: URL(string: character.image))
                cellViewModel.append(viewModel)
            }
        }
    }
    
    public weak var delegate: CharacterListViewViewModelDelegate? 
    
    private var cellViewModel: [CharactersCollectionViewCellModel] = []
    
    private var apiInfo: AllCharacterResponse.Info? = nil
    
    public func getCharacters() {
        RMService.shared.execute(
            .charactersListURLRequest,
            expecting: AllCharacterResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let result = responseModel.results
                let info = responseModel.info
                self?.characters = result
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
                
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension CharactersListViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.cellIdentifier, for: indexPath) as? CharactersCollectionViewCell else {
            fatalError("Cannot find the cell")
        }
        let viewModel = cellViewModel[indexPath.row]
        
        cell.configure(viewModel: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let characterSelected = characters[indexPath.row]
        delegate?.didSelectCharacter(characterSelected)
    }
}

