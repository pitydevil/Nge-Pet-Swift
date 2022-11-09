//
//  BookingViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 17/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class BookingViewController: UIViewController {

    //MARK: Properties
    private let haptic = UISelectionFeedbackGenerator()
    
    //MARK: -VARIABLE DECLARATION
    private let bookingViewModel      = BookingViewModel()
    private var bookingPesananObject  = BehaviorRelay<bookingPesananCase>(value: .aktif)
    private var bookingOnceableObject = BehaviorRelay<Bool>(value: false)
    private var orderObjectList       = BehaviorRelay<[Order]>(value: [])
    
    //MARK: -OBSERVABLE VARIABLE DECLARATION
    private var bookingPesananObserver : Observable<bookingPesananCase> {
        return bookingPesananObject.asObservable()
    }
    
    //MARK: Subviews
    private lazy var segmentedControl:UISegmentedControl = {
       let view = UISegmentedControl(items: ["Aktif", "Riwayat"])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.selectedSegmentIndex = 0
        view.selectedSegmentTintColor = UIColor(named: "primaryMain")
        view.backgroundColor = UIColor(named: "grey2")
        view.tintColor = UIColor(named: "white")
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
             view.setTitleTextAttributes(titleTextAttributes, for:.normal)
        
        return view
    }()
    
    private lazy var colorView : UIView = {
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
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "grey3")
        self.navigationItem.titleView = navTitle
        self.navigationController?.navigationBar.tintColor = UIColor(named: "primaryMain")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
        
    override func viewWillAppear(_ animated: Bool) {
        Task {
            bookingViewModel.orderStatusObject.accept(bookingPesananObject.value.rawValue)
            await bookingViewModel.fetchOrderList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        segmentedControl.rx.selectedSegmentIndex.subscribe(onNext: { [self] value in
            self.orderObjectList.accept([])
            switch value {
                case 0:
                    self.bookingPesananObject.accept(.aktif)
                case 1:
                    self.bookingPesananObject.accept(.riwayat)
                default:
                    print("test")
            }
        }).disposed(by: bags)
        
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        bookingPesananObserver.skip(1).subscribe(onNext: { [self] (value) in
            Task {
                switch value {
                    case .aktif:
                        bookingViewModel.orderStatusObject.accept(value.rawValue)
                        await bookingViewModel.fetchOrderList()
                    case .riwayat:
                        bookingViewModel.orderStatusObject.accept(value.rawValue)
                        await bookingViewModel.fetchOrderList()
                }
            }
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        bookingViewModel.orderModelArrayObserver.subscribe(onNext: { (value) in
            self.orderObjectList.accept(value)
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        orderObjectList.bind(to: tableView.rx.items(cellIdentifier:  BookingTableViewCell.cellId, cellType: BookingTableViewCell.self)) { [self] row, model, cell in
            bookingOnceableObject.accept(true)
            cell.configureCell(model)
            cell.backgroundColor = .clezar
            cell.orderDetailArray.accept(model.orderDetail)
            
            cell.leftButton.rx.tap.bind { [self] in
                if let tabBarController = self.navigationController?.tabBarController  {
                    tabBarController.selectedIndex = 1
                }
            }.disposed(by: bags)
            
            cell.rightButton.rx.tap.bind { [self] in
                if bookingOnceableObject.value {
                    bookingOnceableObject.accept(false)
                    let vc = BookingDetailViewController()
                    vc.modalPresentationStyle = .pageSheet
                    vc.bookingIdObject.accept(model.orderId)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }.disposed(by: bags)
            
        }.disposed(by: bags)
    }
}
