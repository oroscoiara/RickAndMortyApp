//
//  TabBarViewController.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import UIKit
import SwiftUI

/// Controller to configure tabs and roots controllers
class TabBarViewController: UITabBarController {

    internal var isDarkMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpTabBar()
    }

    private func setUpTabBar() {
        let homeVC = CharacterHomeViewController()
        let charactersVC = CharactersListViewController()

        let episodeDetailView = EpisodeDetailView()
        let episodesVC = UIHostingController(rootView: episodeDetailView)

        homeVC.navigationItem.largeTitleDisplayMode = .automatic
        charactersVC.navigationItem.largeTitleDisplayMode = .automatic
        episodesVC.navigationItem.largeTitleDisplayMode = .automatic

        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: charactersVC)
        let nav3 = UINavigationController(rootViewController: episodesVC)

        if nav2.tabBarItem.tag == 2 {
            nav2.navigationItem.searchController = charactersVC.searchController
            nav2.navigationItem.hidesSearchBarWhenScrolling = false
        }

        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person.fill"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv.fill"), tag: 3)

        for nav in [nav1, nav2, nav3] {
            nav.navigationBar.prefersLargeTitles = true

            let modeSwitchButton = UIBarButtonItem(image: UIImage(systemName: "moon.circle.fill"), style: .plain, target: self, action: #selector(toggleDarkMode))
            nav.topViewController?.navigationItem.rightBarButtonItem = modeSwitchButton

            if let modeSwitchButton = nav.topViewController?.navigationItem.rightBarButtonItem {
                updateModeSwitchButtonImage(for: modeSwitchButton)
            }
        }

        setViewControllers(
            [nav1, nav2, nav3],
            animated: true)
    }

    /// Toggles the dark mode on or off and updates the UI style accordingly.
    @objc internal func toggleDarkMode() {
        isDarkMode.toggle()
        updateUIStyle()
    }

    /// Updates the user interface style based on the value of `isDarkMode`.
    private func updateUIStyle() {
        overrideUserInterfaceStyle = isDarkMode ? .dark : .light

        for nav in [viewControllers?[0], viewControllers?[1], viewControllers?[2]].compactMap({ $0 as? UINavigationController }) {
            if let modeSwitchButton = nav.topViewController?.navigationItem.rightBarButtonItem {
                updateModeSwitchButtonImage(for: modeSwitchButton)
            }
        }
    }

    /// Updates the modeSwitchButtonImage based on the value of `isDarkMode`.
    internal func updateModeSwitchButtonImage(for button: UIBarButtonItem) {
        let modeSwitchButtonImage = isDarkMode ? UIImage(systemName: "sun.max.fill") : UIImage(systemName: "moon.circle.fill")
        button.image = modeSwitchButtonImage
    }
}
