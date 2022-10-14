//
//  CarouselCollectionViewCell.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 05/10/22.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    
    // MARK: - SubViews
    private lazy var imageView = UIImageView()

    
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

private extension CarouselCollectionViewCell {
    func setupUI() {
        backgroundColor = .clear
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 310).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 310).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
    }
}

// MARK: - Public

extension CarouselCollectionViewCell {
    public func configure(image: UIImage?) {
        imageView.image = image
    }
}


