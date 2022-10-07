//
//  MonitoringCard.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 05/10/22.
//

import UIKit

class MonitoringCard: UIView {
    
    public private(set) var location:String
    public private(set) var cardTitleString:String
    public private(set) var cardDescription:String
    public private(set) var timeStamp:String
    public private(set) var dogNameString:String
    public private(set) var petIconString: String
    public private(set) var newPost:Bool
    public private(set) var carouselData = [CarouselData]()
    
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
    
    //MARK - Subviews
    
    private var carouselView: CarouselView = {
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
    lazy var leftCardStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
        
    }()
    lazy var timeStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    //VStack Kanan
    lazy var rightCardStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    //HStack Atas
    lazy var topStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    
    lazy var locStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    lazy var allStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
    fileprivate func allStackConstraint() {
        allStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        allStack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        allStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        allStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        
        allStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        allStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }
    
    fileprivate func notificationConstraint() {
        notifImage.widthAnchor.constraint(equalToConstant: 8).isActive = true
        notifImage.heightAnchor.constraint(equalToConstant: 8).isActive = true
        notifImage.rightAnchor.constraint(equalTo: rightCardStack.leftAnchor, constant: 0).isActive = true
        notifImage.leftAnchor.constraint(equalTo: rightCardStack.rightAnchor, constant: -8).isActive = true
        notifImage.contentMode = .right
    }
    
    fileprivate func carouselConstraint() {
        carouselView.widthAnchor.constraint(equalToConstant: 302).isActive = true
        carouselView.heightAnchor.constraint(equalToConstant: 314).isActive = true
        carouselView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }
    
    fileprivate func autoResizeConstraint() {
        dogName.translatesAutoresizingMaskIntoConstraints = false
        cardTitle.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        locIcon.translatesAutoresizingMaskIntoConstraints = false
        petIcon.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func locationConstraint() {
        locStack.bottomAnchor.constraint(equalTo: timeStack.topAnchor, constant: -8).isActive = true
        locIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        locIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        locIcon.rightAnchor.constraint(equalTo: locationLabel.leftAnchor, constant: -8).isActive = true
    }
    
    fileprivate func titleTimeConstraint() {
        timeLabel.leftAnchor.constraint(equalTo: cardTitle.rightAnchor, constant: 8).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: timeLabel.intrinsicContentSize.width).isActive = true
        timeStack.topAnchor.constraint(equalTo: locStack.bottomAnchor, constant: 8).isActive = true
        timeStack.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -8).isActive = true
        cardTitle.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        cardTitle.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        
    }
    
    fileprivate func topStackConstraint() {
        topStack.bottomAnchor.constraint(equalTo: carouselView.topAnchor, constant: -8).isActive = true
    }
    
    fileprivate func rightStackConstraint() {
        rightCardStack.widthAnchor.constraint(equalToConstant: 64).isActive = true
        dogName.widthAnchor.constraint(equalToConstant: dogName.intrinsicContentSize.width).isActive = true
        dogName.textAlignment = .right
        dogName.widthAnchor.constraint(lessThanOrEqualToConstant: 64).isActive = true
        petIcon.heightAnchor.constraint(equalToConstant: 32).isActive = true
        petIcon.widthAnchor.constraint(equalToConstant: 32).isActive = true
        petIcon.contentMode = .right
        petIcon.bottomAnchor.constraint(equalTo: dogName.topAnchor, constant: -8).isActive = true
        rightCardStack.spacing = 8
        
    }
    
    fileprivate func setupDescriptionLabel() {
        descriptionLabel.text = cardDescription
        descriptionLabel.textAlignment = .left
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
    
    fileprivate func setupConstraint() {
        autoResizeConstraint()
        allStackConstraint()
        carouselConstraint()
        locationConstraint()
        titleTimeConstraint()
        topStackConstraint()
        rightStackConstraint()
        
        leftCardStack.spacing = 8
    }
    
    private func setupLayout(){
        locStack.addArrangedSubview(locIcon)
        locStack.addArrangedSubview(locationLabel)
        leftCardStack.addArrangedSubview(locStack)
        timeStack.addArrangedSubview(cardTitle)
        timeStack.addArrangedSubview(timeLabel)
        
        leftCardStack.addArrangedSubview(timeStack)
        leftCardStack.addArrangedSubview(descriptionLabel)

        if newPost{
            rightCardStack.addArrangedSubview(notifImage)
            notificationConstraint()
        }
        
        rightCardStack.addArrangedSubview(petIcon)
        rightCardStack.addArrangedSubview(dogName)

        topStack.addArrangedSubview(leftCardStack)
        topStack.addArrangedSubview(rightCardStack)
        
        carouselView = CarouselView(pages: carouselData.count)
        carouselView.configureView(with: carouselData)
//        carouselView.backgroundColor = .clear
        carouselView.backgroundColor = .brown
        allStack.addArrangedSubview(topStack)
        
        allStack.addArrangedSubview(carouselView)
        self.addSubview(allStack)
        
        
        setupConstraint()
        
        setupLabel()
        
        descriptionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 18 * 5).isActive = true
        descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 18 ).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: timeStack.bottomAnchor, constant: -8).isActive = true
        descriptionLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 220).isActive = true
    }
    
}


