//
//  ExploreViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 17/10/22.
//
import UIKit
import RxSwift
import RxCocoa

@available(iOS 16.0, *)
class ExploreViewController: UIViewController {
    
    //MARK: - OBJECT DECLARATION
    private var tableViewHeightConstraint : NSLayoutConstraint?
    private let modalSelectPetViewController = ModalSelectPetViewController()
    private let exploreViewModel          = ExploreViewModel(locationManager: LocationManager())
    private var petsSelectionModelArray   = BehaviorRelay<[PetsSelection]>(value: [])
    private var petsBodyModelArray        = BehaviorRelay<[PetBody]>(value: [])
    private var petSelectedModelArray     = BehaviorRelay<[PetsSelection]>(value: [])
    private let petHotelList = BehaviorRelay<[PetHotels]>(value: [])
    private var modalSearchLocationObject = BehaviorRelay<LocationDetail>(value: LocationDetail(longitude: 0.0, latitude: 0.0, locationName: ""))
    private var checkFinalObject = BehaviorRelay<CheckIn>(value:CheckIn(checkInDate: "", checkOutDate: ""))
    
    //MARK: OBJECT OBSERVER DECLARATION
    var petsSelectionModelArrayObserver : Observable<[PetsSelection]> {
        return petsSelectionModelArray.asObservable()
    }
    
    //MARK: Subviews
    private var refreshControl : UIRefreshControl  =  {
        let refresh = UIRefreshControl()
        refresh.tintColor = .white
        return refresh
    }()
    
    private let scrollView:UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = UIColor(named: "primaryMain")
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private let contentView = UIView()
    
    private lazy var exploreRect:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "primaryMain")
        return view
    }()
    private lazy var roundedCorner:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "grey3")
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private lazy var exploreLabel:ReuseableLabel = ReuseableLabel(labelText: "Hello, Mau nitip hewan di mana nih?", labelType: .titleH1, labelColor: .white)
    
    private lazy var searchLocView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toSearchModal))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private lazy var searchDateView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toDateModal))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private lazy var searchPetView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toSelectPetModal))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private lazy var searchLocation: UITextField = {
        let textField = UITextField()
        textField.setLeftView(image: UIImage(systemName: "mappin.and.ellipse")!, color: UIColor(named: "white")!)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "primary2")
        textField.layer.cornerRadius = 12
        textField.attributedPlaceholder = NSAttributedString(string: "Lokasi Hotel", attributes: [
            .foregroundColor: UIColor(named: "primary4") as Any,
            .font: UIFont(name: "Inter-Medium", size: 12)!
        ])
        textField.isUserInteractionEnabled = false
        
        return textField
    }()
    
    private lazy var searchDate: UITextField = {
        let textField = UITextField()
        textField.setLeftView(image: UIImage(systemName: "calendar")!, color: UIColor(named: "white")!)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "primary2")
        textField.layer.cornerRadius = 12
        textField.attributedPlaceholder = NSAttributedString(string: "Tanggal Reservasi", attributes: [
            .foregroundColor: UIColor(named: "primary4") as Any,
            .font: UIFont(name: "Inter-Medium", size: 12)!
        ])
        textField.isUserInteractionEnabled = false
        textField.addTarget(self, action: #selector(toDateModal), for: .editingDidBegin)
        return textField
    }()
    
    private lazy var searchPet: UITextField = {
        let textField = UITextField()
        textField.setLeftView(image: UIImage(systemName: "pawprint.fill")!, color: UIColor(named: "white")!)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "primary2")
        textField.layer.cornerRadius = 12
        textField.attributedPlaceholder = NSAttributedString(string: "Pilih Hewan", attributes: [
            .foregroundColor: UIColor(named: "primary4") as Any,
            .font: UIFont(name: "Inter-Medium", size: 12)!
        ])
        textField.isUserInteractionEnabled = false
        textField.addTarget(self, action: #selector(toSelectPetModal), for: .editingDidBegin)
        textField.isContextMenuInteractionEnabled = false
        return textField
    }()
    
    private lazy var searchButton:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Cari Hotel", styleBtn:.longOutline)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate   = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(ExploreTableViewCell.self, forCellReuseIdentifier: ExploreTableViewCell.cellId)
        tableView.separatorColor = .clear
        tableView.allowsSelection = true
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionHeaderTopPadding = 0
        tableView.backgroundColor = UIColor(named: "grey3")
        return tableView
    }()
    
    private func setupUI(){
        navigationController?.isNavigationBarHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        view.backgroundColor = UIColor(named: "primaryMain")
        navigationController?.navigationBar.tintColor = UIColor(named: "primaryMain")
        
        view.addSubview(scrollView)

        scrollView.addSubview(contentView)
        contentView.backgroundColor = UIColor(named: "grey3")
        contentView.addSubview(exploreRect)
        contentView.addSubview(exploreLabel)
        contentView.addSubview(searchLocation)
        contentView.addSubview(searchDate)
        contentView.addSubview(searchPet)
        contentView.addSubview(searchButton)
        contentView.addSubview(searchLocView)
        contentView.addSubview(searchDateView)
        contentView.addSubview(searchPetView)
        contentView.addSubview(roundedCorner)
        contentView.addSubview(tableView)

        //MARK: Scroll View Constraints
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 15).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.refreshControl = refreshControl
        scrollView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        
        //MARK: Content view constraint
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor, constant: 1000).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        //MARK: Red Rectangle Constraints
        exploreRect.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        exploreRect.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        exploreRect.heightAnchor.constraint(equalToConstant: 450).isActive = true
        exploreRect.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        
        //MARK: Explore Label Constraints
        exploreLabel.topAnchor.constraint(equalTo: exploreRect.topAnchor, constant: 68).isActive = true
        exploreLabel.leftAnchor.constraint(equalTo: exploreRect.leftAnchor, constant: 16).isActive = true
        exploreLabel.rightAnchor.constraint(equalTo: exploreRect.rightAnchor, constant: -16).isActive = true
        exploreLabel.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        //MARK: Search Location Constraints
        searchLocation.topAnchor.constraint(equalTo: exploreLabel.bottomAnchor, constant: 20).isActive = true
        searchLocation.leftAnchor.constraint(equalTo: exploreRect.leftAnchor, constant: 16).isActive = true
        searchLocation.rightAnchor.constraint(equalTo: exploreRect.rightAnchor, constant: -16).isActive = true
        searchLocation.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        searchLocView.topAnchor.constraint(equalTo: exploreLabel.bottomAnchor, constant: 20).isActive = true
        searchLocView.leftAnchor.constraint(equalTo: exploreRect.leftAnchor, constant: 16).isActive = true
        searchLocView.rightAnchor.constraint(equalTo: exploreRect.rightAnchor, constant: -16).isActive = true
        searchLocView.heightAnchor.constraint(equalToConstant: 44).isActive = true

        //MARK: Search Date Constraints
        searchDate.topAnchor.constraint(equalTo: searchLocation.bottomAnchor, constant: 12).isActive = true
        searchDate.leftAnchor.constraint(equalTo: exploreRect.leftAnchor, constant: 16).isActive = true
        searchDate.rightAnchor.constraint(equalTo: exploreRect.rightAnchor, constant: -16).isActive = true
        searchDate.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        searchDateView.topAnchor.constraint(equalTo: searchLocation.bottomAnchor, constant: 12).isActive = true
        searchDateView.leftAnchor.constraint(equalTo: exploreRect.leftAnchor, constant: 16).isActive = true
        searchDateView.rightAnchor.constraint(equalTo: exploreRect.rightAnchor, constant: -16).isActive = true
        searchDateView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        //MARK: Search Pet Constraints
        searchPet.topAnchor.constraint(equalTo: searchDate.bottomAnchor, constant: 12).isActive = true
        searchPet.leftAnchor.constraint(equalTo: exploreRect.leftAnchor, constant: 16).isActive = true
        searchPet.rightAnchor.constraint(equalTo: exploreRect.rightAnchor, constant: -16).isActive = true
        searchPet.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        searchPetView.topAnchor.constraint(equalTo: searchDate.bottomAnchor, constant: 12).isActive = true
        searchPetView.leftAnchor.constraint(equalTo: exploreRect.leftAnchor, constant: 16).isActive = true
        searchPetView.rightAnchor.constraint(equalTo: exploreRect.rightAnchor, constant: -16).isActive = true
        searchPetView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        //MARK: Search Button Constraints
        searchButton.topAnchor.constraint(equalTo: searchPet.bottomAnchor, constant: 20).isActive = true
        searchButton.leftAnchor.constraint(equalTo: exploreRect.leftAnchor, constant: 16).isActive = true
        searchButton.rightAnchor.constraint(equalTo: exploreRect.rightAnchor, constant: -16).isActive = true
        
        //        MARK: Rounded Corner Constraints
        roundedCorner.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        roundedCorner.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        roundedCorner.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        roundedCorner.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        roundedCorner.bottomAnchor.constraint(equalTo: exploreRect.bottomAnchor).isActive = true
        
        //MARK: Table View Constraints
        tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 450).isActive = true
        tableView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24).isActive = true
        tableView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24).isActive = true
        tableView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        tableViewHeightConstraint = tableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 216)
        tableViewHeightConstraint!.isActive = true
    }
    
    //MARK: -ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        Task {
            await exploreViewModel.fetchExploreList()
        }
    }
    
    //MARK: -ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        NotificationCenter.default.addObserver(self, selector: #selector(changeToTabBar(notification:)), name: .orderName, object: nil)
        
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
        Task {
            exploreViewModel.getAllPet()
            exploreViewModel.checkUUIDUser()
            await exploreViewModel.fetchExploreList()
        }
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        exploreViewModel.genericHandlingErrorObserver.skip(1).subscribe(onNext: { [self] (value) in
            switch value {
            case .objectNotFound:
                self.present(genericAlert(titleAlert: "Pet Hotel Tidak Ada!", messageAlert: "Pet Hotel tidak ada, silahkan coba lagi nanti.", buttonText: "Ok"), animated: true)
            case .success:
                print("Sukses Console 200")
            default:
                self.present(genericAlert(titleAlert: "Terjadi Gangguan server!", messageAlert: "Terjadi kesalahan dalam melakukan pencarian booking, silahkan coba lagi nanti.", buttonText: "Ok"), animated: true)
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
        exploreViewModel.petHotelModelArrayObserver.subscribe(onNext: { [self] (value) in
            petHotelList.accept(value)
            DispatchQueue.main.async { [self] in
                refreshControl.endRefreshing()
                tableViewHeightConstraint!.constant = CGFloat(petHotelList.value.count*216)
                view.layoutIfNeeded()
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
        exploreViewModel.petModelArrayObserver.subscribe(onNext: { [self] (value) in
            petsSelectionModelArray.accept(value)
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        petsSelectionModelArrayObserver.skip(1).subscribe(onNext: { [self] (value) in
            let pets = petsSelectionModelArray.value.map { obj -> PetBody in
                return PetBody(petName: obj.petName!, petType: obj.petType!, petSize: obj.petSize!)
            }
            petsBodyModelArray.accept(pets)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        modalSelectPetViewController.petsBodhyModelArrayObserver.skip(1).subscribe(onNext: { [self] (value) in
            exploreViewModel.petBody.accept(value)
            exploreViewModel.petSelection.accept(petsSelectionModelArray.value)
            exploreViewModel.configureHewanCounterLabel()
            petsBodyModelArray.accept(value)
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        exploreViewModel.jumlahHewanObjectObserver.skip(1).subscribe(onNext: { (value) in
            DispatchQueue.main.async { [self] in
                searchPet.attributedPlaceholder = attributedTextForSearchTextfield(value)
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
        modalSelectPetViewController.petsSelectionModelArrayObserver.subscribe(onNext: { [self] (value) in
            petsSelectionModelArray.accept(value)
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        modalSelectPetViewController.petsSelectedModelArrayObserver.subscribe(onNext: { [self] (value) in
            petSelectedModelArray.accept([])
            petSelectedModelArray.accept(value)
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Bind Journal List with Table View
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        petHotelList.bind(to: tableView.rx.items(cellIdentifier: ExploreTableViewCell.cellId, cellType: ExploreTableViewCell.self)) { row, model, cell in
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 12
            cell.selectedBackgroundView = backgroundView
            cell.petHotelSupportedObject.accept(model.petHotelSupportedPet)
            cell.setup(model)
        }.disposed(by: bags)
        
        //MARK: - Bind Journal List with Table View
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        tableView.rx.itemSelected.subscribe(onNext: { [self] (indexPath) in
            self.tableView.deselectRow(at: indexPath, animated: true)
            let petHotelViewController = PetHotelViewController()
            petHotelViewController.modalPresentationStyle = .fullScreen
            petHotelViewController.hidesBottomBarWhenPushed = true
            petHotelViewController.petHotelDetailID.accept(petHotelList.value[indexPath.row].petHotelID)
            self.navigationController?.pushViewController(petHotelViewController, animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        exploreViewModel.searchPetHotelModelArrayObserver.skip(1).subscribe(onNext: { (value) in
            DispatchQueue.main.async { [self] in
                let vc = SearchExploreViewController()
                vc.petHotelList.accept(value)
                vc.modalSearchLocationObject.accept(ExploreSearchBody(longitude: modalSearchLocationObject.value.longitude, latitude: modalSearchLocationObject.value.latitude, checkInDate: checkFinalObject.value.checkInDate, checkOutDate: checkFinalObject.value.checkOutDate, pets: petsBodyModelArray.value))
                vc.locationNameObject.accept(modalSearchLocationObject.value.locationName)
                navigationController?.pushViewController(vc, animated: true)
            }
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Bind Journal List with Table View
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        searchButton.rx.tap.bind { [self] in
            Task {
                exploreViewModel.exploreSearchBodyObject.accept(ExploreSearchBody(longitude: modalSearchLocationObject.value.longitude, latitude: modalSearchLocationObject.value.latitude, checkInDate: checkFinalObject.value.checkInDate, checkOutDate: checkFinalObject.value.checkOutDate, pets: petsBodyModelArray.value))
                await exploreViewModel.fetchSearchExploreList()
            }
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
            await exploreViewModel.fetchExploreList()
        }
    }
    
    //MARK: - Bind Journal List with Table View
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    @objc func toSearchModal() {
        let vc = ModalSearchLocationViewController()
        vc.modalPresentationStyle = .pageSheet
        //MARK: - Bind Journal List with Table View
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        vc.modalSearchObjectObserver.skip(1).subscribe(onNext: { [self] (value) in
            modalSearchLocationObject.accept(value)
            DispatchQueue.main.async { [self] in
                searchLocation.attributedPlaceholder = attributedTextForSearchTextfield(value.locationName)
            }
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        self.present(vc, animated: true)
    }

    //MARK: - Bind Journal List with Table View
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    @available(iOS 16.0, *)
    @objc func toDateModal() {
        let vc = ModalCheckInOutViewController()
        vc.modalPresentationStyle = .pageSheet
        //MARK: - Bind Journal List with Table View
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        vc.checkFinalObjectObserver.skip(1).subscribe(onNext: { [self] (value) in
            checkFinalObject.accept(value)
            DispatchQueue.main.async { [self] in
                searchDate.attributedPlaceholder = attributedTextForSearchTextfield("\(value.checkInDate) - \(value.checkOutDate)")
            }
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        self.present(vc, animated: true)
    }
    
    //MARK: - Bind Journal List with Table View
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    @objc func toSelectPetModal() {
        modalSelectPetViewController.petSelectionModelArray.accept(petsSelectionModelArray.value)
        modalSelectPetViewController.petSelectedModelArray.accept(petSelectedModelArray.value)
        modalSelectPetViewController.petBodyModelArray.accept([])
        modalSelectPetViewController.modalPresentationStyle = .pageSheet
        modalSelectPetViewController.isModalInPresentation  = true
        present(modalSelectPetViewController, animated: true)
    }
    
    
    //MARK: - Bind Journal List with Table View
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    @objc func changeToTabBar(notification: NSNotification) {
        if let tabBarController = self.navigationController?.tabBarController  {
            tabBarController.selectedIndex = 3
        }
    }
}

//MARK: UITableViewDataSource, UITableViewDelegate
@available(iOS 16.0, *)
extension ExploreViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 216
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        if section>=1{
            return 32
        }
        return 0
    }
}
