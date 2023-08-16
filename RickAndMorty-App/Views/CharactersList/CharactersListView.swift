//
//  CharactersListView.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import UIKit

/// View that shows and loads the character' list.
class CharactersListView: UIView, CharacterListViewViewModelDelegate {
    
    private let charactersViewModel = CharactersListViewModel()
    public weak var delegate: CharactersListViewDelegate?
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private lazy var charactersCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        collectionView.register(CharactersCollectionViewCell.self, forCellWithReuseIdentifier: CharactersCollectionViewCell.cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(charactersCollectionView, spinner)
        setUpConstraints()
        spinner.startAnimating()
        charactersViewModel.delegate = self
        charactersViewModel.getCharacters()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            
            charactersCollectionView.topAnchor.constraint(equalTo: topAnchor),
            charactersCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            charactersCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            charactersCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    private func setUpCollectionView() {
        charactersCollectionView.dataSource = charactersViewModel
        charactersCollectionView.delegate = charactersViewModel
    }
    
    func didLoadInitialCharacters() {
        spinner.stopAnimating()
        charactersCollectionView.isHidden = false
        charactersCollectionView.reloadData()
        
        UIView.animate(withDuration: 0.4) {
            self.charactersCollectionView.alpha = 1
        }
    }
    
    func didSelectCharacter(_ character: Character) {
        delegate?.characterListView(characterListView: self, didSelectCharacter: character)
    }
}
