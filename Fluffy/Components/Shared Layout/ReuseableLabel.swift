//
//  ReuseableLabel.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 04/10/22.
//

import UIKit

class ReuseableLabel: UILabel {
    
    enum labelTypeEnum {
        case titleH1
        case titleH2
        case titleH3
        case bodyP1
        case bodyP2
    }
    
    enum colorStyle {
        case primaryMain
        case primary2
        case primary3
        case primary4
        case primary5
        
        case secondaryMain
        case secondary2
        case secondary3
        case secondary4
        case secondary5
        
        case black
        case grey1
        case grey2
        case grey3
        case white
        
        case success
        case warning
        case newError
    }
    
    public private(set) var labelType: labelTypeEnum
    public private(set) var labelText: String
    public private(set) var labelColor: colorStyle
    
    init(labelText: String, labelType: labelTypeEnum, labelColor: colorStyle) {
        self.labelText = labelText
        self.labelType = labelType
        self.labelColor = labelColor
        
        super.init(frame: .zero)
        self.configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabel() {
        self.configureLabelStyle()
        self.configureLabelColor()
    }
    
    private func configureLabelColor() {
        switch labelColor {
        case .primaryMain:
            self.textColor = UIColor(named: "primaryMain")
        case .primary2:
            self.textColor = UIColor(named: "primary2")
        case .primary3:
            self.textColor = UIColor(named: "primary3")
        case .primary4:
            self.textColor = UIColor(named: "primary4")
        case .primary5:
            self.textColor = UIColor(named: "primary5")
        case .secondaryMain:
            self.textColor = UIColor(named: "secondaryMain")
        case .secondary2:
            self.textColor = UIColor(named: "secondary2")
        case .secondary3:
            self.textColor = UIColor(named: "secondary3")
        case .secondary4:
            self.textColor = UIColor(named: "secondary4")
        case .secondary5:
            self.textColor = UIColor(named: "secondary5")
        case .black:
            self.textColor = UIColor(named: "black")
        case .grey1:
            self.textColor = UIColor(named: "grey1")
        case .grey2:
            self.textColor = UIColor(named: "grey2")
        case .grey3:
            self.textColor = UIColor(named: "grey3")
        case .white:
            self.textColor = UIColor(named: "white")
        case .success:
            self.textColor = UIColor(named: "success")
        case .warning:
            self.textColor = UIColor(named: "warning")
        case .newError:
            self.textColor = UIColor(named: "newError") 
        }
    }
    
    private func configureLabelStyle() {
        switch labelType {
        case .titleH1:
            self.font = UIFont(name: "Poppins-Bold", size: 24)
        case .titleH2:
            self.font = UIFont(name: "Poppins-Bold", size: 16)
        case .titleH3:
            self.font = UIFont(name: "Poppins-Bold", size: 12)
        case .bodyP1:
            self.font = UIFont(name: "Inter-Medium", size: 16)
        case .bodyP2:
            self.font = UIFont(name: "Inter-Medium", size: 12)
            
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 0
        self.textAlignment = .left
        let attributedString = NSMutableAttributedString(string: labelText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
}
