//
//  TabBarViewControllerTest.swift
//  RickAndMorty-AppTests
//
//  Created by Iara Denise Orosco on 15/08/2023.
//

import Quick
import Nimble
@testable import RickAndMorty_App

// MARK: - TabBarViewControllerTest Section

/// Tests de TabBarViewController.
class TabBarViewControllerSpec: QuickSpec {
    override func spec() {
        describe("TabBarViewController") {
            var viewController: TabBarViewController!

            beforeEach {
                viewController = TabBarViewController()
                _ = viewController.view
            }

            it("should toggle dark mode and update UI style") {
                var initialStyle = viewController.overrideUserInterfaceStyle
                initialStyle = .light

                viewController.toggleDarkMode()

                expect(viewController.overrideUserInterfaceStyle).to(equal(UIUserInterfaceStyle.dark))

                viewController.toggleDarkMode()

                expect(viewController.overrideUserInterfaceStyle).to(equal(UIUserInterfaceStyle.light))
            }

            it("should update mode switch button image") {
                let modeSwitchButton = UIBarButtonItem()
                viewController.isDarkMode = false

                viewController.updateModeSwitchButtonImage(for: modeSwitchButton)
                expect(modeSwitchButton.image).to(equal(UIImage(systemName: "moon.circle.fill")))

                viewController.isDarkMode = true
                viewController.updateModeSwitchButtonImage(for: modeSwitchButton)
                expect(modeSwitchButton.image).to(equal(UIImage(systemName: "sun.max.fill")))

                viewController.isDarkMode = false
                viewController.updateModeSwitchButtonImage(for: modeSwitchButton)
                expect(modeSwitchButton.image).to(equal(UIImage(systemName: "moon.circle.fill")))
            }
        }
    }
}
