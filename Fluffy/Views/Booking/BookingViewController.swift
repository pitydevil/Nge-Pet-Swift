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
    
    //MARK: OBJECT DECLARATION
    private let bookingViewModel      = BookingViewModel()
    private var bookingPesananObject  = BehaviorRelay<bookingPesananCase>(value: .aktif)
    private var bookingOnceableObject = BehaviorRelay<Bool>(value: false)
    private var orderObjectList       = BehaviorRelay<[Order]>(value: [])
   
    //MARK: OBSERVABLE VARIABLE DECLARATION
    private var bookingPesananObserver : Observable<bookingPesananCase> {
        return bookingPesananObject.asObservable()
    }
    
    //MARK: Subviews
    private var refreshControl : UIRefreshControl  =  {
        let refresh = UIRefreshControl()
        return refresh
    }()
    
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
    
    private lazy var emptyHeadline: ReuseableLabel = {
        let emptyHeadline = ReuseableLabel(labelText: "Daftar Pesanan Kosong!", labelType: .titleH1, labelColor: .black)
        emptyHeadline.textAlignment = .center
        return emptyHeadline
    }()
    
    private lazy var emptyImage: UIImageView = {
        let emptyImage = UIImageView()
        emptyImage.image = UIImage(named: "emptyPet")
        emptyImage.contentMode = .scaleAspectFit
        emptyImage.translatesAutoresizingMaskIntoConstraints = false
        return emptyImage
    }()
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "grey3")
        self.navigationItem.titleView = navTitle
        self.navigationController?.navigationBar.tintColor = UIColor(named: "primaryMain")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.addSubview(segmentedControl)
        haptic.prepare()
       
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        segmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        segmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true

    }
    
    //MARK: - Setup Layout
    private func emptyOrder(){
        tableView.removeFromSuperview()
        
        //MARK: - Add Subview Empty Order
        view.addSubview(emptyHeadline)
        view.addSubview(emptyImage)
        
        //MARK: - Setup Layout Empty Order
        NSLayoutConstraint.activate([
            
            emptyHeadline.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyHeadline.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 3),
            emptyHeadline.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emptyHeadline.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            emptyImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyImage.topAnchor.constraint(equalTo: emptyHeadline.bottomAnchor, constant: 8),
            emptyImage.heightAnchor.constraint(equalToConstant: 270),
            emptyImage.widthAnchor.constraint(equalToConstant: 270),

        ])
    }
    
    private func orderExist(){
        emptyHeadline.removeFromSuperview()
        emptyImage.removeFromSuperview()
        //MARK: - Setup View
        view.addSubview(tableView)
        tableView.estimatedRowHeight = 302
        
        tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 40).isActive = true
        tableView.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: segmentedControl.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        //MARK: - REFRESH CONTROL
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

        
    override func viewWillAppear(_ animated: Bool) {
        Task {
            bookingViewModel.orderStatusObject.accept(bookingPesananObject.value.rawValue)
            await bookingViewModel.fetchOrderList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        setupUI()
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        bookingViewModel.genericHandlingErrorObserver.skip(1).subscribe(onNext: { (value) in
            DispatchQueue.main.async { [self] in
                switch value {
                case .objectNotFound:
                    present(genericAlert(titleAlert: "Booking Order Tidak Ada!", messageAlert: "Booking Order tidak ada, silahkan coba lagi nanti.", buttonText: "Ok"), animated: true)
                case .success:
                    print("Sukses Console 200")
                default:
                    present(genericAlert(titleAlert: "Terjadi Gangguan server!", messageAlert: "Terjadi kesalahan dalam melakukan pencarian booking, silahkan coba lagi nanti.", buttonText: "Ok"), animated: true)
                }
            }
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        bookingViewModel.monitoringEnumCaseObserver.skip(1).subscribe(onNext: { [self] (value) in
            DispatchQueue.main.async {
                // UIView usage
                switch value {
                case .empty:
                    self.emptyOrder()
                case .terisi:
                    self.orderExist()
                }
            }
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
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
        bookingViewModel.orderModelArrayObserver.subscribe(onNext: { [self] (value) in
            DispatchQueue.main.async { [self] in
                refreshControl.endRefreshing()
            }
            bookingViewModel.checkOrderController(value)
            orderObjectList.accept(value)
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
            cell.backgroundColor = .clear
            cell.orderDetailArray.accept(model.orderDetail)
            
            //MARK: - Observer for Pet Type Value
            /// Returns boolean true or false
            /// from the given components.
            /// - Parameters:
            ///     - allowedCharacter: character subset that's allowed to use on the textfield
            ///     - text: set of character/string that would like  to be checked.
            cell.leftButton.rx.tap.bind { [self] in
                switch bookingPesananObject.value {
                    case .aktif:
                        DispatchQueue.main.async { [self] in
                            if let tabBarController = self.navigationController?.tabBarController  {
                                tabBarController.selectedIndex = 1
                            }
                            cell.leftButton.isEnabled = true
                        }
                    case .riwayat:
                        cell.leftButton.isEnabled = false
                }
            }.disposed(by: bags)
            
            //MARK: - Observer for Pet Type Value
            /// Returns boolean true or false
            /// from the given components.
            /// - Parameters:
            ///     - allowedCharacter: character subset that's allowed to use on the textfield
            ///     - text: set of character/string that would like  to be checked.
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
    
    //MARK: - Bind Journal List with Table View
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    @objc func handleRefreshControl() {
        Task {
            switch bookingPesananObject.value {
            case .aktif:
                bookingViewModel.orderStatusObject.accept(bookingPesananObject.value.rawValue)
                await bookingViewModel.fetchOrderList()
            case .riwayat:
                bookingViewModel.orderStatusObject.accept(bookingPesananObject.value.rawValue)
                await bookingViewModel.fetchOrderList()
            }
        }
    }
}
