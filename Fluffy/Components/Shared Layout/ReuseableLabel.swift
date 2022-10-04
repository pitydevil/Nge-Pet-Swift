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
    
    public private(set) var labelType: labelTypeEnum
    public private(set) var labelText: String
    
    init(labelText: String, labelType: labelTypeEnum) {
        /// Safety check 1 “A designated initializer must ensure that all of the “properties introduced by its class are initialized before it delegates up to a superclass initializer.”
        self.labelText = labelText
        self.labelType = labelType
        
        super.init(frame: .zero)
        self.configureLabel()
    }
    
    // This is required to initialize
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // This is the setup default standard properties
    private func configureLabel() {
        
        self.text = labelText
        self.configureLabelStyle()
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
        
        // Will be executed all the time
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 0
        self.textAlignment = .left
    }
    
}
