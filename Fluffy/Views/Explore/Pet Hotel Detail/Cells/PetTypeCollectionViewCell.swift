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
    
    private lazy var supportedPetSizeCollectionView:UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        layout.itemSize = CGSize(width: 12, height: 18)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(PetSizeCollectionViewCell.self, forCellWithReuseIdentifier: PetSizeCollectionViewCell.cellId)
        return collection
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
        self.addSubview(supportedPetSizeCollectionView)
        self.addSubview(information)
        
        icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        icon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 28).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 28).isActive = true

        petType.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 4).isActive = true
        petType.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        petType.heightAnchor.constraint(equalToConstant: 18).isActive = true

        supportedPetSizeCollectionView.backgroundColor = .clear
        supportedPetSizeCollectionView.topAnchor.constraint(equalTo: petType.bottomAnchor, constant: 4).isActive = true
        supportedPetSizeCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        supportedPetSizeCollectionView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        supportedPetSizeCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4).isActive = true
        supportedPetSizeCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4).isActive = true

        information.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        information.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
//

    }
}

// MARK: - Public

extension PetTypeCollectionViewCell {
    public func configure(type:String) {
        petType.text = type
        if type == "Anjing"{
            icon.image = UIImage(named: "dog-icon")
        }
        else{
            icon.image = UIImage(named: "cat-icon")
        }
    }
}


extension PetTypeCollectionViewCell:UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetSizeCollectionViewCell.cellId, for: indexPath) as? PetSizeCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .blue
        cell.configure(petSizeString: "S")

        return cell
    }
}

