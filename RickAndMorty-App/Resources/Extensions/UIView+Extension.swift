//
//  UIView+Extension.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import UIKit

extension UIView {
    /// Extension de UIView para la carga de componentes creados programáticamente.
    class func load<View: UIView>(
        _ callback: ((View) -> Void) = { _ in }
    ) -> View {
        let view = View()
        view.translatesAutoresizingMaskIntoConstraints = false
        callback(view)

        return view
    }

    func addSubviews(_ subviews: UIView...) { subviews.forEach { addSubview($0) } }

    func pinToEdges(of superView: UIView, with padding: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(
                equalTo: superView.topAnchor, constant: padding.top
            ),
            leadingAnchor.constraint(
                equalTo: superView.leadingAnchor, constant: padding.left
            ),
            trailingAnchor.constraint(
                equalTo: superView.trailingAnchor, constant: -padding.right
            ),
            bottomAnchor.constraint(
                equalTo: superView.bottomAnchor, constant: -padding.bottom
            )
        ])
    }

    @discardableResult
    func height(equalTo const: CGFloat) -> Self {
        heightAnchor.constraint(equalToConstant: const).isActive = true
        return self
    }

    @discardableResult
    func width(equalTo const: CGFloat) -> Self {
        widthAnchor.constraint(equalToConstant: const).isActive = true
        return self
    }

    func setRoundBorders(_ cornerRadius: CGFloat = 10.0) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }
}
