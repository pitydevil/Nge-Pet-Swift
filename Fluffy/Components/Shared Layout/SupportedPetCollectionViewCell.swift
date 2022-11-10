//
//  SupportedPetCollectionViewCell.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 13/10/22.
//

import UIKit

class SupportedPetCollectionViewCell: UICollectionViewCell {
    
    // MARK: - SubViews
    private lazy var imageView = UIImageView()
    private lazy var petType:ReuseableLabel = ReuseableLabel(labelText: "Anjing", labelType: .titleH3, labelColor: .grey1)
    private lazy var petSize:ReuseableLabel = ReuseableLabel(labelText: "S,M", labelType: .bodyP2, labelColor: .grey1)
    
    // MARK: - Properties
    static let cellId = "SupportedPetCollectionViewCell"
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// MARK: - Setups

private extension SupportedPetCollectionViewCell {
    func imageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
    }
    
    func labelConstraints() {
        petType.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        petType.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4).isActive = true
        petType.widthAnchor.constraint(equalToConstant: 72).isActive = true
        petType.numberOfLines = 1
        
        petSize.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        petSize.topAnchor.constraint(equalTo: petType.bottomAnchor).isActive = true
        petSize.widthAnchor.constraint(equalToConstant: 72).isActive = true
        petSize.numberOfLines = 1
    }
    
    func setupUI() {
        backgroundColor = .clear
        
        addSubview(imageView)
        addSubview(petType)
        addSubview(petSize)
        
        self.heightAnchor.constraint(equalToConstant: 68).isActive = true
        self.widthAnchor.constraint(equalToConstant: 72).isActive = true
        
        imageViewConstraints()
        labelConstraints()
        
    }
}

// MARK: - Public
extension SupportedPetCollectionViewCell {
    func configure(_ petTypeString:String, _ supportedPetType: [SupportedPetType]) {
        var size = String()
        petType.text = petTypeString
        if petTypeString == "Anjing"{
                    imageView.image = UIImage(named: "dog-icon")
                }
                else{
                    imageView.image = UIImage(named: "cat-icon")
                }
        for supportedPet in supportedPetType {
            size += "\(supportedPet.supportedPetTypeShortSize), "
        }
        size.removeLast()
        size.removeLast()
        
        petSize.text = size
     }
}
