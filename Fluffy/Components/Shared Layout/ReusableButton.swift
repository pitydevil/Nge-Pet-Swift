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
    public private(set) var action: Selector
    public private(set) var target: Any
    
    init(titleBtn:String, styleBtn: style, icon: UIImage, _ action: Selector, _ target: Any) {
        self.titleBtn = titleBtn
        self.styleBtn = styleBtn
        self.icon = icon
        self.action = action
        self.target = target
        
        super.init(frame: .zero)
        self.configureButton()
        self.configureButtonTarget()
        
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
        self.configuration?.imagePadding = 8
        self.configuration?.titleAlignment = .center
        self.configuration?.background.cornerRadius = 8
    }
    
    private func configureButtonTarget() {
        addTarget(target, action: action, for: .touchUpInside)
    }
}
