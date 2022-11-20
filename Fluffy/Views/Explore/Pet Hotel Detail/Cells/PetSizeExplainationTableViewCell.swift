//
//  PetSizeExplainationTableViewCell.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 25/10/22.
//

import UIKit

class PetSizeExplainationTableViewCell: UITableViewCell {
    
    //MARK: SubViews
    private lazy var petType:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "", labelType: .titleH2, labelColor: .black)
        return label
    }()
    
    private lazy var descriptionLabel:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "", labelType: .bodyP1, labelColor: .grey1)
        return label
    }()
    
    //MARK: Properties
    static let cellId = "PetHotelDetailTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(petType)
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
extension PetSizeExplainationTableViewCell{
    func setupConstraint(){
        petType.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        petType.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        petType.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: petType.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: petType.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }
}

// MARK: - Public
extension PetSizeExplainationTableViewCell {
    func configureView(_ supportedPetType : SupportedPetTypeDetail) {
        petType.text          = "Kucing \(supportedPetType.supportedPetTypeSize) (\(supportedPetType.supportedPetTypeShortSize)) "
        descriptionLabel.text = supportedPetType.supportedPetTypeDescription
    }
}
