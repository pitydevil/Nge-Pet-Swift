//
//  PetHotelDetailTableViewCell.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 25/10/22.
//

import UIKit

class PetHotelDetailTableViewCell: UITableViewCell {
    //MARK: SubViews
    private lazy var icon:UIImageView = {
       let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var descriptionLabel:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "", labelType: .bodyP1, labelColor: .grey1)
        return label
    }()
    
    //MARK: Properties
    static let cellId = "PetHotelDetailTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(icon)
        contentView.addSubview(descriptionLabel)
        
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
    }
    

}

//MARK: Setups
extension PetHotelDetailTableViewCell{
    func setupConstraint(){
        icon.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        icon.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 12).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }
}

// MARK: - Public
extension PetHotelDetailTableViewCell {
    func configureView(tabelType:String, description:String) {
        if tabelType == "rules"{
            icon.image = UIImage(named: "carbon_rule-filled")
        }
        else if tabelType == "asuransi"{
            icon.image = UIImage(named: "material-symbols_assured-workload-rounded")
        }
        
        descriptionLabel.text = description
    }
}
