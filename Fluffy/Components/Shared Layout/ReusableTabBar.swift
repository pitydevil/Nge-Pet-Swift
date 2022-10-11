//
//  ReusableTabBar.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 07/10/22.
//

import UIKit

class ReusableTabBar: UIView {

    let barBtn = ReusableButton(titleBtn: "", styleBtn: .normal)
    
    let pilihSemuaText = ReuseableLabel(labelText: "Pilih Semua", labelType: .bodyP2, labelColor: .primaryMain)
    
    let hewanDipilih = ReuseableLabel(labelText: "Semua hewan dipilih", labelType: .bodyP2, labelColor: .grey1)
    
    let boxBtn = UIButton()
    let checkedImage = UIImage(systemName: "checkmark.square.fill")
    let uncheckedImage = UIImage(systemName: "checkmark.square")
    
    enum textBox {
        case show
        case notShow
    }
    
    public private(set) var btnText: String
    public private(set) var showText: textBox
    public private(set) var isChecked: Bool
    
    init(btnText: String, showText: textBox, isChecked: Bool) {
        self.btnText = btnText
        self.showText = showText
        self.isChecked = isChecked
        
        super.init(frame: .zero)
        
        
        self.configureLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureLayout() {
        switch showText {
        case .show:
            
            boxBtn.tintColor = UIColor(named: "primaryMain")
            
            if isChecked == false {
                boxBtn.setImage(uncheckedImage, for: .normal)
            } else {
                boxBtn.setImage(checkedImage, for: .normal)
            }
            
        case .notShow:
            pilihSemuaText.text = ""
            hewanDipilih.text = ""
            boxBtn.setImage(UIImage(), for: .normal)
        }
        
        barBtn.configuration?.attributedTitle = AttributedString(btnText, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16)!]))
        
        //MARK: - Set View Background
        self.backgroundColor = UIColor(named: "white")
        
        //MARK: - Add SubView
        self.addSubview(barBtn)
        self.addSubview(pilihSemuaText)
        self.addSubview(hewanDipilih)
        self.addSubview(boxBtn)
        
        //MARK: - Set Auto False
        self.translatesAutoresizingMaskIntoConstraints = false
        barBtn.translatesAutoresizingMaskIntoConstraints = false
        pilihSemuaText.translatesAutoresizingMaskIntoConstraints = false
        hewanDipilih.translatesAutoresizingMaskIntoConstraints = false
        boxBtn.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: - Setup Constraint
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 100),
            self.widthAnchor.constraint(equalToConstant: 390),
            
            barBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 254),
            barBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            
            hewanDipilih.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            hewanDipilih.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            
            boxBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22),
            boxBtn.bottomAnchor.constraint(equalTo: hewanDipilih.bottomAnchor, constant: 25),
            
            pilihSemuaText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            pilihSemuaText.bottomAnchor.constraint(equalTo: hewanDipilih.bottomAnchor, constant: 22),
            
        ])
        
    }

}
