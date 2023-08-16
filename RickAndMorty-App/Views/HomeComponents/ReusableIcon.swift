//
//  ReusableIcon.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import UIKit

/// Component for getting a button with a label.
class ReusableIcon: UIView {

    private lazy var contentStackView: UIStackView = .load { element in
        element.axis = .vertical
        element.spacing = 4
        element.distribution = .fill
        element.alignment = .center
    }

    public lazy var button: UIButton = .load { element in
        element.tintColor = .systemGray
        element.backgroundColor = .clear
        element.layer.cornerRadius = 25
        element.layer.borderWidth = 0.1
        element.layer.borderColor = UIColor.gray.cgColor
    }

    public lazy var sectionLabel: UILabel = .load { element in
        element.font = element.font.withSize(12.00)
        element.textColor = .systemGray
        element.numberOfLines = 0
        element.textAlignment = .center
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupConstraints()
    }

    private func setupView() {
        self.addSubview(contentStackView)
        contentStackView.addArrangedSubview(button)
        contentStackView.addArrangedSubview(sectionLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentStackView.widthAnchor.constraint(equalToConstant: 56)
        ])

        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 48),
            button.widthAnchor.constraint(equalToConstant: 48)
        ])
    }

    public func setData(image: UIImage, text: String) {
        self.button.setImage(image, for: .normal)
        self.button.setImage(image, for: .highlighted)
        self.sectionLabel.text = text
    }
}
