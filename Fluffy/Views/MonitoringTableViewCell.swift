//
//  MonitoringTableViewCell.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 12/10/22.
//

import UIKit

class MonitoringTableViewCell: UITableViewCell {

//MARK: - Subviews
    var carouselView: CarouselView = {
        let view = CarouselView(pages: 3)
        return view
    }()
    
    private lazy var cardTitle:ReuseableLabel = ReuseableLabel(labelText: "Card Title", labelType: .titleH2, labelColor: .black)
    
    private lazy var locIcon: UIImageView = {
        let ImageView = UIImageView()
        ImageView.image = UIImage(named: "mapIcon")
        return ImageView
    }()
    
    private lazy var petIcon: UIImageView = {
        let ImageView = UIImageView()
        ImageView.image = UIImage(named: "pugIcon")
        ImageView.contentMode = .scaleAspectFit
        return ImageView
    }()
    
    private lazy var notifImage: UIImageView = {
        let ImageView = UIImageView()
        ImageView.image = UIImage(named: "notifCircle")
        ImageView.contentMode = .scaleAspectFit
        return ImageView
    }()
    
    private lazy var locationLabel:ReuseableLabel = ReuseableLabel(labelText: "Location", labelType: .bodyP2, labelColor: .grey1)
    
    private lazy var timeLabel:ReuseableLabel = ReuseableLabel(labelText: "8m", labelType: .bodyP2, labelColor: .grey1)
    
    
    private lazy var descriptionLabel:UILabel = {
        let label =  ReuseableLabel(labelText: "Card Description", labelType: .bodyP2, labelColor: .grey1)
        return label
    }()
    
    private lazy var dogName:ReuseableLabel = ReuseableLabel(labelText: "Doggo", labelType: .bodyP2, labelColor: .grey1)
    
    private var notification:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
        view.layer.cornerRadius = view.layer.bounds.width/2
        view.backgroundColor = UIColor(named: "newError")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //VStack Kiri
    lazy var leftCardStack: UIView = {
        let stack = UIView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
        
    }()

    
    //MARK: - Properties
    static let cellId = "MonitoringTableViewCell"

//MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(locIcon)
        contentView.addSubview(locationLabel)
        contentView.addSubview(cardTitle)
        contentView.addSubview(timeLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(notification)
        contentView.addSubview(petIcon)
        contentView.addSubview(dogName)
//        carouselView = CarouselView(pages: 2)
//        carouselView.configureView(with: [CarouselData(image: UIImage(named: "slide1"))])
        contentView.addSubview(carouselView)
        contentView.backgroundColor = UIColor(named: "white")
        contentView.layer.cornerRadius = 12
        setupConstraint()
    }

    //MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 48, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Setups

extension MonitoringTableViewCell{
    
    func autoResizeConstraint() {
        dogName.translatesAutoresizingMaskIntoConstraints = false
        cardTitle.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        locIcon.translatesAutoresizingMaskIntoConstraints = false
        petIcon.translatesAutoresizingMaskIntoConstraints = false
        carouselView.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupConstraint() {
        autoResizeConstraint()
        
        locIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        locIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        locIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        locIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        locationLabel.numberOfLines = 1
        locationLabel.leftAnchor.constraint(equalTo: locIcon.rightAnchor, constant: 4).isActive = true
        locationLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        locationLabel.centerYAnchor.constraint(equalTo: locIcon.centerYAnchor).isActive = true
        
        petIcon.layer.cornerRadius = petIcon.frame.height/2
        petIcon.layer.masksToBounds = true
        petIcon.widthAnchor.constraint(equalToConstant: 32).isActive = true
        petIcon.heightAnchor.constraint(equalToConstant: 32).isActive = true
        petIcon.topAnchor.constraint(equalTo: notification.bottomAnchor, constant: 8).isActive = true
        petIcon.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        
        
        dogName.numberOfLines = 1
        dogName.textAlignment = .right
        
        dogName.topAnchor.constraint(equalTo: petIcon.bottomAnchor, constant: 8).isActive = true
        dogName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        dogName.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        timeLabel.leftAnchor.constraint(equalTo: cardTitle.rightAnchor,constant:8).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: cardTitle.centerYAnchor).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: dogName.leftAnchor, constant: -24).isActive = true
        timeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        cardTitle.numberOfLines = 1
        cardTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        cardTitle.topAnchor.constraint(equalTo: locIcon.bottomAnchor, constant: 4).isActive = true
        cardTitle.heightAnchor.constraint(equalToConstant: 24).isActive = true
//        cardTitle.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        notification.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        notification.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        notification.widthAnchor.constraint(equalToConstant: 8).isActive = true
        notification.heightAnchor.constraint(equalToConstant: 8).isActive = true
        
        
        
        descriptionLabel.numberOfLines = 5
        descriptionLabel.textAlignment = .justified
 
        let height = descriptionLabel.heightForLabel(text: descriptionLabel.text ?? "", font: UIFont(name: "Inter-Medium", size: 12)!, width: 220)
        descriptionLabel.topAnchor.constraint(equalTo: cardTitle.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: dogName.leftAnchor, constant: -24).isActive = true
        descriptionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 90).isActive = true
        
        carouselView.backgroundColor = .yellow
        carouselView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        carouselView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        carouselView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8).isActive = true
        carouselView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        carouselView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30).isActive = true
        carouselView.widthAnchor.constraint(equalToConstant: 310).isActive = true
        carouselView.heightAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
}

//MARK: - Public
extension MonitoringTableViewCell{
    public func configure(location:String, cardTitleString:String, timestamp:String, description:String, petImage:String, dogNameString:String, carouselData:[CarouselData]){
        locationLabel.text = location
        cardTitle.text = cardTitleString
        descriptionLabel.text = description
        petIcon.image = UIImage(named: petImage)
        dogName.text = dogNameString
        timeLabel.text = timestamp
        carouselView = CarouselView(pages: carouselData.count)
        carouselView.configureView(with: carouselData)
    }
}

extension UILabel {

    func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 5
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }

}
