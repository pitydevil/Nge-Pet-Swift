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
    static let cellId = "CarouselCollectionViewCell"
    
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
    func setupUI() {
        backgroundColor = .clear
        
        addSubview(imageView)
        addSubview(petType)
        addSubview(petSize)
        
        self.heightAnchor.constraint(equalToConstant: 72).isActive = true
        self.widthAnchor.constraint(equalToConstant: 68).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        
        
    }
}

// MARK: - Public

extension SupportedPetCollectionViewCell {
    public func configure(image: UIImage?) {
        imageView.image = image
    }
}


