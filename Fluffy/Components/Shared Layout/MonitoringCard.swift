//
//  MonitoringCard.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 05/10/22.
//

import UIKit

class MonitoringCard: UIView {
    
    //MARK: -Properties
    public private(set) var location:String
    public private(set) var cardTitleString:String
    public private(set) var cardDescription:String
    public private(set) var timeStamp:String
    public private(set) var dogNameString:String
    public private(set) var petIconString: String
    public private(set) var newPost:Bool
    public private(set) var carouselData = [CarouselData]()
    
    //MARK: - Initializers
    init(frame: CGRect,location:String,cardTitleString:String,cardDescription:String, timeStamp:String, dogNameString:String, petIconString:String, newPost: Bool, carouselData:[CarouselData]) {
        self.location = location
        self.cardTitleString = cardTitleString
        self.cardDescription = cardDescription
        self.timeStamp = timeStamp
        self.dogNameString = dogNameString
        self.petIconString = petIconString
        self.newPost = newPost
        self.carouselData = carouselData
        super.init(frame: frame)
        setupLayout()
        self.backgroundColor = UIColor(named: "white")
        self.layer.cornerRadius = 12
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    private lazy var timeLabel:ReuseableLabel = ReuseableLabel(labelText: "29 Sep 22, 8pm", labelType: .bodyP2, labelColor: .grey1)
    
    
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
    
    lazy var timeStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 8
        return stack
    }()
    
    //VStack Kanan
    lazy var rightCardStack: UIView = {
        let stack = UIView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    //HStack Atas
    lazy var topStack: UIView = {
        let stack = UIView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var locStack: UIView = {
        let stack = UIView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var allStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
    fileprivate func autoResizeConstraint() {
        dogName.translatesAutoresizingMaskIntoConstraints = false
        cardTitle.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        locIcon.translatesAutoresizingMaskIntoConstraints = false
        petIcon.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func allStackConstraint() {
        allStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        allStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        allStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        allStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }
    
    fileprivate func topStackConstraint() {
        topStack.topAnchor.constraint(equalTo: allStack.topAnchor).isActive = true
        topStack.leftAnchor.constraint(equalTo: allStack.leftAnchor).isActive = true
        topStack.rightAnchor.constraint(equalTo: allStack.rightAnchor).isActive = true
        topStack.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
    }
    fileprivate func carouselConstraint() {
        carouselView.leftAnchor.constraint(equalTo: allStack.leftAnchor).isActive = true
        carouselView.rightAnchor.constraint(equalTo: allStack.rightAnchor).isActive = true
        carouselView.bottomAnchor.constraint(equalTo: allStack.bottomAnchor, constant: 0).isActive = true
    }
    
    fileprivate func locationConstraint() {
        locStack.leftAnchor.constraint(equalTo: leftCardStack.leftAnchor).isActive = true
        locStack.topAnchor.constraint(equalTo: leftCardStack.topAnchor).isActive = true
        
        locIcon.leftAnchor.constraint(equalTo: locStack.leftAnchor).isActive = true
        locIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        locIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        locationLabel.leftAnchor.constraint(equalTo: locIcon.rightAnchor, constant: 8).isActive = true
        locationLabel.centerYAnchor.constraint(equalTo: locIcon.centerYAnchor).isActive = true
        locationLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        locationLabel.numberOfLines = 1
    }
    
    fileprivate func titleTimeConstraint() {
        timeStack.topAnchor.constraint(equalTo: locIcon.bottomAnchor, constant: 8).isActive = true
        timeStack.leftAnchor.constraint(equalTo: leftCardStack.leftAnchor).isActive = true
        timeStack.rightAnchor.constraint(equalTo: leftCardStack.rightAnchor).isActive = true
        timeStack.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        timeLabel.widthAnchor.constraint(equalToConstant: 24).isActive = true
        timeLabel.adjustsFontSizeToFitWidth = true
        
        cardTitle.rightAnchor.constraint(equalTo: timeLabel.leftAnchor, constant: -8).isActive = true
        
    }
    
    fileprivate func notificationConstraint() {
        notification.topAnchor.constraint(equalTo: rightCardStack.topAnchor).isActive = true
        notification.widthAnchor.constraint(equalToConstant: 8).isActive = true
        notification.heightAnchor.constraint(equalToConstant: 8).isActive = true
        notification.rightAnchor.constraint(equalTo: rightCardStack.rightAnchor, constant: 0).isActive = true
        notification.contentMode = .right
        notification.bottomAnchor.constraint(equalTo: petIcon.topAnchor, constant: -8).isActive = true
    }
    
    fileprivate func rightStackConstraint() {
        rightCardStack.widthAnchor.constraint(equalToConstant: 64).isActive = true
        rightCardStack.rightAnchor.constraint(equalTo: topStack.rightAnchor).isActive = true
        rightCardStack.topAnchor.constraint(equalTo: self.topAnchor,constant:20).isActive = true
        
        if newPost{
            notificationConstraint()
        }
        else{
            petIcon.topAnchor.constraint(equalTo: rightCardStack.topAnchor).isActive = true
        }
        
        petIcon.heightAnchor.constraint(equalToConstant: 32).isActive = true
        petIcon.widthAnchor.constraint(equalToConstant: 32).isActive = true
        petIcon.contentMode = .topRight
        petIcon.bottomAnchor.constraint(equalTo: dogName.topAnchor, constant: -8).isActive = true
        petIcon.rightAnchor.constraint(equalTo: rightCardStack.rightAnchor).isActive = true
        
        
        dogName.rightAnchor.constraint(equalTo: rightCardStack.rightAnchor).isActive = true
        dogName.textAlignment = .right
        dogName.widthAnchor.constraint(lessThanOrEqualToConstant: 59).isActive = true
        dogName.heightAnchor.constraint(equalToConstant: 18).isActive = true
        dogName.contentMode = .topRight
        
    }
    
    fileprivate func setupDescriptionLabel() {
        descriptionLabel.text = cardDescription
        descriptionLabel.textAlignment = .justified
        descriptionLabel.numberOfLines = 5
    }
    
    fileprivate func setupLabel() {
        cardTitle.text = cardTitleString
        locationLabel.text = location
        timeLabel.text = timeStamp
        dogName.text = dogNameString
        petIcon.image = UIImage(named: petIconString)
        setupDescriptionLabel()
    }
    
    func leftCardConstraint(){
        leftCardStack.rightAnchor.constraint(equalTo: rightCardStack.leftAnchor, constant: -20).isActive = true
        leftCardStack.topAnchor.constraint(equalTo: rightCardStack.topAnchor).isActive = true
        leftCardStack.bottomAnchor.constraint(equalTo: topStack.bottomAnchor).isActive = true
        leftCardStack.leftAnchor.constraint(equalTo: topStack.leftAnchor).isActive = true
        
    }
    fileprivate func setupConstraint() {
        autoResizeConstraint()
        allStackConstraint()
        topStackConstraint()
        rightStackConstraint()
        leftCardConstraint()
        locationConstraint()
        titleTimeConstraint()
//        carouselConstraint()
    }
    
    private func setupLayout(){
        locStack.addSubview(locIcon)
        locStack.addSubview(locationLabel)
        leftCardStack.addSubview(locStack)
        timeStack.addArrangedSubview(cardTitle)
        timeStack.addArrangedSubview(timeLabel)
        
        leftCardStack.addSubview(timeStack)
        leftCardStack.addSubview(descriptionLabel)

        if newPost{
            rightCardStack.addSubview(notification)
            
        }
        
        rightCardStack.addSubview(petIcon)
        rightCardStack.addSubview(dogName)

        topStack.addSubview(leftCardStack)
        topStack.addSubview(rightCardStack)
        
        carouselView = CarouselView(pages: carouselData.count)
        carouselView.configureView(with: carouselData)
        allStack.addArrangedSubview(topStack)
        
        allStack.addArrangedSubview(carouselView)
        self.addSubview(allStack)
        
        
        setupConstraint()
        
        setupLabel()
        
        descriptionLabel.topAnchor.constraint(equalTo: timeStack.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 220).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: topStack.leftAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 80).isActive = true
    }
    
}


