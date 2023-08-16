//
//  CharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import UIKit

class CharacterInfoCollectionViewCellViewModel {
    
    public let value: String
    private let type: `Type`
    
    public var title: String {
        type.displayTitle
    }
    
    public var displayValue: String {
        if value.isEmpty { return "Empty"}
        return value
    }

    public var iconImage: UIImage? {
        return type.iconImage
    }
    
    public var tintColor: UIColor {
        return type.iconTintColor
    }
    
    
    enum `Type`: String {
        case status
        case gender
        case species
        case location
        
        var iconTintColor: UIColor {
            switch self {
            case .status:
                return .systemBlue
            case .gender:
                return .systemGreen
            case .species:
                return .systemPurple
            case .location:
                return .systemGray
            }
        }
        
        var iconImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "person.text.rectangle")
            case .gender:
                return UIImage(systemName: "figure.dress.line.vertical.figure")
            case .species:
                return UIImage(systemName: "command.circle.fill")
            case .location:
                return UIImage(systemName: "globe")
            }
        }
        
        var displayTitle: String {
            switch self {
            case .status:
                return rawValue.uppercased()
            case .gender:
                return rawValue.uppercased()
            case .species:
                return rawValue.uppercased()
            case .location:
                return rawValue.uppercased()
            }
        }
    }
    
    init(
        type: `Type`,
        value: String
    )
    {
        self.type = type
        self.value = value
    }
}
