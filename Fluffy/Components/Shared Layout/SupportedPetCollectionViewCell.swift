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
    private lazy var supportedPetSizeCollectionView:UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        layout.itemSize = CGSize(width: 12, height: 18)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.register(PetSizeCollectionViewCell.self, forCellWithReuseIdentifier: PetSizeCollectionViewCell.cellId)
        return collection
    }()
    
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
        petType.heightAnchor.constraint(equalToConstant: 18).isActive = true
        petType.numberOfLines = 1
        
        supportedPetSizeCollectionView.topAnchor.constraint(equalTo: petType.bottomAnchor).isActive = true
        supportedPetSizeCollectionView.leftAnchor.constraint(equalTo: petType.leftAnchor).isActive = true
        supportedPetSizeCollectionView.rightAnchor.constraint(equalTo: petType.rightAnchor, constant: -4).isActive = true
        supportedPetSizeCollectionView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        supportedPetSizeCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        supportedPetSizeCollectionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    
    func setupUI() {
        backgroundColor = .clear
        
        addSubview(imageView)
        addSubview(petType)
        addSubview(supportedPetSizeCollectionView)
        
        self.heightAnchor.constraint(equalToConstant: 68).isActive = true
        self.widthAnchor.constraint(equalToConstant: 72).isActive = true
        
        imageViewConstraints()
        labelConstraints()
        
    }
}

// MARK: - Public
extension SupportedPetCollectionViewCell {
    func configure(_ petTypeString:String) {
        petType.text = petTypeString
        if petTypeString == "Anjing"{
            imageView.image = UIImage(named: "dog-icon")
        }
        else if petTypeString == "Kucing"{
            imageView.image = UIImage(named: "cat-icon")
        }
    }
}

extension SupportedPetCollectionViewCell:UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetSizeCollectionViewCell.cellId, for: indexPath) as? PetSizeCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(petSizeString: "XL")
        cell.backgroundColor = .clear
        return cell
    }
}


