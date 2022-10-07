//
//  CarouselCollectionViewCell.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 05/10/22.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    //MARK - Sub Views
    private lazy var imageView = UIImageView()
    
    //MARK - Properties
    static let cellId = "CarouselCell"
    
    //MARK - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK - Setups
private extension CarouselCollectionViewCell{
    func configUI(){
        backgroundColor = .blue
        
        addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 302).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 302).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
    }
}

//MARK - Public
extension CarouselCollectionViewCell {
    public func configure(image: UIImage?) {
        imageView.image = image
    }
}

