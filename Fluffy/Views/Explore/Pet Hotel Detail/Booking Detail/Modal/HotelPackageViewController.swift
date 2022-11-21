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
    private var monitoringEnumCaseModel        = BehaviorRelay<monitoringCase>(value: .empty)
    private var petHotelPackageModelArray      = BehaviorRelay<[PetHotelPackage]>(value: [])
    private var petHotelPackageSelectedModel   = BehaviorRelay<PetHotelPackage>(value: PetHotelPackage(packageID: 0, packageName: "", packagePrice: "", petHotelID: "", supportedPetID: "", packageDetail: [PackageDetail]()))
    var hotelPackageBodyObject                  = BehaviorRelay<HotelPackageBody>(value: HotelPackageBody(petHotelID: 0, supportedPetName: ""))
    
    var petHotelModelObject                     = BehaviorRelay<OrderDetailBody>(value: OrderDetailBody(petName: "", petType: "", petSize: "", petData: "", packagename: "", packageID: 0, orderDetailPrice: 0, isExpanded: false, customSOP: [CustomSopBody]()))
    
    
    //MARK: OBJECT OBSERVER DECLARATION
    private var monitoringEnumCaseObserver : Observable<monitoringCase> {
        return monitoringEnumCaseModel.asObservable()
    }
    
    private var hotelPackageBodyObjectObserver : Observable<HotelPackageBody> {
        return hotelPackageBodyObject.asObservable()
    }
    
    var petHotelPackageModelArrayObserver : Observable<[PetHotelPackage]> {
        return petHotelPackageModelArray.asObservable()
    }
    
    var petHotelModelObserver : Observable<OrderDetailBody> {
        return petHotelModelObject.asObservable()
    }

    //MARK: - SUBVIEWS
    private lazy var indicator: UIImageView = {
        let indicator = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
        indicator.image = UIImage(systemName: "minus", withConfiguration: config)
        indicator.tintColor = UIColor(named: "grey2")
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var emptyHeadline: ReuseableLabel = {
        let emptyHeadline = ReuseableLabel(labelText: "Paket Hotel Tidak Tersedia!", labelType: .titleH1, labelColor: .black)
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
    
    private lazy var emptyCaption: ReuseableLabel = {
        let emptyCaption = ReuseableLabel(labelText: "Yuk, Pilih Paket Hotel Untuk Hewan Kamu Yang Lain", labelType: .bodyP1, labelColor: .grey1)
        emptyCaption.textAlignment = .center
        emptyCaption.spacing = 5
        return emptyCaption
    }()
    
    private lazy var headline: ReuseableLabel = {
        let headline = ReuseableLabel(labelText: "Paket Hotel", labelType: .titleH1, labelColor: .black)
        return headline
    }()
    
    private lazy var modalTableView: UITableView = {
        let modalTableView = UITableView(frame: CGRect(), style: .plain)
        modalTableView.backgroundColor = UIColor(named: "grey3")
      
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
    
    //MARK: - Setup Layout
    private func packageHotelExist() {
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
    
    private func emptyPackageHotel(){
        //MARK: - Add Subview Empty Package Hotel
        view.addSubview(indicator)
        view.addSubview(emptyHeadline)
        view.addSubview(emptyImage)
        view.addSubview(emptyCaption)
        
        //MARK: - Setup Layout Empty Package Hotel
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
            
            emptyHeadline.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyHeadline.topAnchor.constraint(equalTo: view.topAnchor, constant: 123),
            emptyHeadline.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emptyHeadline.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            emptyImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyImage.topAnchor.constraint(equalTo: emptyHeadline.bottomAnchor, constant: 8),
            emptyImage.heightAnchor.constraint(equalToConstant: 270),
            emptyImage.widthAnchor.constraint(equalToConstant: 270),
            
            emptyCaption.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyCaption.topAnchor.constraint(equalTo: emptyImage.bottomAnchor, constant: 8),
            emptyCaption.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emptyCaption.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "grey3")

        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        petHotelPackageViewModel.monitoringEnumCaseObserver.subscribe(onNext: { [self] (value) in
            DispatchQueue.main.async {
                // UIView usage
                switch value {
                case .terisi:
                    print("terisi")
                    self.packageHotelExist()
                case .empty:
                    print("kosong")
                    self.emptyPackageHotel()
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
                    print("200")
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
            petHotelPackageViewModel.checkHotelPackageStateController(value)
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
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        modalTableView.rx.itemSelected.subscribe(onNext: { [self] (indexPath) in
            var petHotelArray = petHotelModelObject.value
            petHotelArray.packageID = petHotelPackageModelArray.value[indexPath.row].packageID
            petHotelArray.orderDetailPrice = Int(petHotelPackageModelArray.value[indexPath.row].packagePrice) ?? 0
            petHotelArray.packagename = petHotelPackageModelArray.value[indexPath.row].packageName
            petHotelModelObject.accept(petHotelArray)
            dismiss(animated: true)
        }).disposed(by: bags)
        
        //MARK: - Bind Journal List with Table View
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        modalTableView.rx.setDelegate(self).disposed(by: bags)
    }
}

extension HotelPackageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
