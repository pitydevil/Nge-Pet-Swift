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

    //MARK: - Properties
    public private(set) var petHotelName:String
    public private(set) var distance:String
    public private(set) var supportedPet:[PetSupported]
    public private(set) var lowestPrice:Int
    public private(set) var displayImage:String
    
    //MARK: - Initializers
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
    
    //MARK: -Subviews
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

    private lazy var supportedPetView:UICollectionView = {
        let collection = UICollectionView()
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        
        return collection
    }()
}

extension ExploreCard{
    fileprivate func setup() {
        petHotelNameLabel.text = petHotelName
        distanceLabel.text = distance
        exploreImage.image = UIImage(named: displayImage)
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        if let formattedTipAmount = formatter.string(from: lowestPrice as NSNumber){
            priceLabel.text = "Rp" + formattedTipAmount
        }
    }
    
    fileprivate func imageConstraints() {
        exploreImage.contentMode = .scaleAspectFill
        exploreImage.clipsToBounds = true
        exploreImage.layer.cornerRadius = 12
        exploreImage.translatesAutoresizingMaskIntoConstraints = false
        exploreImage.widthAnchor.constraint(equalToConstant: 128).isActive = true
        exploreImage.heightAnchor.constraint(equalToConstant: 128).isActive = true
        exploreImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        exploreImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
    }
    
    fileprivate func petHotelNameConstraints() {
        petHotelNameLabel.leftAnchor.constraint(equalTo: exploreImage.rightAnchor, constant: 20).isActive = true
        petHotelNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        petHotelNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }
    
    fileprivate func distanceConstraints() {
        distanceLabel.leftAnchor.constraint(equalTo: exploreImage.rightAnchor, constant: 20).isActive = true
        distanceLabel.topAnchor.constraint(equalTo: petHotelNameLabel.bottomAnchor, constant: 8).isActive = true
        distanceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }
    
    fileprivate func priceConstraints() {
        redRectangle.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        redRectangle.heightAnchor.constraint(equalToConstant: 48).isActive = true
        redRectangle.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        redRectangle.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        redRectangle.layer.cornerRadius = 12
        redRectangle.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        
        priceLabel.centerYAnchor.constraint(equalTo: redRectangle.centerYAnchor).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -20).isActive = true
        priceLabel.textAlignment = .right
        
        
        BeforePriceLabel.rightAnchor.constraint(equalTo: priceLabel.leftAnchor, constant: -8).isActive = true
        BeforePriceLabel.centerYAnchor.constraint(equalTo: redRectangle.centerYAnchor).isActive = true
    }
    
    func setupLayout(){
        setup()
        
        self.addSubview(exploreImage)
        self.addSubview(petHotelNameLabel)
        self.addSubview(distanceLabel)
        self.addSubview(redRectangle)
        self.addSubview(priceLabel)
        self.addSubview(BeforePriceLabel)
        
        imageConstraints()
        petHotelNameConstraints()
        distanceConstraints()
        priceConstraints()
        
    }
}

extension ExploreCard: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
