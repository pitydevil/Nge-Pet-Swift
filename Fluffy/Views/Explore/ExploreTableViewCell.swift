//
//  ExploreTableViewCell.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 19/10/22.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {

    //MARK: SubViews
    private lazy var exploreCard: ExploreCard = {
        let card = ExploreCard(petHotelName: "Pet Hotel Name", distance: "550m", supportedPet: [PetSupported(petType: "Anjing", size: "M")], lowestPrice: 30000, displayImage: "slide1")
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = UIColor(named: "white")
        
        return card
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(exploreCard)

        setupUI()
        setupConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Properties
    static let cellId = "ExploreTableViewCell"

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 24, bottom: 32, right: 24))
    }
}

//MARK: Setups
extension ExploreTableViewCell{
    func setupUI(){
        contentView.layer.masksToBounds = false
        contentView.layer.shadowRadius = 4.0
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 4, height: 4)
    }
    
    func setupConstraint(){
        exploreCard.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        exploreCard.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        exploreCard.heightAnchor.constraint(equalToConstant: 216).isActive = true
        exploreCard.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        exploreCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
