//
//  CharactersListViewController.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import UIKit

/// Controller to show and search on the characters list.
class CharactersListViewController: UIViewController, CharactersListViewDelegate {

    internal var charactersListView = CharactersListView()

    internal var charactersViewModel = CharactersListViewModel()

    public let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Characters"
        view.backgroundColor = .systemBackground
        view.addSubview(charactersListView)
        charactersListView.delegate = self
        setUpConstraints()
        setUpSearchBar()
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            charactersListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            charactersListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            charactersListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            charactersListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }

    func setUpSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Characters"
        navigationItem.searchController = searchController
    }

    /// Push to the DetailViewController of the `character` selected.
    /// - Parameters:
    ///   - characterListView: The character list view that triggered the selection.
    ///   - character: The selected character.
    func characterListView(characterListView: CharactersListView, didSelectCharacter character: Character) {
        let viewModel = CharacterDetailViewModel(character: character)
        let detailVC =  CharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension CharactersListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //to be done
    }
}
