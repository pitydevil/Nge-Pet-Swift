//
//  MonitoringViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 13/10/22.
//

import UIKit
import RxSwift
import RxCocoa

@available(iOS 16.0, *)
class MonitoringViewController: UIViewController {
    
    //MARK: OBJECT DECLARATION
    private var dateModelObject           = BehaviorRelay<DateComponents>(value: DateComponents())
    private var monitoringModelArray      = BehaviorRelay<[Monitoring]>(value: [])
    private var petsSelectionModelArray   = BehaviorRelay<[PetsSelection]>(value: [])
    private var petsBodyModelArray        = BehaviorRelay<[PetBody]>(value: [])
    private var petSelectedModelArray     = BehaviorRelay<[PetsSelection]>(value: [])
    private let monitoringViewModel       = MonitoringViewModel()
    private let modalSelectPetViewController = ModalSelectPetViewController()
    var tanggalEndpointModelObject        = BehaviorRelay<String>(value: changeDateIntoYYYYMMDD(Date()))
  
    //MARK: OBJECT OBSERVER DECLARATION
    var petsSelectionModelArrayObserver : Observable<[PetsSelection]> {
        return petsSelectionModelArray.asObservable()
    }
    
    //MARK: OBJECT OBSERVER DECLARATION
    var petBodyModelArrayObserver : Observable<[PetBody]> {
        return petsBodyModelArray.asObservable()
    }
    
    //MARK: Subviews
    private var refreshControl : UIRefreshControl  =  {
        let refresh = UIRefreshControl()
        return refresh
    }()
    
    private lazy var dateButton:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Hari Ini", styleBtn:.normal, icon: UIImage(systemName: "calendar"))
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var selectPetButton:ReusableButton = {
        var config = UIImage.SymbolConfiguration(hierarchicalColor: UIColor(named: "primaryMain") ?? .systemPink)
        config = config.applying(UIImage.SymbolConfiguration(weight: .bold))
        var btn = ReusableButton(titleBtn: "Semua Hewan", styleBtn: .frameless, icon: UIImage(systemName: "chevron.down", withConfiguration: config))
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(MonitoringTableViewCell.self, forCellReuseIdentifier: MonitoringTableViewCell.cellId)
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var calendarView:UICalendarView = {
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        
        calendarView.backgroundColor = UIColor(named: "white")
        calendarView.tintColor = UIColor(named: "primaryMain")
        calendarView.availableDateRange = DateInterval(start: .distantPast, end: .now)
        calendarView.layer.cornerRadius = 12
        
        calendarView.layer.borderColor = UIColor.lightGray.cgColor
        calendarView.layer.shadowOpacity = 0.1
        calendarView.layer.shadowOffset = CGSize.zero
        calendarView.layer.shadowRadius = 5

        return calendarView
    }()
    
    private func setupUI() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(named: "grey3")
        view.addSubview(dateButton)
        view.addSubview(selectPetButton)
        view.addSubview(tableView)
        //MARK: Date Button Constraint
        dateButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 12).isActive = true
        dateButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        dateButton.leftAnchor.constraint(greaterThanOrEqualTo: selectPetButton.rightAnchor, constant: 20).isActive = true
        dateButton.widthAnchor.constraint(equalToConstant: 132).isActive = true
        
        //MARK: Select Pet Button Constraints
        selectPetButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        selectPetButton.centerYAnchor.constraint(equalTo: dateButton.centerYAnchor).isActive = true
        
        //MARK: Table View Constraints
        tableView.topAnchor.constraint(equalTo: selectPetButton.bottomAnchor, constant: 40).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        tableView.rightAnchor.constraint(equalTo: dateButton.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //MARK: - REFRESH CONTROL
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        tableView.addSubview(refreshControl)
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
        Task {
            monitoringViewModel.getAllPet()
        }
        
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
        monitoringViewModel.genericHandlingErrorObserver.skip(1).subscribe(onNext: { [self] (value) in
            switch value {
            case .objectNotFound:
                self.present(genericAlert(titleAlert: "Monitoring Tidak Ada!", messageAlert: "Monitoring tidak ada, silahkan coba lagi nanti.", buttonText: "Ok"), animated: true)
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
        petBodyModelArrayObserver.skip(1).subscribe(onNext: { [self] (value) in
            Task {
                monitoringViewModel.monitoringBodyModelObject.accept(MonitoringBody(userID: userID, date: tanggalEndpointModelObject.value, pets: value))
                await monitoringViewModel.fetchMonitoring()
            }
        }).disposed(by: bags)

        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        monitoringViewModel.petModelArrayObserver.skip(1).subscribe(onNext: { [self] (value) in
            petsSelectionModelArray.accept(value)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        monitoringViewModel.titleDateModelObjectObserver.skip(1).subscribe(onNext: { [self] (value) in
            DispatchQueue.main.async { [self] in
                dateButton.setAttributeTitleText(value, 16)
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
        monitoringViewModel.tanggalModelObjectObserver.skip(1).subscribe(onNext: { [self] (value) in
            tanggalEndpointModelObject.accept(value)
            Task {
                monitoringViewModel.monitoringBodyModelObject.accept(MonitoringBody(userID: userID, date: value, pets: petsBodyModelArray.value))
                await monitoringViewModel.fetchMonitoring()
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
        monitoringViewModel.monitoringModelArrayObserver.skip(1).subscribe(onNext: { [self] (value) in
            DispatchQueue.main.async { [self] in
                refreshControl.endRefreshing()
            }
            monitoringModelArray.accept(value)
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        monitoringModelArray.bind(to: tableView.rx.items(cellIdentifier: MonitoringTableViewCell.cellId, cellType: MonitoringTableViewCell.self)) { row, model, cell in
            cell.backgroundColor = .clear
            cell.monitoringImageModelArray.accept(model.monitoringImage)
            cell.configure(model)
        }.disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        dateButton.rx.tap.bind { [self] in
            let selection = UICalendarSelectionSingleDate(delegate: self)
            view.addSubview(calendarView)
            calendarView.delegate = self
            calendarView.selectionBehavior = selection
            
            //MARK: - Calendar View Constraints
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            calendarView.heightAnchor.constraint(equalToConstant: 356).isActive = true
            calendarView.widthAnchor.constraint(equalToConstant: 312).isActive = true
            calendarView.topAnchor.constraint(equalTo: dateButton.bottomAnchor, constant: 20).isActive = true
        }.disposed(by: bags)
        
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
            petSelectedModelArray.accept(value)
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        modalSelectPetViewController.petsBodhyModelArrayObserver.skip(1).subscribe(onNext: { [self] (value) in
            monitoringViewModel.petBody.accept(value)
            monitoringViewModel.petSelection.accept(petsSelectionModelArray.value)
            monitoringViewModel.configureHewanCounterLabel()
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
        monitoringViewModel.jumlahHewanObjectObserver.skip(1).subscribe(onNext: { (value) in
            DispatchQueue.main.async { [self] in
                selectPetButton.setAttributeTitleText(value, 16)
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
        selectPetButton.rx.tap.bind { [self] in
            modalSelectPetViewController.petSelectionModelArray.accept(petsSelectionModelArray.value)
            modalSelectPetViewController.petSelectedModelArray.accept(petSelectedModelArray.value)
            modalSelectPetViewController.petBodyModelArray.accept([])
            modalSelectPetViewController.modalPresentationStyle = .pageSheet
            modalSelectPetViewController.isModalInPresentation  = true
            present(modalSelectPetViewController, animated: true)
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
            monitoringViewModel.monitoringBodyModelObject.accept(MonitoringBody(userID: userID, date: tanggalEndpointModelObject.value, pets: petsBodyModelArray.value))
            await monitoringViewModel.fetchMonitoring()
        }
    }
}

//MARK: UICalendarSelectionSingleDateDelegate
@available(iOS 16.0, *)
extension MonitoringViewController: UICalendarSelectionSingleDateDelegate {
    @available(iOS 16.0, *)
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        dateModelObject.accept(dateComponents!)
        monitoringViewModel.dateModelObject.accept(dateComponents!)
        monitoringViewModel.configureDate()
        calendarView.removeFromSuperview()
    }
}

//MARK: UICalendarViewDelegate
@available(iOS 16.0, *)
extension MonitoringViewController: UICalendarViewDelegate{
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
}
