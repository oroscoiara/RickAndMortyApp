//
//  Image+Title.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import UIKit

/// Component for getting a title, subtitle and image.
class ImageAndTitle: UIView {

    private lazy var contentStackView: UIStackView = .load { element in
        element.distribution = .fillProportionally
        element.axis = .vertical
        element.spacing = 10
        element.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
        element.isLayoutMarginsRelativeArrangement = true
    }

    lazy var imageView: UIView = .load()

    lazy var image: UIImageView = .load { element in
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
    }

    lazy var title: UILabel = .load { element in
        element.font = .systemFont(ofSize: 22, weight: .bold)
        element.textColor = .systemGray
        element.numberOfLines = 0
        element.textAlignment = .center
    }

    lazy var subtitle: UILabel = .load { element in
        element.font = .systemFont(ofSize: 22, weight: .regular)
        element.textColor = .systemGray
        element.numberOfLines = 0
        element.textAlignment = .center
    }

    private let labelLineSpacing: CGFloat = 10

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupTitle()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        self.addSubview(contentStackView)
        contentStackView.addArrangedSubview(imageView)
        contentStackView.addArrangedSubview(title)
        contentStackView.addArrangedSubview(subtitle)
        imageView.addSubviews(image)
    }

    private func setupTitle() {
        self.title.textAlignment = .center
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([

            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.topAnchor.constraint(equalTo: contentStackView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: title.topAnchor, constant: -26),

            title.widthAnchor.constraint(equalToConstant: 320),
            title.heightAnchor.constraint(equalToConstant: 50),
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: -12),

            image.widthAnchor.constraint(equalToConstant: 200),
            image.heightAnchor.constraint(equalToConstant: 200),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
