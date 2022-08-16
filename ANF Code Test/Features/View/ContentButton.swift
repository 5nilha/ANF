//
//  ContentButton.swift
//  ANF Code Test
//
//  Created by Fabio Quintanilha on 8/15/22.
//

import UIKit

@IBDesignable class ContentButton: UIButton {
    
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
    
    func commonInit() {
        setupView()
    }
    
    @IBInspectable var urlString: String? {
        didSet {
            addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        }
    }
    
    @objc private func didTapButton() {
        guard let urlString = self.urlString,
              let url = URL(string: urlString) else { return }
        if #available(iOS 10, *){
            UIApplication.shared.open(url)
        } else{
            UIApplication.shared.openURL(url)
        }
    }
    
    private func setupView() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2.0
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = Dimensions.contentTitle.font
    }
}
