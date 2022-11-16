//
//  HotelPackageViewController.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 02/11/22.
//

import UIKit
import RxSwift
import RxCocoa

class HotelPackageViewController: UIViewController {
    
    //MARK: - OBJECT DECLARATION
    private let petHotelPackageViewModel       = PetHotelPackageViewModel()
    private var petHotelPackageModelArray      = BehaviorRelay<[PetHotelPackage]>(value: [])
    private var petHotelPackageSelectedModel   = BehaviorRelay<PetHotelPackage>(value: PetHotelPackage(packageID: 0, packageName: "", packagePrice: "", petHotelID: "", supportedPetID: "", packageDetail: [PackageDetail]()))
    var hotelPackageBodyObject                  = BehaviorRelay<HotelPackageBody>(value: HotelPackageBody(petHotelID: 0, supportedPetName: ""))
    
    var petHotelModelObject                     = BehaviorRelay<OrderDetailBody>(value: OrderDetailBody(petName: "", petType: "", petSize: "", packageID: 0, orderDetailPrice: 0, isExpanded: false, customSOP: [CustomSopBody]()))
    
    
    //MARK: OBJECT OBSERVER DECLARATION
    private var hotelPackageBodyObjectObserver : Observable<HotelPackageBody> {
        return hotelPackageBodyObject.asObservable()
    }
    
    var petHotelPackageModelArrayObserver : Observable<[PetHotelPackage]> {
        return petHotelPackageModelArray.asObservable()
    }
    
    var petHotelModelObserver : Observable<OrderDetailBody> {
        return petHotelModelObject.asObservable()
    }

    private lazy var indicator: UIImageView = {
        let indicator = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
        indicator.image = UIImage(systemName: "minus", withConfiguration: config)
        indicator.tintColor = UIColor(named: "grey2")
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var headline: ReuseableLabel = {
        let headline = ReuseableLabel(labelText: "Paket Hotel", labelType: .titleH1, labelColor: .black)
        return headline
    }()
    
    private lazy var modalTableView: UITableView = {
        let modalTableView = UITableView(frame: CGRect(), style: .plain)
        modalTableView.backgroundColor = UIColor(named: "grey3")
        modalTableView.delegate = self
        modalTableView.register(HotelPackageTableViewCell.self, forCellReuseIdentifier: HotelPackageTableViewCell.identifier)
        modalTableView.translatesAutoresizingMaskIntoConstraints = false
        modalTableView.allowsMultipleSelection = false
        modalTableView.separatorStyle = .none
        modalTableView.showsVerticalScrollIndicator = false
        modalTableView.sectionHeaderTopPadding = 0
        modalTableView.isScrollEnabled = true
        return modalTableView
    }()
    
    private lazy var customBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Simpan", showText: .notShow)
        return customBar
    }()
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "grey3")
        
        //MARK: - Add Subview
        view.addSubview(indicator)
        view.addSubview(headline)
        view.addSubview(modalTableView)
      //  view.addSubview(customBar)
        
        //MARK: - Setup Const
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),

            headline.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            headline.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            headline.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -222),
            
            modalTableView.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 20),
            modalTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            modalTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            modalTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
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
        hotelPackageBodyObjectObserver.subscribe(onNext: { [self] (value) in
            Task {
                petHotelPackageViewModel.hotelPackageBodyObject.accept(value)
                await petHotelPackageViewModel.fetchPetHotelPackage()
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
        petHotelPackageViewModel.genericHandlingErrorObserver.skip(1).subscribe(onNext: { [self] (value) in
            DispatchQueue.main.async {
                switch value {
                case .objectNotFound:
                    self.present(genericAlert(titleAlert: "Add Order Tidak Ada!", messageAlert: "Add Order tidak ada, silahkan coba lagi nanti.", buttonText: "Ok"), animated: true)
                case .success:
                    self.present(genericAlert(titleAlert: "Order Berhasil!", messageAlert: "Add Order Berhasil, silahkan cek booking kamu di menu booking.", buttonText: "Ok"), animated: true) {
                        self.dismiss(animated: true) {
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                    }
                default:
                    self.present(genericAlert(titleAlert: "Terjadi Gangguan server!", messageAlert: "Terjadi kesalahan dalam melakukan pencarian booking, silahkan coba lagi nanti.", buttonText: "Ok"), animated: true)
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
        petHotelPackageViewModel.petHotelPackageModelArrayObserver.subscribe(onNext: { [self] (value) in
            petHotelPackageModelArray.accept(value)
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        petHotelPackageModelArray.bind(to: modalTableView.rx.items(cellIdentifier: HotelPackageTableViewCell.identifier, cellType: HotelPackageTableViewCell.self)) { row, model, cell in
            cell.backgroundColor = .clear
            cell.configure(model)
        }.disposed(by: bags)
        
        modalTableView.rx.itemSelected.subscribe(onNext: { [self] (indexPath) in
            var petHotelArray = petHotelModelObject.value
            petHotelArray.packageID = petHotelPackageModelArray.value[indexPath.row].packageID
            petHotelArray.orderDetailPrice = Int(petHotelPackageModelArray.value[indexPath.row].packagePrice) ?? 0
            petHotelModelObject.accept(petHotelArray)
            dismiss(animated: true)
        }).disposed(by: bags)
    }
}

extension HotelPackageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
