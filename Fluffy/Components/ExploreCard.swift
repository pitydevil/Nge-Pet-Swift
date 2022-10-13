//
//  ExploreCard.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 12/10/22.
//

import UIKit

struct PetSupported{
    let petType:String
    let size:String
}

struct PetHotelList{
    let petHotelName:String
    let petHotelDistance:String
    let supportedPet:[PetSupported]
    let lowestPrice:Int
    let displayImage:String
}

class ExploreCard: UIView {

    public private(set) var petHotelName:String
    public private(set) var distance:String
    public private(set) var supportedPet:[PetSupported]
    public private(set) var lowestPrice:Int
    public private(set) var displayImage:String
    
    init(petHotelName: String, distance: String, supportedPet: [PetSupported], lowestPrice: Int, displayImage:String) {
        self.petHotelName = petHotelName
        self.distance = distance
        self.supportedPet = supportedPet
        self.lowestPrice = lowestPrice
        self.displayImage = displayImage
        super.init(frame: .zero)
        setupLayout()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var exploreImage = UIImageView()
    var redRectangle:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(named: "primary5")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var petHotelNameLabel:ReuseableLabel = ReuseableLabel(labelText: "Pet Hotel", labelType: .titleH2, labelColor: .black)
    private lazy var distanceLabel:ReuseableLabel = ReuseableLabel(labelText: "500m", labelType: .bodyP2, labelColor: .grey1)
    private lazy var BeforePriceLabel:ReuseableLabel = ReuseableLabel(labelText: "Perlahan mulai dari", labelType: .bodyP2, labelColor: .grey1)
    private lazy var priceLabel:ReuseableLabel = ReuseableLabel(labelText: "Rp 30.000", labelType: .titleH2, labelColor: .primaryMain)
    
    
    func setupLayout(){
        exploreImage.image = UIImage(named: "slide2")
        self.addSubview(exploreImage)
        exploreImage.contentMode = .scaleAspectFill
        exploreImage.clipsToBounds = true
        exploreImage.layer.cornerRadius = 12
        exploreImage.translatesAutoresizingMaskIntoConstraints = false
        exploreImage.widthAnchor.constraint(equalToConstant: 128).isActive = true
        exploreImage.heightAnchor.constraint(equalToConstant: 128).isActive = true
        exploreImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        exploreImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        
        
        self.addSubview(petHotelNameLabel)
        petHotelNameLabel.leftAnchor.constraint(equalTo: exploreImage.rightAnchor, constant: 20).isActive = true
        petHotelNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        petHotelNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
        self.addSubview(distanceLabel)
        distanceLabel.leftAnchor.constraint(equalTo: exploreImage.rightAnchor, constant: 20).isActive = true
        distanceLabel.topAnchor.constraint(equalTo: petHotelNameLabel.bottomAnchor, constant: 8).isActive = true
        distanceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
        self.addSubview(redRectangle)
        redRectangle.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        redRectangle.heightAnchor.constraint(equalToConstant: 48).isActive = true
        redRectangle.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        redRectangle.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        redRectangle.layer.cornerRadius = 12
        redRectangle.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        self.addSubview(priceLabel)
        priceLabel.centerYAnchor.constraint(equalTo: redRectangle.centerYAnchor).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -20).isActive = true
        priceLabel.textAlignment = .right
        
        self.addSubview(BeforePriceLabel)
        BeforePriceLabel.rightAnchor.constraint(equalTo: priceLabel.leftAnchor, constant: -8).isActive = true
        BeforePriceLabel.centerYAnchor.constraint(equalTo: redRectangle.centerYAnchor).isActive = true
        
    }
}
