//
//  CharacterEpisodeCollectionViewCell.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import UIKit

/// Cell for a character' episode.
class CharacterEpisodeCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier = "CharacterEpisodeCollectionViewCell"

    private lazy var seasonLabel: UILabel = .load { element in
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .systemFont(ofSize: 16, weight: .regular)
    }


    private lazy var nameLabel: UILabel = .load { element in
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .systemFont(ofSize: 20, weight: .semibold)
    }

    private lazy var airDateLabel: UILabel = .load { element in
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .systemFont(ofSize: 14, weight: .light)
        element.textColor = .lightGray
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        setUpLayer()
        contentView.addSubviews(seasonLabel, nameLabel, airDateLabel)
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setUpLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        seasonLabel.text = nil
        nameLabel.text = nil
        airDateLabel.text = nil
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            seasonLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            seasonLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            seasonLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),

            nameLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),

            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            airDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            airDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            airDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
        ])
    }

    public func configure(with viewModel: CharacterEpisodeCollectionViewCellViewModel) {
        viewModel.registerForData { [weak self] data in
            self?.nameLabel.text = data.name
            self?.seasonLabel.text = "Episode "+data.episode
            self?.airDateLabel.text = "Aired on"+data.air_date
        }
        viewModel.getEpisode()
        contentView.layer.borderColor = viewModel.borderColor.cgColor
    }
}
