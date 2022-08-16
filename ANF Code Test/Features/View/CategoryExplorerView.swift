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

@IBDesignable class CategoryExplorerView: UIView {
    
    private var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 6
        return stack
    }()
    
    private var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 6
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
        for sview in vStack.arrangedSubviews {
            vStack.removeArrangedSubview(sview)
        }
        
        vStack.addArrangedSubview(backgroundImageView)
        vStack.addArrangedSubview(topDescriptionLabel)
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(promoMessageLabel)
        vStack.addArrangedSubview(bottomDescriptionLabel)
        
        if !self.subviews.contains(vStack) {
            self.addSubview(vStack)
        }
        
        NSLayoutConstraint.activate([
            topDescriptionLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            promoMessageLabel.heightAnchor.constraint(equalToConstant: 20),
            bottomDescriptionLabel.heightAnchor.constraint(equalToConstant: 20),
            
            vStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            vStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            vStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            vStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
    fileprivate var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
        imageView.contentMode = .scaleToFill
        imageView.sizeToFit()
        imageView.backgroundColor = .yellow
        imageView.clipsToBounds = true
        return imageView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Dimensions.mainTitle.font
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate var topDescriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Dimensions.description.font
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate var bottomDescriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Dimensions.description.font
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate var promoMessageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Dimensions.message.font
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @IBInspectable var image: UIImage? {
        didSet {
            backgroundImageView.image = image
        }
    }
    
    @IBInspectable var imageUrl: String? {
        didSet {
            print(imageUrl)
            guard let url = imageUrl else { return }
            let img = UIImage(named: url)
            if img != nil {
                backgroundImageView.image = image
            } else {
                backgroundImageView.loadFrom(URLAddress: url)
            }
        }
    }
    
    @IBInspectable var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBInspectable var topDescription: String? {
        didSet {
            if let description = topDescription {
                topDescriptionLabel.text = description
            } else {
                topDescriptionLabel.isHidden = true
            }
        }
    }

    @IBInspectable var bottomDescription: String? {
        didSet {
            if let description = bottomDescription {
                bottomDescriptionLabel.text = description
                
                if let htmlData = description.data(using: .utf8) {
                    if let attributedString = try? NSAttributedString(
                        data: htmlData,
                        options: [.documentType: NSAttributedString.DocumentType.html,
                                  .characterEncoding: String.Encoding.utf8.rawValue],
                        documentAttributes: nil) {

                        let paragraph = NSMutableParagraphStyle()
                        paragraph.alignment = .center

                        let formatted = NSMutableAttributedString(attributedString: attributedString)
                        formatted.addAttributes([
                            NSAttributedString.Key.font: Dimensions.description.font,
                            NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel,
                            NSAttributedString.Key.paragraphStyle: paragraph
                        ], range: NSRange.init(location: 0, length: attributedString.length))

                        bottomDescriptionLabel.attributedText = formatted
                    }
                }
            } else {
                bottomDescriptionLabel.isHidden = true
            }
        }
    }
    
    @IBInspectable var promoMessage: String? {
        didSet {
            if let message = promoMessage {
                promoMessageLabel.text = message
            } else {
                promoMessageLabel.isHidden = true
            }
        }
    }
    
    var items: [(title: String, urlString: String)]? {
        didSet {
            for cview in contentStack.arrangedSubviews {
                contentStack.removeArrangedSubview(cview)
            }
            vStack.removeArrangedSubview(contentStack)
            guard let contentItems = items else { return }
            vStack.addArrangedSubview(contentStack)
            for item in contentItems {
                let contentButton = ContentButton()
                contentButton.setTitle(item.title, for: .normal)
                contentButton.urlString = item.urlString
                contentStack.addArrangedSubview(contentButton)
            }
        }
    }
    
    func resetView() {
        items = nil
    }
}
