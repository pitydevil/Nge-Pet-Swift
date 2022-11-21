//
//  SelectBookingDetailsViewController.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 01/11/22.
//

import UIKit
import RxSwift
import RxCocoa

@available(iOS 16.0, *)
class SelectBookingDetailsViewController: UIViewController {
    
    //MARK: - OBJECT DECLARATION
    private let selectBookingViewModel = SelectBookingViewModel()
    private let petArrayObject = BehaviorRelay<[OrderDetailBody]>(value: [])
    var filteredPetArrayObject = BehaviorRelay<[OrderDetailBody]>(value: [])
    
    var petHotelModel   = BehaviorRelay<PetHotelsDetail>(value: PetHotelsDetail(petHotelID: 0, petHotelName: "", petHotelDescription: "", petHotelLongitude: "", petHotelLatitude: "", petHotelAddress: "", petHotelKelurahan: "", petHotelKecamatan: "", petHotelKota: "", petHotelProvinsi: "", petHotelPos: "", petHotelStartPrice: "", supportedPet: [SupportedPet](), petHotelImage: [PetHotelImage](), fasilitas: [Fasilitas](), sopGeneral: [SopGeneral](), asuransi: [AsuransiDetail](), cancelSOP: [CancelSOP]()))
    var orderAddObject = BehaviorRelay<OrderAdd>(value: OrderAdd(orderDateCheckIn: "", orderDateCheckOu: "", orderTotalPrice: 0, userID: userID, petHotelId: 0, orderDetails: [OrderDetailBodyFinal]()))
    var petHotelIDObject = BehaviorRelay<Int>(value: 0)
    var selectedIndexCell = BehaviorRelay<Int>(value: 0)
    
    //MARK: OBJECT OBSERVER DECLARATION
    var filteredPetModelArrayObserver : Observable<[OrderDetailBody]> {
        return filteredPetArrayObject.asObservable()
    }
        
    var petHotelModelObservable : Observable<PetHotelsDetail> {
        return petHotelModel.asObservable()
    }
    
    //MARK: - SUBVIEWS
    private lazy var emptyHeadline: ReuseableLabel = {
        let emptyHeadline = ReuseableLabel(labelText: "Yah, Daftar Hewannmu Kosong!", labelType: .titleH1, labelColor: .black)
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
        let emptyCaption = ReuseableLabel(labelText: "Yuk, Tambah Hewan dan Permudah Pencarian Hotelmu!", labelType: .bodyP1, labelColor: .grey1)
        emptyCaption.textAlignment = .center
        emptyCaption.spacing = 5
        return emptyCaption
    }()
    
    private lazy var addPetBtn: ReusableButton = {
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let addPetBtn = ReusableButton(titleBtn: "Tambah Hewan", styleBtn: .normal, icon: UIImage(systemName: "plus", withConfiguration: config))
        return addPetBtn
    }()
    
    private lazy var packageTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(named: "grey3")
        tableView.register(SelectPackageTableViewCell.self, forCellReuseIdentifier: SelectPackageTableViewCell.cellId)
        tableView.register(CatatanKhususTableViewCell.self, forCellReuseIdentifier: CatatanKhususTableViewCell.cellId)
        tableView.register(SelectBookingDetailsTableViewCell.self, forCellReuseIdentifier: SelectBookingDetailsTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsMultipleSelection = true
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 0
        tableView.isScrollEnabled = true
        return tableView
    }()
    
    private lazy var btmBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Lanjut", showText: .notShow)
        customBar.translatesAutoresizingMaskIntoConstraints = false
        customBar.backgroundColor = UIColor(named: "primaryMain")
        customBar.barBtn.configuration?.baseBackgroundColor = UIColor(named: "white")
        customBar.barBtn.configuration?.baseForegroundColor = UIColor(named: "primaryMain")
        return customBar
    }()
    
    private lazy var selectedPet: ReuseableLabel = ReuseableLabel(labelText: "1 Hewan Dipilih", labelType: .bodyP2, labelColor: .white)
    
    private lazy var perDay: ReuseableLabel = ReuseableLabel(labelText: "/hari", labelType: .bodyP2, labelColor: .white)
    
    private lazy var price: ReuseableLabel = ReuseableLabel(labelText: "Rp60.000", labelType: .titleH2, labelColor: .white)
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grey2")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Setup Layout
    private func setupUI() {
        view.backgroundColor = UIColor(named: "grey3")
        navigationItem.titleView = setTitle(title: "Katze Nesia Cat Hotel", subtitle: "Bekasi, Jawa Barat")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func emptyPet(){
        //MARK: - Add Subview Empty Pet
        view.addSubview(emptyHeadline)
        view.addSubview(emptyImage)
        view.addSubview(emptyCaption)
        view.addSubview(addPetBtn)
        
        //MARK: - Setup Layout Empty Pet
        NSLayoutConstraint.activate([
            
            emptyHeadline.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyHeadline.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 4),
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
            
            addPetBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addPetBtn.topAnchor.constraint(equalTo: emptyCaption.bottomAnchor, constant: 20),
        ])
    }
    
    private func petExist(){
        //MARK: - Setup View
        view.addSubview(packageTableView)
        view.addSubview(btmBar)
        btmBar.addSubview(selectedPet)
        btmBar.addSubview(price)
        btmBar.addSubview(perDay)
        
        //MARK: - Setup Constraint
        NSLayoutConstraint.activate([
            
            //MARK: - tableview const
            packageTableView.topAnchor.constraint(equalTo: view.topAnchor),
            packageTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            packageTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            packageTableView.bottomAnchor.constraint(equalTo: btmBar.topAnchor, constant: -20),
            packageTableView.widthAnchor.constraint(equalToConstant: 342),
            
            //MARK: tabbar constraint
            btmBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            btmBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            btmBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            //MARK: start label constraint
            selectedPet.topAnchor.constraint(equalTo: btmBar.topAnchor, constant: 20),
            selectedPet.leftAnchor.constraint(equalTo: btmBar.leftAnchor, constant: 24),
            
            //MARK: price constraint
            price.topAnchor.constraint(equalTo: selectedPet.bottomAnchor, constant: 0),
            price.leftAnchor.constraint(equalTo: selectedPet.leftAnchor),
            
            //MARK: per day constraint
            perDay.leftAnchor.constraint(equalTo: price.rightAnchor),
            perDay.topAnchor.constraint(equalTo: price.topAnchor),
            perDay.bottomAnchor.constraint(equalTo: price.bottomAnchor),
        ])
    }
    
    //MARK: -ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        selectBookingViewModel.getAllPet()
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
        selectBookingViewModel.petModelObjectArrayObserver.subscribe(onNext: { [self] (value) in
            petArrayObject.accept(value)
            filteredPetArrayObject.accept(value)
            selectBookingViewModel.checkPetsController(value)
            DispatchQueue.main.async { [self] in
                packageTableView.reloadData()
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
        selectBookingViewModel.monitoringEnumCaseObserver.skip(1).subscribe(onNext: { (value) in
            DispatchQueue.main.async {
                // UIView usage
                switch value {
                case .empty:
                    self.emptyPet()
                case .terisi:
                    self.petExist()
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
        petHotelModelObservable.subscribe(onNext: { [self] (value) in
            DispatchQueue.main.async { [self] in
                navigationItem.titleView = setTitle(title: value.petHotelName, subtitle: "\(value.petHotelAddress),\(value.petHotelProvinsi)")
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
        filteredPetModelArrayObserver.subscribe(onNext: { [self] (value) in
            var orderDetailPrice      = 0
            var counterHewan          = 0
            for obj in value {
                if obj.isExpanded && obj.orderDetailPrice != 0 && obj.packageID != 0 {
                    counterHewan     += 1
                    orderDetailPrice += obj.orderDetailPrice
                }
            }
            DispatchQueue.main.async { [self] in
                selectedPet.text = "\(counterHewan) Hewan Dipilih"
                price.text       =  changeNumericToCurrency(strInt: orderDetailPrice)
                btmBar.barBtn.isEnabled = counterHewan == 0 ? false : true
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
        btmBar.barBtn.rx.tap.bind { [self] in
            let vc = DateSelectionViewController()
            var orderTotalPrice = 0
            var orderDetailBodyFinal = [OrderDetailBodyFinal]()
            var orderDetailBody = [OrderDetailBody]()
            for obj in filteredPetArrayObject.value {
                if obj.isExpanded {
                    orderTotalPrice += obj.orderDetailPrice
                    orderDetailBodyFinal.append(OrderDetailBodyFinal(petName: obj.petName, petType: obj.petType, petSize: obj.petSize, petData: obj.petData ,packageID: obj.packageID, customSOP: obj.customSOP))
                    orderDetailBody.append(obj)
                }
            }
            vc.orderDetailObject.accept(orderDetailBody)
            vc.petHotelModel.accept(petHotelModel.value)
            vc.orderAddObject.accept(OrderAdd(orderDateCheckIn: "", orderDateCheckOu: "", orderTotalPrice: orderTotalPrice, userID: userID, petHotelId: petHotelIDObject.value, orderDetails: orderDetailBodyFinal))
            navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        addPetBtn.rx.tap.bind { [self] in
            let vc = AddPetViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }.disposed(by: bags)
    }
}

//MARK: Navigation Title
@available(iOS 16.0, *)
extension SelectBookingDetailsViewController {
    func setTitle(title:String, subtitle:String) -> UIView {
        let titleLabel = UILabel(frame: CGRectMake(0, -2, 0, 0))

        titleLabel.backgroundColor = .clear
        titleLabel.textColor = UIColor(named: "black")
        titleLabel.font = UIFont(name: "Poppins-Bold", size: 16)
        titleLabel.text = title
        titleLabel.sizeToFit()

        let subtitleLabel = UILabel(frame: CGRectMake(0, 18, 0, 0))
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.textColor = UIColor(named: "black")
        subtitleLabel.font = UIFont(name: "Inter-Medium", size: 12)
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()

        let titleView = UIView(frame: CGRectMake(0, 0, max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), 30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)

        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width

        if widthDiff < 0 {
            let newX = widthDiff / 2
            subtitleLabel.frame.origin.x = abs(newX)
        } else {
            let newX = widthDiff / 2
            titleLabel.frame.origin.x = newX
        }
        return titleView
    }
    
    func makeTransparentNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundColor = .white
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}

@available(iOS 16.0, *)
extension SelectBookingDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredPetArrayObject.value.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectPackageTableViewCell.cellId, for: indexPath) as! SelectPackageTableViewCell
            cell.contentView.backgroundColor = UIColor(named: "white")
            cell.configure(filteredPetArrayObject.value[indexPath.section])
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CatatanKhususTableViewCell.cellId, for: indexPath) as! CatatanKhususTableViewCell
            cell.contentView.backgroundColor = UIColor(named: "white")
            cell.configure(filteredPetArrayObject.value[indexPath.section])
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectBookingDetailsTableViewCell.identifier, for: indexPath) as! SelectBookingDetailsTableViewCell
            cell.contentView.backgroundColor = UIColor(named: "white")
            cell.configure(filteredPetArrayObject.value[indexPath.section])
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let vc = HotelPackageViewController()
            vc.hotelPackageBodyObject.accept(HotelPackageBody(petHotelID: petHotelIDObject.value, supportedPetName: filteredPetArrayObject.value[indexPath.section].petType))
            vc.petHotelModelObject.accept(filteredPetArrayObject.value[indexPath.section])
            
            //MARK: - INIT OBJECT
            /// Retujrn NULL
            /// from the given components.
            /// - Parameters:
            ///     - allowedCharacter: character subset that's allowed to use on the textfield
            ///     - text: set of character/string that would like  to be checked.
            vc.petHotelModelObserver.subscribe(onNext: { [self] (value) in
                var tempFilteredPetArrayObject = filteredPetArrayObject.value
                tempFilteredPetArrayObject[indexPath.section] = value
                filteredPetArrayObject.accept(tempFilteredPetArrayObject)
                packageTableView.reloadRows(at: [IndexPath(row: 1, section: indexPath.section), IndexPath(row: 2, section: indexPath.section)], with: .none)
            },onError: { error in
                self.present(errorAlert(), animated: true)
            }).disposed(by: bags)
            
            vc.modalPresentationStyle = .pageSheet
            
            if filteredPetArrayObject.value[indexPath.section].isExpanded {
                present(vc, animated: true)
            }
        } else if indexPath.row == 2 {
            let vc = CatatanViewController()
            vc.sopModelArrayObject.accept(filteredPetArrayObject.value[indexPath.section].customSOP)
            vc.petHotelModelObject.accept(filteredPetArrayObject.value[indexPath.section])
            
            //MARK: - INIT OBJECT
            /// Retujrn NULL
            /// from the given components.
            /// - Parameters:
            ///     - allowedCharacter: character subset that's allowed to use on the textfield
            ///     - text: set of character/string that would like  to be checked.
            vc.petHotelModelObserver.subscribe(onNext: { [self] (value) in
                var tempFilteredPetArrayObject = filteredPetArrayObject.value
                tempFilteredPetArrayObject[indexPath.section] = value
                filteredPetArrayObject.accept(tempFilteredPetArrayObject)
                packageTableView.reloadRows(at: [IndexPath(row: 1, section: indexPath.section), IndexPath(row: 2, section: indexPath.section)], with: .none)
            },onError: { error in
                self.present(errorAlert(), animated: true)
            }).disposed(by: bags)
            vc.modalPresentationStyle = .pageSheet
            if filteredPetArrayObject.value[indexPath.section].isExpanded {
                present(vc, animated: true)
            }
        }
    }
}

@available(iOS 16.0, *)
extension SelectBookingDetailsViewController : SelectPetProtocol {
    func selectPetProtocol(cell: SelectBookingDetailsTableViewCell) {
        let indexPath   = packageTableView.indexPath(for: cell)
        let index       = indexPath?.section ?? 0
        var tempFilteredPetArrayObject = filteredPetArrayObject.value
        tempFilteredPetArrayObject[index].isExpanded = tempFilteredPetArrayObject[index].isExpanded ? false : true
        selectedIndexCell.accept(index)
        filteredPetArrayObject.accept(tempFilteredPetArrayObject)
        packageTableView.reloadRows(at: [IndexPath(row: 1, section: index), IndexPath(row: 2, section: index)], with: .none)
    }
}
