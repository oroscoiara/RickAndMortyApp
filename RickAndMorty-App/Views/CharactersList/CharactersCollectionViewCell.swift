//
//  CharactersCollectionViewCell.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import UIKit

/// Cell for a character.
class CharactersCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "characterCell"
    
    private lazy var imageView: UIImageView = .load { element in
        element.contentMode = .scaleAspectFill
        element.clipsToBounds = true
        element.layer.cornerRadius = 8
        element.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var characterNameLabel: UILabel = .load { element in
        element.textColor = .label
        element.font = .systemFont(ofSize: 14, weight: .bold)
        element.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var characterStatusLabel: UILabel = .load { element in
        element.textColor = .secondaryLabel
        element.font = .systemFont(ofSize: 12, weight: .regular)
        element.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var statusCircleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        contentView.addSubviews(imageView, characterNameLabel, characterStatusLabel, statusCircleView)
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Fatal Error")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        characterStatusLabel.text = nil
        characterNameLabel.text = nil
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: characterNameLabel.topAnchor, constant: -10),
            
            characterNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            characterNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            characterStatusLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 2),
            characterStatusLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            characterStatusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            statusCircleView.centerYAnchor.constraint(equalTo: characterStatusLabel.centerYAnchor),
                statusCircleView.trailingAnchor.constraint(equalTo: characterStatusLabel.leadingAnchor, constant: -8),
                statusCircleView.widthAnchor.constraint(equalToConstant: 10),
                statusCircleView.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    
    func configure(viewModel: CharactersCollectionViewCellModel) {
        characterNameLabel.text = viewModel.characterName
        characterStatusLabel.text = viewModel.characterStatusString

        switch viewModel.characterStatus {
          case .dead:
              statusCircleView.backgroundColor = .red
          case .alive:
              statusCircleView.backgroundColor = .green
          case .unknown:
              statusCircleView.backgroundColor = .gray
          }

        viewModel.getImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
