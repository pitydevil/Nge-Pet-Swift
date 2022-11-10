//
//  ExploreCard.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 12/10/22.
//

import UIKit

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
        self.backgroundColor = UIColor(named: "white")
        self.layer.cornerRadius = 12
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 216).isActive = true
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
    private lazy var BeforePriceLabel:ReuseableLabel = ReuseableLabel(labelText: "Perhari mulai dari", labelType: .bodyP2, labelColor: .grey1)
    private lazy var priceLabel:ReuseableLabel = ReuseableLabel(labelText: "Rp 30.000", labelType: .titleH2, labelColor: .primaryMain)

    private lazy var supportedPetView:UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(SupportedPetCollectionViewCell.self, forCellWithReuseIdentifier: SupportedPetCollectionViewCell.cellId)
//        collection.
        return collection
    }()
}

//MARK: - Setups

extension ExploreCard{
    func setup() {
        petHotelNameLabel.text = petHotelName
        petHotelNameLabel.numberOfLines = 1
        distanceLabel.text = distance
        distanceLabel.numberOfLines = 1
        exploreImage.image = UIImage(named: displayImage)
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        if let formattedTipAmount = formatter.string(from: lowestPrice as NSNumber){
            priceLabel.text = "Rp" + formattedTipAmount
        }
    }
    
    func imageConstraints() {
        exploreImage.contentMode = .scaleAspectFill
        exploreImage.clipsToBounds = true
        exploreImage.layer.cornerRadius = 12
        exploreImage.translatesAutoresizingMaskIntoConstraints = false
        exploreImage.widthAnchor.constraint(equalToConstant: 128).isActive = true
        exploreImage.heightAnchor.constraint(equalToConstant: 128).isActive = true
        exploreImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        exploreImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
    }
    
    func petHotelNameConstraints() {
        petHotelNameLabel.leftAnchor.constraint(equalTo: exploreImage.rightAnchor, constant: 20).isActive = true
        petHotelNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        petHotelNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        petHotelNameLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }
    
    func distanceConstraints() {
        distanceLabel.leftAnchor.constraint(equalTo: exploreImage.rightAnchor, constant: 20).isActive = true
        distanceLabel.topAnchor.constraint(equalTo: petHotelNameLabel.bottomAnchor, constant: 4).isActive = true
        distanceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }
    
    func priceConstraints() {
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
        self.addSubview(supportedPetView)
        imageConstraints()
        petHotelNameConstraints()
        distanceConstraints()
        priceConstraints()
        
        supportedPetView.bottomAnchor.constraint(equalTo: exploreImage.bottomAnchor).isActive = true
        supportedPetView.leftAnchor.constraint(equalTo: exploreImage.rightAnchor, constant: 20).isActive = true
        supportedPetView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        supportedPetView.heightAnchor.constraint(equalToConstant: 68).isActive = true
        supportedPetView.backgroundColor = .clear
        
    }
}

//MARK: -UICollectionViewDelegate, UICollectionViewDataSource
extension ExploreCard: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //ini ubah
        return supportedPet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SupportedPetCollectionViewCell.cellId, for: indexPath) as? SupportedPetCollectionViewCell else { return UICollectionViewCell() }
        
        //Ini ubah
        //cell.configure(petTypeString: supportedPet[indexPath.row].petType, petSizeString: supportedPet[indexPath.row].size)
        return cell
    }
}
