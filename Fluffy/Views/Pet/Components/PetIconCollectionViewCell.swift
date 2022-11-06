//
//  PetIconCollectionViewCell.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 27/10/22.
//

import UIKit

class PetIconCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellId = "PetIconCollectionViewCell"
    
    var isSelect = false
    
    let petImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "dog9")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor(named: "white")
        
        contentView.layer.cornerRadius = 8
        
        contentView.addSubview(petImageView)
        
        NSLayoutConstraint.activate([
            petImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            petImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(_ imageName : String) {
        petImageView.image = UIImage(named: imageName)
    }
}
