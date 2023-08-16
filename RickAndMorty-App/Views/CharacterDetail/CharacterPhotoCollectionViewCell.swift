//
//  CharacterPhotoCollectionViewCell.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import UIKit

/// Cell for a character photo.
class CharacterPhotoCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "CharacterPhotoCollectionViewCell"
    
    private lazy var imageView: UIImageView = .load { element in
        element.clipsToBounds = true
        element.layer.masksToBounds = false
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        setUpConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    private func setUpConstraint() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    public func configure(with viewModel: CharacterPhotoCollectionViewCellViewModel) {
        viewModel.getImage { [weak self] result in
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                    
                }
            case .failure:
                break
            }
        }
        
    }
}
