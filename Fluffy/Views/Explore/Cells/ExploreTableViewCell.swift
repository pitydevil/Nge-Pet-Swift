//
//  ExploreTableViewCell.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 19/10/22.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class ExploreTableViewCell: UITableViewCell {
    
    //MARK: -OBJECT DECLARATION
    var petHotelSupportedObject = BehaviorRelay<[PetHotelSupportedPet]>(value: [])

    //MARK: -Subviews
    var exploreImage:UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        return image
    }()
    var redRectangle:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(named: "primary5")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - CELL IDENTIFIER
    static let cellId = "ExploreTableViewCell"
    
    private lazy var petHotelNameLabel:ReuseableLabel = ReuseableLabel(labelText: "Pet Hotel", labelType: .titleH2, labelColor: .black)
    private lazy var distanceLabel:ReuseableLabel = ReuseableLabel(labelText: "500m", labelType: .bodyP2, labelColor: .grey1)
    private lazy var BeforePriceLabel:ReuseableLabel = ReuseableLabel(labelText: "Perhari mulai dari", labelType: .bodyP2, labelColor: .grey1)
    private lazy var priceLabel:ReuseableLabel = ReuseableLabel(labelText: "Rp 30.000", labelType: .titleH2, labelColor: .primaryMain)

    private lazy var supportedPetView:UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(SupportedPetCollectionViewCell.self, forCellWithReuseIdentifier: SupportedPetCollectionViewCell.cellId)
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        petHotelSupportedObject.bind(to: supportedPetView.rx.items(cellIdentifier: SupportedPetCollectionViewCell.cellId, cellType: SupportedPetCollectionViewCell.self)) { row, model, cell in
            cell.configure(model.supportedPetName, model.supportedPetType)
        }.disposed(by: bags)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0))
    }
}

//MARK: - Setups
extension ExploreTableViewCell{

    func setup(_ petHotels : PetHotels) {
        petHotelNameLabel.text = petHotels.petHotelName
        petHotelNameLabel.numberOfLines = 1
        distanceLabel.text = petHotels.petHotelDistance
        distanceLabel.numberOfLines = 1
        exploreImage.sd_setImage(with: URL(string: petHotels.petHotelImage))
        priceLabel.text = petHotels.petHotelStartPrice
//        let formatter = NumberFormatter()
//        formatter.locale = Locale(identifier: "id_ID")
//        formatter.groupingSeparator = "."
//        formatter.numberStyle = .decimal
//        if let formattedTipAmount = formatter.string(from: lowestPrice as NSNumber){
//            priceLabel.text = "Rp" + formattedTipAmount
//        }
    }
    
    private func imageConstraints() {
        exploreImage.contentMode = .scaleAspectFill
        exploreImage.clipsToBounds = true
        exploreImage.layer.cornerRadius = 12
        exploreImage.translatesAutoresizingMaskIntoConstraints = false
        exploreImage.widthAnchor.constraint(equalToConstant: 128).isActive = true
        exploreImage.heightAnchor.constraint(equalToConstant: 128).isActive = true
        exploreImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        exploreImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
    }
    
    private func petHotelNameConstraints() {
        petHotelNameLabel.leftAnchor.constraint(equalTo: exploreImage.rightAnchor, constant: 20).isActive = true
        petHotelNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        petHotelNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        petHotelNameLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }
    
    private func distanceConstraints() {
        distanceLabel.leftAnchor.constraint(equalTo: exploreImage.rightAnchor, constant: 20).isActive = true
        distanceLabel.topAnchor.constraint(equalTo: petHotelNameLabel.bottomAnchor, constant: 4).isActive = true
        distanceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }
    
    private func priceConstraints() {
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
    
    private func setupUI(){
        self.backgroundColor = .white
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
        
        self.backgroundColor = UIColor(named: "white")
        
        supportedPetView.bottomAnchor.constraint(equalTo: exploreImage.bottomAnchor).isActive = true
        supportedPetView.leftAnchor.constraint(equalTo: exploreImage.rightAnchor, constant: 20).isActive = true
        supportedPetView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        supportedPetView.heightAnchor.constraint(equalToConstant: 68).isActive = true
        supportedPetView.backgroundColor = .clear
    }
}
