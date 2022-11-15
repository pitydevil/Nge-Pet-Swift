//
//  MonitoringTableViewCell.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 12/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class MonitoringTableViewCell: UITableViewCell {
    
    //MARK: - OBJECT DECLARATION
    var monitoringImageModelArray = BehaviorRelay<[MonitoringImage]>(value: [])
    
    //MARK: - Subviews
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
    
    private lazy var container:UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "white")
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 4.0
        view.layer.shadowOpacity = 0.1
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        return view
    }()
    
    private lazy var descriptionLabel:UILabel = {
        let label =  ReuseableLabel(labelText: "Card Description", labelType: .bodyP2, labelColor: .grey1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.frame.size.width = 220
        label.sizeToFit()
        return label
    }()
    
    private lazy var dogName:ReuseableLabel = ReuseableLabel(labelText: "Doggo", labelType: .bodyP2, labelColor: .grey1)
    
    private lazy var notification:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
        view.layer.cornerRadius = view.layer.bounds.width/2
        view.backgroundColor = UIColor(named: "newError")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var carouselCollectionView: UICollectionView = {
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: 310, height: 310)
        carouselLayout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        carouselLayout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: carouselLayout)
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.delegate = self
        collection.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: CarouselCollectionViewCell.cellId)
        collection.backgroundColor = .clear
        return collection
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor(named: "grey2")
        pageControl.currentPageIndicatorTintColor = UIColor(named: "secondaryMain")
        pageControl.preferredIndicatorImage = UIImage.init(systemName: "pawprint.fill")
        pageControl.allowsContinuousInteraction = false
        return pageControl
    }()
    
    //MARK: - Properties
    static let cellId = "MonitoringTableViewCell"
    var height = 18
    
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    private lazy var newPost:Bool = true
    
    //MARK: - Initializer
    
    fileprivate func setupUI() {
 
        
        contentView.addSubview(container)
        container.addSubview(locIcon)
        container.addSubview(locationLabel)
        container.addSubview(cardTitle)
        container.addSubview(timeLabel)
        container.addSubview(descriptionLabel)
        if newPost{
            container.addSubview(notification)
        }
        container.addSubview(petIcon)
        container.addSubview(dogName)
        container.addSubview(carouselCollectionView)
        container.addSubview(pageControl)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
        //MARK: - Bind Monitoring Image Model Array to Carousel Collection View
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        ///
        monitoringImageModelArray.bind(to: carouselCollectionView.rx.items(cellIdentifier: CarouselCollectionViewCell.cellId, cellType: CarouselCollectionViewCell.self)) { row, model, cell in
            cell.backgroundColor = .clear
            cell.configureImage(model.monitoringImageURL)
        }.disposed(by: bags)
    }
    
    //MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setups
extension MonitoringTableViewCell{

    func heightForView(text:String, width:CGFloat) -> CGFloat{
       let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.greatestFiniteMagnitude))
       label.numberOfLines = 0
       label.lineBreakMode = NSLineBreakMode.byWordWrapping
       label.font = UIFont(name: "Inter-Medium", size: 12)
       label.text = text

       label.sizeToFit()
       return label.frame.height
   }
    
    func setupConstraint() {
        //MARK: Autoresize constraints
        dogName.translatesAutoresizingMaskIntoConstraints = false
        cardTitle.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        locIcon.translatesAutoresizingMaskIntoConstraints = false
        petIcon.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Container Constraints
        container.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        container.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        container.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24).isActive = true
        
        //MARK: Location Icon Constraints
        locIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        locIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        locIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        locIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //MARK: Location Label Constraints
        locationLabel.numberOfLines = 1
        locationLabel.leftAnchor.constraint(equalTo: locIcon.rightAnchor, constant: 4).isActive = true
        locationLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        locationLabel.centerYAnchor.constraint(equalTo: locIcon.centerYAnchor).isActive = true
        
        //MARK: Dog Name Constraints
        dogName.numberOfLines = 1
        dogName.textAlignment = .right
        
        dogName.topAnchor.constraint(equalTo: petIcon.bottomAnchor, constant: 8).isActive = true
        dogName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        dogName.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        //MARK: Time Constraints
        timeLabel.leftAnchor.constraint(equalTo: cardTitle.rightAnchor,constant:8).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: cardTitle.heightAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: cardTitle.centerYAnchor).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: dogName.leftAnchor, constant: -24).isActive = true
        timeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: timeLabel.intrinsicContentSize.width).isActive = true
        
        //MARK: Card Title Constraints
        cardTitle.numberOfLines = 1
        cardTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        cardTitle.rightAnchor.constraint(equalTo: timeLabel.leftAnchor, constant: -8).isActive = true
        cardTitle.topAnchor.constraint(equalTo: locIcon.bottomAnchor, constant: 4).isActive = true
        cardTitle.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        //MARK: Notification Constraints
        if newPost{
            notification.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
            notification.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
            notification.widthAnchor.constraint(equalToConstant: 8).isActive = true
            notification.heightAnchor.constraint(equalToConstant: 8).isActive = true
            petIcon.topAnchor.constraint(equalTo: notification.bottomAnchor, constant: 8).isActive = true
        }
        else{
            notification.removeFromSuperview()
            petIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        }
        
        //MARK: Pet Icon Constraints
        petIcon.layer.cornerRadius = petIcon.frame.height/2
        petIcon.layer.masksToBounds = true
        petIcon.widthAnchor.constraint(equalToConstant: 32).isActive = true
        petIcon.heightAnchor.constraint(equalToConstant: 32).isActive = true
        petIcon.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        
        //MARK: Description Constraints
        
        descriptionLabel.contentMode = .topLeft
        descriptionLabel.topAnchor.constraint(equalTo: cardTitle.bottomAnchor, constant: 4).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true

        descriptionLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true

        //MARK: Carousel Collection View Constraint
        carouselCollectionView.translatesAutoresizingMaskIntoConstraints = false
        carouselCollectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,constant: 8).isActive = true
        carouselCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        carouselCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        carouselCollectionView.widthAnchor.constraint(equalToConstant: 310).isActive = true
        carouselCollectionView.heightAnchor.constraint(equalToConstant: 310).isActive = true
        carouselCollectionView.layer.cornerRadius = 12
        
        //MARK: Page Control Constraint
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.topAnchor.constraint(equalTo: carouselCollectionView.bottomAnchor, constant: 0).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pageControl.widthAnchor.constraint(equalToConstant: 150).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 28).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20).isActive = true

    }
}

//MARK: - Public
extension MonitoringTableViewCell{
    func configure(_ monitoring : Monitoring){
        var customSop = String()
        locationLabel.text = monitoring.petHotelName
        cardTitle.text = monitoring.monitoringActivity

        for sop in monitoring.customSops {
            customSop += "\(sop.customSopName)\n"
        }
        descriptionLabel.numberOfLines = monitoring.customSops.count
        
        descriptionLabel.text = customSop
        height = Int(heightForView(text: customSop, width: 220))
        //MARK: -Belum sambung ke local data
        petIcon.image = UIImage(named: "dog1")
        dogName.text = monitoring.petName
        timeLabel.text = monitoring.timeUpload
        pageControl.numberOfPages = monitoring.monitoringImage.count
        
        newPost = monitoring.notification
        setupConstraint()
        layoutIfNeeded()
    }
}

// MARK: - UICollectionViewDataSource
extension MonitoringTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        currentPage = getCurrentPage()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
        currentPage = getCurrentPage()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        currentPage = getCurrentPage()
    }
}

// MARK: - Helpers
private extension MonitoringTableViewCell {
    func getCurrentPage() -> Int {
        let visibleRect = CGRect(origin: carouselCollectionView.contentOffset, size: carouselCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = carouselCollectionView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
        return currentPage
    }
}
