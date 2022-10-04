//
//  SwitchSelect.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 04/10/22.
//

import UIKit

class SwitchSelect: UIView {
    
    let switchControl = UISwitch()
    let labelSelect = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSwitch()
        
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        labelSelect.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(switchControl)
        NSLayoutConstraint.activate([
            switchControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            switchControl.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        self.addSubview(labelSelect)
        labelSelect.text = switchControl.isOn ? "Selected" : "Not Selected"
        labelSelect.textColor = UIColor(named: "white")
        labelSelect.font = UIFont(name: "Poppins-Bold", size: 16)
        NSLayoutConstraint.activate([
            labelSelect.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelSelect.topAnchor.constraint(equalTo: switchControl.bottomAnchor, constant: 8)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSwitch(){
        switchControl.onTintColor = UIColor(red: 0.98, green: 0.96, blue: 0.96, alpha: 1.00)
        switchControl.subviews[0].subviews[0].backgroundColor = UIColor(red: 0.73, green: 0.71, blue: 0.71, alpha: 1.00)
        switchControl.setOn(false, animated: true)
        switchControl.addTarget(self, action: #selector(updateSwitch), for: .valueChanged)
    }
    
    @objc func updateSwitch(){
        labelSelect.text = switchControl.isOn ? "Selected" : "Not Selected"
        switchControl.thumbTintColor = switchControl.isOn ? UIColor(red: 0.89, green: 0.27, blue: 0.37, alpha: 1.00) : UIColor(red: 0.98, green: 0.96, blue: 0.96, alpha: 1.00)
    }
}
