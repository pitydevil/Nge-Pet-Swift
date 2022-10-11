//
//  ReusableButtonV1.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 06/10/22.
//

import UIKit

class ReusableButton: UIButton {

    enum style {
        case normal
        case inverted
        case outline
        case disabled
        case longInverted
        case longOutline
    }
    
    public private(set) var titleBtn: String
    public private(set) var styleBtn: style
    public private(set) var icon: UIImage
    
    init(titleBtn:String, styleBtn: style, icon: UIImage? = nil) {
        self.titleBtn = titleBtn
        self.styleBtn = styleBtn
        self.icon = icon ?? UIImage()
        
        super.init(frame: .zero)
        self.configureButton()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton() {
        switch styleBtn {
        case .normal:
            self.configuration = .filled()
            self.configuration?.baseBackgroundColor = UIColor(named: "primaryMain")
            self.configuration?.baseForegroundColor = UIColor(named: "white")
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 48),
                self.widthAnchor.constraint(equalToConstant: 112),
            ])
        case .inverted:
            self.configuration = .filled()
            self.configuration?.baseBackgroundColor = UIColor(named: "white")
            self.configuration?.baseForegroundColor = UIColor(named: "primaryMain")
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 48),
                self.widthAnchor.constraint(equalToConstant: 112),
            ])
        case .outline:
            self.configuration = .bordered()
            self.configuration?.baseBackgroundColor = UIColor(named: "white")
            self.configuration?.background.strokeColor = UIColor(named: "primaryMain")
            self.configuration?.background.strokeWidth = 2.0
            self.configuration?.baseForegroundColor = UIColor(named: "primaryMain")
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 48),
                self.widthAnchor.constraint(equalToConstant: 112),
            ])
        case .disabled:
            self.configuration = .filled()
            self.configuration?.baseBackgroundColor = UIColor(named: "grey2")
            self.configuration?.baseForegroundColor = UIColor(named: "white")
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 48),
                self.widthAnchor.constraint(equalToConstant: 112),
            ])
        case .longInverted:
            self.configuration = .filled()
            self.configuration?.baseBackgroundColor = UIColor(named: "white")
            self.configuration?.baseForegroundColor = UIColor(named: "primaryMain")
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 48),
                self.widthAnchor.constraint(equalToConstant: 358),
            ])
        case .longOutline:
            self.configuration = .bordered()
            self.configuration?.baseBackgroundColor = UIColor(named: "white")
            self.configuration?.background.strokeColor = UIColor(named: "primaryMain")
            self.configuration?.background.strokeWidth = 2.0
            self.configuration?.baseForegroundColor = UIColor(named: "primaryMain")
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 48),
                self.widthAnchor.constraint(equalToConstant: 358),
            ])
        }
        self.configuration?.attributedTitle = AttributedString(titleBtn, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16)!]))
        self.translatesAutoresizingMaskIntoConstraints = false
        self.configuration?.image = icon
        if self.configuration?.image == UIImage() {
            self.configuration?.imagePadding = 0
        } else {
            self.configuration?.imagePadding = 8
        }
        self.configuration?.imagePlacement = .leading
        self.configuration?.titleAlignment = .leading
        self.configuration?.background.cornerRadius = 8
    }
    
}
