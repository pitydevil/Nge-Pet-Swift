//
//  ModalMonitoringTableViewCell.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 13/10/22.
//

import UIKit

class ModalMonitoringTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellId = "ModalMonitoringTableViewCell"
    
    var petName = ReuseableLabel(labelText: "Bom Bom", labelType: .bodyP2, labelColor: .grey1)
    
    let petIcon = UIImageView()
    
    let checkedImage = UIImageView()
    
    var isCheck: Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //MARK: - Setup Cell
        self.backgroundColor = UIColor(named: "white")
        self.selectionStyle = .none
        
        contentView.layer.cornerRadius = 8
        
        //MARK: - Setup Autoresizingmask false
        petName.translatesAutoresizingMaskIntoConstraints = false
        petIcon.translatesAutoresizingMaskIntoConstraints = false
        checkedImage.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: - Add Subview
        contentView.addSubview(petName)
        
        contentView.addSubview(petIcon)
        petIcon.image = UIImage(systemName: "pawprint.fill")
        petIcon.tintColor = UIColor(named: "primaryMain")
        
        contentView.addSubview(checkedImage)
        checkedImage.image = UIImage()
        checkedImage.tintColor = UIColor(named: "primaryMain")
        
        //MARK: - Setup Constraint
        NSLayoutConstraint.activate([
            petIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            petIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            
            petName.leadingAnchor.constraint(equalTo: petIcon.trailingAnchor, constant: 8),
            petName.centerYAnchor.constraint(equalTo: petIcon.centerYAnchor),
            
            checkedImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            checkedImage.centerYAnchor.constraint(equalTo: petIcon.centerYAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
