//
//  PetSizeCollectionViewCell.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 10/11/22.
//

import UIKit

class PetSizeCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let cellId = "PetSizeCollectionViewCell"
    
    // MARK: - SubViews
    private lazy var petSize:ReuseableLabel = ReuseableLabel(labelText: "S", labelType: .bodyP2, labelColor: .grey1)
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
}

// MARK: - Setups

private extension PetSizeCollectionViewCell {

    func labelConstraints() {
        petSize.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        petSize.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        petSize.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        petSize.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        petSize.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        petSize.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func setupUI() {
//        backgroundColor = .red
        addSubview(petSize)
        petSize.widthAnchor.constraint(equalToConstant: 18).isActive = true
        petSize.heightAnchor.constraint(equalToConstant: 18).isActive = true
//        labelConstraints()
    }
}

// MARK: - Public
extension PetSizeCollectionViewCell {
    func configure(petSizeString:String) {
        petSize.text = petSizeString
        print(petSizeString)
    }
}
