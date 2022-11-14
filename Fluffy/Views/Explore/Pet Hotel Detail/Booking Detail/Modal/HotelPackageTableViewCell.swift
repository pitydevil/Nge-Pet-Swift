//
//  HotelPackageTableViewCell.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 02/11/22.
//

import UIKit

class HotelPackageTableViewCell: UITableViewCell {
    
    static let identifier = "HotelPackageTableViewCell"
    
    private lazy var isSelect: Bool = false
    
    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "white")
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 4.0
        view.layer.shadowOpacity = 0.1
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        return view
    }()
    
    private lazy var packageTitle = ReuseableLabel(labelText: "Basic", labelType: .titleH2, labelColor: .black)
    
    private lazy var details = ReuseableLabel(labelText: "- Memakai kandang besi ukuran 60 cm \n- Memakai kandang besi ukuran 60 cm", labelType: .bodyP2, labelColor: .black)
    
    private lazy var redRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primary5")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return view
    }()
    
    private lazy var pricePackage = ReuseableLabel(labelText: "Rp 60.000", labelType: .titleH2, labelColor: .primaryMain)
    
    private lazy var priceDetails = ReuseableLabel(labelText: "/ hari", labelType: .bodyP2, labelColor: .grey1)
    
    private lazy var selectedView: UIView = {
        let view = UIView()
        let label = ReuseableLabel(labelText: "Selected", labelType: .titleH3, labelColor: .white)
        view.backgroundColor = UIColor(named: "primaryMain")
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        contentView.addSubview(container)
        
        //MARK: - Add Subview
        container.addSubview(packageTitle)
        container.addSubview(details)
        container.addSubview(redRectangle)
        
        redRectangle.addSubview(pricePackage)
        redRectangle.addSubview(priceDetails)
        
        //MARK: - Setup Constraint
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            packageTitle.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            packageTitle.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            
            details.topAnchor.constraint(equalTo: packageTitle.bottomAnchor, constant: 8),
            details.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            
            redRectangle.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            redRectangle.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            redRectangle.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            redRectangle.heightAnchor.constraint(equalToConstant: 48),
            
            priceDetails.centerYAnchor.constraint(equalTo: redRectangle.centerYAnchor),
            priceDetails.trailingAnchor.constraint(equalTo: redRectangle.trailingAnchor, constant: -20),
            
            pricePackage.centerYAnchor.constraint(equalTo: redRectangle.centerYAnchor),
            pricePackage.trailingAnchor.constraint(equalTo: priceDetails.leadingAnchor, constant: -4),
            
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - Public
extension HotelPackageTableViewCell {
    public func configure(_ package: PetHotelPackage) {
        var string = ""
        for package in package.packageDetail {
            string += "- \(package.packageDetailName)\n"
        }
        
        packageTitle.text = package.packageName
        details.text = string
        pricePackage.text = "Rp\(package.packagePrice)"
        
//        if select == true {
//            selectedCell()
//        } else {
//            normalState()
//        }
    }
    
    func selectedCell() {
        container.addSubview(selectedView)
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor(named: "primaryMain")?.cgColor
        
        NSLayoutConstraint.activate([
            selectedView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            selectedView.heightAnchor.constraint(equalToConstant: 24),
            selectedView.widthAnchor.constraint(equalToConstant: 93),
            selectedView.centerYAnchor.constraint(equalTo: redRectangle.centerYAnchor),
        ])
    }
    
    func normalState() {
        selectedView.removeFromSuperview()
        container.layer.borderWidth = 0
    }
}
