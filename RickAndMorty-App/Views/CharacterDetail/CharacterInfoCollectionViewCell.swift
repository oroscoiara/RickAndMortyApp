//
//  CharacterInfoCollectionViewCell.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import UIKit

/// Cell for the character' information.
class CharacterInfoCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier = "CharacterInfoCollectionViewCell"

    private lazy var valueLabel: UILabel = .load { element in
        element.numberOfLines = 0
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .systemFont(ofSize: 20, weight: .light)
    }

    private lazy var titleLabel: UILabel =  .load { element in
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 18, weight: .medium)
        element.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var iconImageView: UIImageView = .load { element in
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var titleContainerView: UIView = .load { element in
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .secondarySystemBackground
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(valueLabel, titleContainerView, iconImageView)
        titleContainerView.addSubview(titleLabel)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.masksToBounds = true

        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.separator.cgColor
        contentView.layer.masksToBounds = true

        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        valueLabel.text = nil
        titleLabel.text = nil
        iconImageView.image = nil
        iconImageView.tintColor = .label
        titleLabel.textColor = .label

    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.43),

            titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),

            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            valueLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: titleContainerView.topAnchor)
        ])
    }

    public func configure(with viewModel: CharacterInfoCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.displayValue
        iconImageView.image = viewModel.iconImage
        iconImageView.tintColor = viewModel.tintColor
        titleLabel.textColor = viewModel.tintColor

    }
}
