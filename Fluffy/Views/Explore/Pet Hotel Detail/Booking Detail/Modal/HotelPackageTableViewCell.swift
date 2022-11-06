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
        
        //MARK: - Setup Cell
        self.backgroundColor = UIColor(named: "grey3")
        self.selectionStyle = .none
        
        contentView.layer.cornerRadius = 12
        
        contentView.layer.masksToBounds = false
        contentView.layer.shadowRadius = 4.0
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        //MARK: - Setup Autoresizingmask false
        
        //MARK: - Add Subview
        contentView.addSubview(packageTitle)
        contentView.addSubview(details)
        contentView.addSubview(redRectangle)
        
        redRectangle.addSubview(pricePackage)
        redRectangle.addSubview(priceDetails)
        
        //MARK: - Setup Constraint
        NSLayoutConstraint.activate([
            packageTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            packageTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            details.topAnchor.constraint(equalTo: packageTitle.bottomAnchor, constant: 8),
            details.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            redRectangle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            redRectangle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            redRectangle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//MARK: - Public
extension HotelPackageTableViewCell {
    public func configure(title: String, detail: String, price: String, select: Bool) {
        packageTitle.text = title
        details.text = detail
        pricePackage.text = price
       
        if select == true {
            selectedCell()
        } else {
            normalState()
        }
    }
    
    func selectedCell() {
        contentView.addSubview(selectedView)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(named: "primaryMain")?.cgColor
        
        NSLayoutConstraint.activate([
            selectedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            selectedView.heightAnchor.constraint(equalToConstant: 24),
            selectedView.widthAnchor.constraint(equalToConstant: 93),
            selectedView.centerYAnchor.constraint(equalTo: redRectangle.centerYAnchor),
        ])
    }
    
    func normalState() {
        selectedView.removeFromSuperview()
        contentView.layer.borderWidth = 0
    }
}
