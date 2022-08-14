//
//  CategoryExplorerView.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/14/22.
//

import UIKit

enum Dimensions: CGFloat {
    case description = 13
    case message = 11
    case mainTitle = 17
    case contentTitle = 15
    
    var font: UIFont {
        switch self {
        case .mainTitle:
            return UIFont.boldSystemFont(ofSize: self.rawValue)
        default:
            return UIFont.systemFont(ofSize: self.rawValue)
        }
    }
}

class CategoryExplorerView: UIView {
    
    var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    private func commonInit(){
        vStack.addArrangedSubview(backgroundImageView)
        vStack.addArrangedSubview(topDescriptionLabel)
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(promoMessageLabel)
        vStack.addArrangedSubview(bottomDescriptionLabel)
        
        self.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            vStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            vStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    
    fileprivate var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Dimensions.mainTitle.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate var topDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Dimensions.description.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate var bottomDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Dimensions.description.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate var promoMessageLabel: UILabel = {
        let label = UILabel()
        label.font = Dimensions.message.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var image: UIImage? {
        didSet {
            backgroundImageView.image = image
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var topDescription: String? {
        didSet {
            if let description = topDescription {
                topDescriptionLabel.text = description
            } else {
                topDescriptionLabel.isHidden = true
            }
            
        }
    }
    
    var bottomDescription: String? {
        didSet {
            if let description = bottomDescription {
                bottomDescriptionLabel.text = description
            } else {
                bottomDescriptionLabel.isHidden = true
            }
            
        }
    }
    
    var promoMessage: String? {
        didSet {
            if let message = promoMessage {
                promoMessageLabel.text = message
            } else {
                promoMessageLabel.isHidden = true
            }
            
        }
    }
}
