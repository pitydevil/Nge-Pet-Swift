//
//  PetTypeCollectionViewCell.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 25/10/22.
//

import UIKit

class PetTypeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - SubViews
    private lazy var icon:UIImageView = {
       let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var information:UIImageView = {
       let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "info.circle")
        imageView.tintColor = UIColor(named: "secondaryMain")
        return imageView
    }()

    private lazy var petType:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "Anjing", labelType: .bodyP2, labelColor: .grey1)
        return label
    }()
    
    private lazy var size:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "S,M,L", labelType: .bodyP2, labelColor: .grey1)
        return label
    }()
    
    // MARK: - Properties
    static let cellId = "CarouselCollectionViewCell"
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        setupUI()
        backgroundColor = UIColor(named: "grey3")
        self.layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// MARK: - Setups
private extension PetTypeCollectionViewCell {
    func setupUI() {
        backgroundColor = .clear
        
        self.addSubview(icon)
        self.addSubview(petType)
        self.addSubview(size)
        self.addSubview(information)
        
        icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        icon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 28).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 28).isActive = true

        petType.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 4).isActive = true
        petType.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        size.topAnchor.constraint(equalTo: petType.bottomAnchor,constant: 4).isActive = true
        size.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        size.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true

        information.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        information.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
    }
}

extension PetTypeCollectionViewCell {
    func configure(_ supportedPet : SupportedPet, _ supportedPetTypeDetail : [SupportedPetTypeDetail]) {
        
        var sizeString = String()
        petType.text = supportedPet.supportedPetName
       
        for pet in supportedPetTypeDetail {
            sizeString += "\(pet.supportedPetTypeShortSize), "
        }
        
        sizeString.removeLast()
        sizeString.removeLast()
        
        size.text = sizeString
        if supportedPet.supportedPetName == "Anjing"{
            icon.image = UIImage(named: "dog-icon")
        }else{
            icon.image = UIImage(named: "cat-icon")
        }
    }
}



