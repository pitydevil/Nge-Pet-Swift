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
        case frameless
        case light
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
            self.configuration?.imagePlacement = .leading
            self.configuration?.attributedTitle = AttributedString(titleBtn, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16)!]))
            
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 48),
                self.widthAnchor.constraint(greaterThanOrEqualToConstant: 112),
            ])
            
        case .inverted:
            self.configuration = .filled()
            self.configuration?.baseBackgroundColor = UIColor(named: "white")
            self.configuration?.baseForegroundColor = UIColor(named: "primaryMain")
            self.configuration?.imagePlacement = .leading
            self.configuration?.attributedTitle = AttributedString(titleBtn, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16)!]))
            
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 48),
                self.widthAnchor.constraint(greaterThanOrEqualToConstant: 112),
            ])
        case .outline:
            self.configuration = .bordered()
            self.configuration?.baseBackgroundColor = UIColor(named: "white")
            self.configuration?.background.strokeColor = UIColor(named: "primaryMain")
            self.configuration?.background.strokeWidth = 2.0
            self.configuration?.baseForegroundColor = UIColor(named: "primaryMain")
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 48),
                self.widthAnchor.constraint(greaterThanOrEqualToConstant: 112),
            ])
            self.configuration?.imagePlacement = .leading
            self.configuration?.attributedTitle = AttributedString(titleBtn, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16)!]))
        case .disabled:
            self.configuration = .filled()
            self.configuration?.baseBackgroundColor = UIColor(named: "grey2")
            self.configuration?.baseForegroundColor = UIColor(named: "white")
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 48),
                self.widthAnchor.constraint(greaterThanOrEqualToConstant: 112),
            ])
            self.configuration?.imagePlacement = .leading
            self.configuration?.attributedTitle = AttributedString(titleBtn, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16)!]))
        case .longInverted:
            self.configuration = .filled()
            self.configuration?.baseBackgroundColor = UIColor(named: "white")
            self.configuration?.baseForegroundColor = UIColor(named: "primaryMain")
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 48),
                self.widthAnchor.constraint(greaterThanOrEqualToConstant: 358),
            ])
            self.configuration?.imagePlacement = .leading
            self.configuration?.attributedTitle = AttributedString(titleBtn, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16)!]))
        case .longOutline:
            self.configuration = .bordered()
            self.configuration?.baseBackgroundColor = UIColor(named: "white")
            self.configuration?.background.strokeColor = UIColor(named: "primaryMain")
            self.configuration?.background.strokeWidth = 2.0
            self.configuration?.baseForegroundColor = UIColor(named: "primaryMain")
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 48),
                self.widthAnchor.constraint(greaterThanOrEqualToConstant: 358),
            ])
            self.configuration?.imagePlacement = .leading
            self.configuration?.attributedTitle = AttributedString(titleBtn, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16)!]))
        case .frameless:
            self.configuration = .plain()
            self.configuration?.baseForegroundColor = UIColor(named: "black")
            self.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            self.configuration?.imagePlacement = .trailing
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 48),
                self.widthAnchor.constraint(lessThanOrEqualToConstant: 193),
            ])
            self.configuration?.attributedTitle = AttributedString(titleBtn, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16)!]))
        case .light:
            self.configuration = .plain()
            self.configuration?.baseForegroundColor = UIColor(named: "grey1")
            self.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            self.configuration?.imagePlacement = .trailing
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 48),
                self.widthAnchor.constraint(lessThanOrEqualToConstant: 193),
            ])
            self.configuration?.attributedTitle = AttributedString(titleBtn, attributes: AttributeContainer([NSAttributedString.Key.font: UIFont(name: "Inter-Medium", size: 12)!, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]))
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.configuration?.image = icon
        if self.configuration?.image == UIImage() {
            self.configuration?.imagePadding = 0
        } else {
            self.configuration?.imagePadding = 8
        }
        self.configuration?.titleAlignment = .leading
        self.configuration?.background.cornerRadius = 8
    }
}
