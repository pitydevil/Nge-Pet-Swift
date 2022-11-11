//
//  CarouselCollectionViewCell.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 05/10/22.
//

import UIKit
import SDWebImage

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
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
}

// MARK: - Public
extension CarouselCollectionViewCell {
    public func configure(_ petHotelImage : PetHotelImage) {
        imageView.sd_setImage(with: URL(string: petHotelImage.petHotelImageURL))
    }
    public func configureImage(_ urlString : String) {
        imageView.sd_setImage(with: URL(string: urlString))
    }
}
