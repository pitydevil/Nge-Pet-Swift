//
//  MonitoringTableViewCell.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 12/10/22.
//

import UIKit

class MonitoringTableViewCell: UITableViewCell {
    
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
    
    private lazy var carouselCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.dataSource = self
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
    private var carouselData = [CarouselData]()
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    //MARK: - Initializer
    
    fileprivate func setupUI() {
        contentView.backgroundColor = UIColor(named: "white")
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = false
        contentView.layer.shadowRadius = 4.0
        contentView.layer.shadowOpacity = 0.20
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 4, height: 4)
    }
    
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
        contentView.addSubview(carouselCollectionView)
        contentView.addSubview(pageControl)
        setupUI()
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
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 5
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
    
    func descriptionConstraint() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .justified
        descriptionLabel.showsExpansionTextWhenTruncated = true
        
        descriptionLabel.topAnchor.constraint(equalTo: cardTitle.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: dogName.leftAnchor, constant: -24).isActive = true
        descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 64).isActive = true
    }
    
    func notificationConstraint() {
        notification.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        notification.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        notification.widthAnchor.constraint(equalToConstant: 8).isActive = true
        notification.heightAnchor.constraint(equalToConstant: 8).isActive = true
    }
    
    func cardTitleConstraint() {
        cardTitle.numberOfLines = 1
        cardTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        cardTitle.rightAnchor.constraint(equalTo: timeLabel.leftAnchor, constant: -8).isActive = true
        cardTitle.topAnchor.constraint(equalTo: locIcon.bottomAnchor, constant: 4).isActive = true
        cardTitle.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    func timeConstraint() {
        timeLabel.leftAnchor.constraint(equalTo: cardTitle.rightAnchor,constant:8).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: cardTitle.heightAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: cardTitle.centerYAnchor).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: dogName.leftAnchor, constant: -24).isActive = true
        timeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: timeLabel.intrinsicContentSize.width).isActive = true
    }
    
    func dogNameConstraint() {
        dogName.numberOfLines = 1
        dogName.textAlignment = .right
        
        dogName.topAnchor.constraint(equalTo: petIcon.bottomAnchor, constant: 8).isActive = true
        dogName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        dogName.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func petIconConstraint() {
        petIcon.layer.cornerRadius = petIcon.frame.height/2
        petIcon.layer.masksToBounds = true
        petIcon.widthAnchor.constraint(equalToConstant: 32).isActive = true
        petIcon.heightAnchor.constraint(equalToConstant: 32).isActive = true
        petIcon.topAnchor.constraint(equalTo: notification.bottomAnchor, constant: 8).isActive = true
        petIcon.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
    }
    
    func locationLabelConstraint() {
        locationLabel.numberOfLines = 1
        locationLabel.leftAnchor.constraint(equalTo: locIcon.rightAnchor, constant: 4).isActive = true
        locationLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        locationLabel.centerYAnchor.constraint(equalTo: locIcon.centerYAnchor).isActive = true
    }
    
    func locIconConstraint() {
        locIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        locIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        locIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        locIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupCollectionView() {
        carouselCollectionView.translatesAutoresizingMaskIntoConstraints = false
        carouselCollectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,constant: 20).isActive = true
        carouselCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        carouselCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        carouselCollectionView.widthAnchor.constraint(equalToConstant: 310).isActive = true
        carouselCollectionView.heightAnchor.constraint(equalToConstant: 310).isActive = true
        carouselCollectionView.layer.cornerRadius = 12
    }
    
    func setupPageControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.topAnchor.constraint(equalTo: carouselCollectionView.bottomAnchor, constant: 0).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pageControl.widthAnchor.constraint(equalToConstant: 150).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 28).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }
    
    func setupConstraint() {
        autoResizeConstraint()
        locIconConstraint()
        locationLabelConstraint()
        petIconConstraint()
        dogNameConstraint()
        timeConstraint()
        cardTitleConstraint()
        notificationConstraint()
        descriptionConstraint()
        setupCollectionView()
        setupPageControl()
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
        self.configureView(with: carouselData)
        pageControl.numberOfPages = carouselData.count
    }
}

// MARK: - UICollectionViewDataSource

extension MonitoringTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.cellId, for: indexPath) as? CarouselCollectionViewCell else { return UICollectionViewCell() }
        
        let image = carouselData[indexPath.row].image
        
        cell.configure(image: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

// MARK: - UICollectionView Delegate

extension MonitoringTableViewCell: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentPage = getCurrentPage()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
}

// MARK: - Public

extension MonitoringTableViewCell {
    public func configureView(with data: [CarouselData]) {
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: 310, height: 310)
        carouselLayout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        carouselLayout.minimumLineSpacing = 0
        carouselCollectionView.collectionViewLayout = carouselLayout
        
        carouselData = data
        carouselCollectionView.reloadData()
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
