//
//  BookingTableViewCell.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 01/11/22.
//

import UIKit
import RxSwift
import RxCocoa

class BookingTableViewCell: UITableViewCell {
    
    //MARK: SubViews
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.axis = .vertical
        
        return stackView
    }()
    
    var orderDetailArray       = BehaviorRelay<[OrderDetail]>(value: [])
    
    private lazy var petHotelName:ReuseableLabel = ReuseableLabel(labelText: "Pet Hotel Name", labelType: .titleH2, labelColor: .black)
    
    private lazy var idPaket:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "Id : Rsv12345", labelType: .bodyP2, labelColor: .grey1)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var detailPaket:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "and 3 more", labelType: .bodyP2, labelColor: .grey1)
        return label
    }()
    
    private lazy var checkIn:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "Check In", labelType: .titleH3, labelColor: .grey1)
        return label
    }()
    
    private lazy var checkOut:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "Check Out", labelType: .titleH3, labelColor: .grey1)
        return label
    }()
    
    private lazy var detailCheckIn:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "25 September", labelType: .bodyP2, labelColor: .grey1)
        return label
    }()
    
    private lazy var detailCheckOut:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "26 September", labelType: .bodyP2, labelColor: .grey1)
        return label
    }()
    
    private lazy var status:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "Menunggu Konfirmasi", labelType: .bodyP2, labelColor: .newError)
        return label
    }()
    
    lazy var leftButton:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Cancel Order", styleBtn:.normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.configuration?.attributedTitle = AttributedString("Cancel Order", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 12)!]))
        return btn
    }()
    
    lazy var rightButton:ReusableButton = {
        var config = UIImage.SymbolConfiguration(hierarchicalColor: UIColor(named: "primaryMain") ?? .systemPink)
        config = config.applying(UIImage.SymbolConfiguration(weight: .bold))
        let btn = ReusableButton(titleBtn: "Semua Hewan", styleBtn: .frameless, icon: UIImage(systemName: "chevron.right", withConfiguration: config))
        btn.configuration?.baseForegroundColor = UIColor(named: "primaryMain")
        btn.configuration?.attributedTitle = AttributedString("Lihat Detail", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 12)!]))
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(seeDetail), for: .touchUpInside)
        return btn
    }()
    private lazy var clockImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = UIImage(systemName: "clock.fill")
        imageView.tintColor = UIColor(named: "grey1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var upperView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var middleView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var bottomView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var detailPaketTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(paketTableViewCell.self, forCellReuseIdentifier: paketTableViewCell.cellId)
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "white")
        tableView.invalidateIntrinsicContentSize()
        return tableView
    }()
    
    @objc func seeDetail(){
//        let vc = BookingDetailViewController()
//        vc.modalPresentationStyle = .pageSheet
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Properties
    static let cellId = "bookingTableViewCell"
    private var numPackage = 1
    private var detailPaketArray:[String] = [""]
    
    private func setupUI() {
        contentView.addSubview(stackView)

        upperView.addSubview(petHotelName)
        upperView.addSubview(idPaket)
        upperView.addSubview(detailPaketTableView)
        upperView.addSubview(detailPaket)
        upperView.addSubview(checkIn)
        upperView.addSubview(checkOut)
            upperView.addSubview(detailCheckIn)
            upperView.addSubview(detailCheckOut)
        stackView.addArrangedSubview(upperView)
        
        middleView.addSubview(clockImage)
        middleView.addSubview(status)
        stackView.addArrangedSubview(middleView)
        
        bottomView.addSubview(leftButton)
        bottomView.addSubview(rightButton)
        stackView.addArrangedSubview(bottomView)
        stackView.addVerticalSeparators(color: UIColor(named: "grey2") ?? .systemGray2)
        
        contentView.backgroundColor = UIColor(named: "white")
        contentView.layer.cornerRadius = 12
        setupConstraint()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        ///     
        orderDetailArray.bind(to: detailPaketTableView.rx.items(cellIdentifier: paketTableViewCell.cellId, cellType: paketTableViewCell.self)) { row, model, cell in
            cell.backgroundColor = .clear
            cell.configureOrderDetail(model)
        }.disposed(by: bags)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
    }
}

//MARK: Setups
extension BookingTableViewCell{
    func setupConstraint(){
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        
        upperView.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        upperView.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        upperView.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        upperView.heightAnchor.constraint(lessThanOrEqualToConstant: 300).isActive = true

        middleView.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        middleView.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        middleView.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        

        bottomView.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        bottomView.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        bottomView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true

        petHotelName.topAnchor.constraint(equalTo: upperView.topAnchor).isActive = true
        petHotelName.leftAnchor.constraint(equalTo: upperView.leftAnchor).isActive = true
        petHotelName.rightAnchor.constraint(equalTo: idPaket.leftAnchor, constant: -12).isActive = true
        petHotelName.heightAnchor.constraint(equalToConstant: 24).isActive = true
        petHotelName.widthAnchor.constraint(equalToConstant: 190).isActive = true
        
        idPaket.rightAnchor.constraint(equalTo: upperView.rightAnchor).isActive = true
        idPaket.bottomAnchor.constraint(equalTo: petHotelName.bottomAnchor).isActive = true
        idPaket.widthAnchor.constraint(greaterThanOrEqualToConstant: 64).isActive = true
        idPaket.leftAnchor.constraint(equalTo: petHotelName.rightAnchor, constant: 12).isActive = true
        
        detailPaketTableView.topAnchor.constraint(equalTo: petHotelName.bottomAnchor, constant: 20).isActive = true
        detailPaketTableView.leftAnchor.constraint(equalTo: upperView.leftAnchor).isActive = true
        detailPaketTableView.rightAnchor.constraint(equalTo: upperView.rightAnchor).isActive = true
        detailPaketTableView.heightAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(18*(numPackage+2))).isActive = true
        
        detailPaket.topAnchor.constraint(equalTo: detailPaketTableView.bottomAnchor).isActive = true
        detailPaket.leftAnchor.constraint(equalTo: upperView.leftAnchor).isActive = true
        detailPaket.rightAnchor.constraint(equalTo: upperView.rightAnchor).isActive = true
        detailPaket.heightAnchor.constraint(equalToConstant: 18).isActive = true

        checkIn.topAnchor.constraint(equalTo: detailPaket.bottomAnchor, constant: 20).isActive = true
        checkIn.leftAnchor.constraint(equalTo: upperView.leftAnchor).isActive = true
        checkIn.widthAnchor.constraint(greaterThanOrEqualToConstant: 82).isActive = true
        checkIn.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        checkOut.leftAnchor.constraint(equalTo: checkIn.rightAnchor, constant: 100).isActive = true
        checkOut.topAnchor.constraint(equalTo: checkIn.topAnchor).isActive = true
        checkOut.widthAnchor.constraint(greaterThanOrEqualToConstant: 82).isActive = true
        checkOut.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        detailCheckIn.leftAnchor.constraint(equalTo: checkIn.leftAnchor).isActive = true
        detailCheckIn.topAnchor.constraint(equalTo: checkIn.bottomAnchor).isActive = true
        detailCheckIn.widthAnchor.constraint(greaterThanOrEqualToConstant: 82).isActive = true
        detailCheckIn.bottomAnchor.constraint(equalTo: upperView.bottomAnchor).isActive = true
        detailCheckIn.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        detailCheckOut.leftAnchor.constraint(equalTo: checkOut.leftAnchor).isActive = true
        detailCheckOut.topAnchor.constraint(equalTo: detailCheckIn.topAnchor).isActive = true
        detailCheckOut.widthAnchor.constraint(greaterThanOrEqualToConstant: 82).isActive = true
        detailCheckOut.bottomAnchor.constraint(equalTo: upperView.bottomAnchor).isActive = true
        detailCheckOut.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        clockImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        clockImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        clockImage.contentMode = .scaleAspectFill
        clockImage.leftAnchor.constraint(equalTo: middleView.leftAnchor).isActive = true
        clockImage.topAnchor.constraint(equalTo: middleView.topAnchor).isActive = true
        clockImage.bottomAnchor.constraint(equalTo: middleView.bottomAnchor).isActive = true
        
        status.leftAnchor.constraint(equalTo: clockImage.rightAnchor, constant: 12).isActive = true
        status.centerYAnchor.constraint(equalTo: clockImage.centerYAnchor).isActive = true
        status.rightAnchor.constraint(equalTo: middleView.rightAnchor).isActive = true
        
        leftButton.widthAnchor.constraint(equalToConstant: 126).isActive = true
        leftButton.leftAnchor.constraint(equalTo: bottomView.leftAnchor).isActive = true
        leftButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        leftButton.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        
        rightButton.rightAnchor.constraint(equalTo: bottomView.rightAnchor).isActive = true
        rightButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        rightButton.centerYAnchor.constraint(equalTo: leftButton.centerYAnchor).isActive = true
    }
}

// MARK: - Public
extension BookingTableViewCell {
    func configureCell(_ order : Order) {
        var packageArray = [String]()
        petHotelName.text = order.petHotelName
        idPaket.text = "id: \(order.orderCode)"
        numPackage = order.orderDetail.count
        
        if numPackage > 3 {
            detailPaket.isHidden = false
            detailPaket.text = "and \(numPackage - 3) more"
            numPackage = 3
        }else {
            detailPaket.isHidden = true
        }
        
        for order in order.orderDetail {
            packageArray.append(order.packageName)
        }
        
        detailPaketArray     = packageArray
        detailCheckIn.text   = order.orderDateCheckIn
        detailCheckOut.text  = order.orderDateCheckOut
        status.text          = order.orderStatus
        
        if order.orderStatus == "waiting-for-confirmation"{
            leftButton.configuration?.attributedTitle = AttributedString("Cancel Order", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 12)!]))
            leftButton.configuration?.baseBackgroundColor = UIColor(named: "grey2")
            leftButton.configuration?.baseForegroundColor = UIColor(named: "white")
            leftButton.isEnabled = false
        }
        else{
            leftButton.configuration?.attributedTitle = AttributedString("Lihat Monitoring", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 12)!]))
            leftButton.configuration?.baseBackgroundColor = UIColor(named: "primaryMain")
            leftButton.configuration?.baseForegroundColor = UIColor(named: "white")
            leftButton.isEnabled = true
        }
    }
}
