//
//  BookingViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 17/10/22.
//

import UIKit

struct Booking{
    let bookingId:String
    let petHotelName:String
    let detailPaket:[String]
    let checkInDate:String
    let checkOutDate:String
    let bookingStatus:String
}

class BookingViewController: UIViewController {

    //MARK: Properties
    let items = ["Aktif", "Riwayat"]
    let haptic = UISelectionFeedbackGenerator()
    var bookingList:[Booking] = [
        Booking(bookingId: "Rsv1234", petHotelName: "Katzenesia Pet Hotel", detailPaket: ["Mochi - Premium (4 catatan khusus)", "Chiron - Plus (2 catatan khusus)"], checkInDate: "27 September", checkOutDate: "29 September", bookingStatus: "Menunggu Konfirmasi"),
        Booking(bookingId: "Rsv1235", petHotelName: "Pet Hotel Indonesia", detailPaket: ["Mochi - Premium (4 catatan khusus)", "Chiron - Plus (2 catatan khusus)"], checkInDate: "27 September", checkOutDate: "29 September", bookingStatus: "Dalam Penitipan")
    ]
    let activeBooking:[Booking] = [
        Booking(bookingId: "Rsv1234", petHotelName: "Katzenesia Pet Hotel", detailPaket: ["Mochi - Premium (4 catatan khusus)", "Chiron - Plus (2 catatan khusus)"], checkInDate: "27 September", checkOutDate: "29 September", bookingStatus: "Menunggu Konfirmasi"),
        Booking(bookingId: "Rsv1235", petHotelName: "Pet Hotel Indonesia", detailPaket: ["Mochi - Premium (4 catatan khusus)", "Chiron - Plus (2 catatan khusus)"], checkInDate: "27 September", checkOutDate: "29 September", bookingStatus: "Dalam Penitipan")
    ]
    let historyBooking:[Booking] = [
        Booking(bookingId: "Rsv1234", petHotelName: "Katzenesia Pet Hotel", detailPaket: ["Mochi - Premium (4 catatan khusus)", "Chiron - Plus (2 catatan khusus)"], checkInDate: "27 September", checkOutDate: "29 September", bookingStatus: "Dijemput Pemilik")
    ]
    
    //MARK: Subviews
    private lazy var segmentedControl:UISegmentedControl = {
       let view = UISegmentedControl(items: items)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.selectedSegmentIndex = 0
        view.selectedSegmentTintColor = UIColor(named: "primaryMain")
        view.backgroundColor = UIColor(named: "grey2")
        view.tintColor = UIColor(named: "white")
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
             view.setTitleTextAttributes(titleTextAttributes, for:.normal)
        
        view.addTarget(self, action: #selector(switchChange), for: .valueChanged)
        return view
    }()
    
    private lazy var colorView:UIView = {
       let view = UIView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var navTitle:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "Daftar Pesanan", labelType: .titleH2, labelColor: .black)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(BookingTableViewCell.self, forCellReuseIdentifier: BookingTableViewCell.cellId)
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.invalidateIntrinsicContentSize()
        tableView.estimatedRowHeight = 302
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    @objc func switchChange(){
        haptic.selectionChanged()
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            bookingList = activeBooking
            tableView.reloadData()
        case 1:
            bookingList = historyBooking
            tableView.reloadData()
        default:
            bookingList = activeBooking
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "grey3")
        self.navigationItem.titleView = navTitle
        self.navigationController?.navigationBar.tintColor = UIColor(named: "primaryMain")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
        view.addSubview(segmentedControl)
        haptic.prepare()
        view.addSubview(tableView)
        tableView.estimatedRowHeight = 302
        
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        segmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        segmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        
        tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 40).isActive = true
        tableView.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: segmentedControl.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    @objc func seeDetail(){
        let vc = BookingDetailViewController()
        vc.modalPresentationStyle = .pageSheet
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension BookingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookingTableViewCell.cellId) as! BookingTableViewCell
        cell.backgroundColor = .clear
        cell.rightButton.addTarget(self, action: #selector(seeDetail), for: .touchUpInside)
        cell.configureView(hotelName: bookingList[indexPath.row].petHotelName, bookingId: bookingList[indexPath.row].bookingId, detailPaket: bookingList[indexPath.row].detailPaket, checkIn: bookingList[indexPath.row].checkInDate, checkOut: bookingList[indexPath.row].checkOutDate, bookingStatus: bookingList[indexPath.row].bookingStatus)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
