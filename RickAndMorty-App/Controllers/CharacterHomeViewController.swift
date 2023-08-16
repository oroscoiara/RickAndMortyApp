//
//  CharacterHomeViewController.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import UIKit

/// Controller to show main image, welcome text and streaming buttons.
class CharacterHomeViewController: UIViewController {

    lazy var homeView: HomeView = {
        let view = HomeView(viewModel: CharacterHomeViewModel())
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = .systemBackground
    }

    internal func setupView() {

        view.addSubview(homeView)

        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
