//
//  HomeView.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import UIKit

/// View that shows and loads the home section and its components.
class HomeView: UIView {

    let viewModel: CharacterHomeViewModel
    weak var delegate: HomeViewDelegate?

    internal lazy var imageAndTitle: ImageAndTitle = .load { element in
        element.translatesAutoresizingMaskIntoConstraints = false
    }

    internal lazy var buttonsContainer: ButtonsContainer = .load { element in
        element.translatesAutoresizingMaskIntoConstraints = false
    }

    internal lazy var contentView: UIView = .load { element in
        element.backgroundColor = .systemBackground
        element.translatesAutoresizingMaskIntoConstraints = false
    }

    init(viewModel: CharacterHomeViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        setUpIcons()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(imageAndTitle)
        addSubview(buttonsContainer)
        backgroundColor = .systemBackground
        addSubview(contentView)
        contentView.addSubview(imageAndTitle)
        contentView.addSubview(buttonsContainer)

    }

    @objc private func buttonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            sender.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        })
    }

    /// Sets up the icons attributes.
    private func setUpIcons() {
        imageAndTitle.image.image = UIImage(named: "RYM3Logo")
        imageAndTitle.title.text = "Welcome"
        imageAndTitle.subtitle.text = "Explore the universe with Rick and Morty"

        for (index, service) in StreamingService.allCases.enumerated() {
            let serviceImage = UIImage(systemName: service.iconName)
            let serviceText = "Watch on \(service)"
            let serviceIcon = ReusableIcon()
            serviceIcon.setData(image: serviceImage ?? UIImage(), text: serviceText)
            serviceIcon.button.tintColor = .systemIndigo
            serviceIcon.button.tag = index

            serviceIcon.button.addTarget(self, action: #selector(streamingButtonTapped(_:)), for: .touchUpInside)
            serviceIcon.button.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)

            buttonsContainer.contentStackView.addArrangedSubview(serviceIcon)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),

            imageAndTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageAndTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),

            buttonsContainer.topAnchor.constraint(equalTo: imageAndTitle.bottomAnchor, constant: 20),
            buttonsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            buttonsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            buttonsContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    /// Handles the action when a streaming service button is tapped.
    ///
    /// - Parameter sender: The UIButton that triggered the action.
    @objc public func streamingButtonTapped(_ sender: UIButton) {
        if let service = StreamingService(rawValue: sender.tag) {
            if let url = viewModel.getUrl(for: service) {
                delegate?.didTapStreamingService(service, openURL: url)
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
