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
    private var monitoringModelArray   = BehaviorRelay<[Monitoring]>(value: [])
    private let monitoringViewModel    = MonitoringViewModel()
    
    //MARK: Subviews
    private lazy var dateButton:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Hari Ini", styleBtn:.normal, icon: UIImage(systemName: "calendar"))
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(selectDate), for: .touchUpInside)
        return btn
    }()
    
    private lazy var selectPetButton:ReusableButton = {
        var config = UIImage.SymbolConfiguration(hierarchicalColor: UIColor(named: "primaryMain") ?? .systemPink)
        config = config.applying(UIImage.SymbolConfiguration(weight: .bold))
        let btn = ReusableButton(titleBtn: "Semua Hewan", styleBtn: .frameless, icon: UIImage(systemName: "chevron.down", withConfiguration: config))
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(selectPetModal), for: .touchUpInside)
        return btn
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor(named: "grey3")
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
        self.navigationController?.isNavigationBarHidden = true
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
        tableView.reloadData()
    }
    
    @objc func selectPetModal(){
        let vc = ModalMonitoringViewController()
        vc.modalPresentationStyle = .pageSheet
        vc.completion = { [weak self] text in
            DispatchQueue.main.async {
                self?.selectPetButton.self.configuration?.attributedTitle = AttributedString(text ?? self!.selectPetButton.titleBtn, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16)!]))
            }
        }
        self.present(vc, animated: true)
    }
    
    @objc func selectDate(){
        view.addSubview(calendarView)
        calendarView.delegate = self
        let selection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selection
        
        //MARK: - Calendar View Constraints
        calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        calendarView.heightAnchor.constraint(equalToConstant: 356).isActive = true
        calendarView.widthAnchor.constraint(equalToConstant: 312).isActive = true
        calendarView.topAnchor.constraint(equalTo: dateButton.bottomAnchor, constant: 20).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Task {
            monitoringViewModel.tanggalEndpointModelObject.accept(changeDateIntoYYYYMMDD(Date()))
            await monitoringViewModel.fetchMonitoring()
        }
    }
    
    //MARK: -ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        monitoringViewModel.titleDateModelObjectObserver.skip(1).subscribe(onNext: { [self] (value) in
            DispatchQueue.main.async { [self] in
                dateButton.titleLabel?.text = value
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
            monitoringViewModel.tanggalEndpointModelObject.accept(value)
            Task {
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
    }
}

//MARK: UICalendarSelectionSingleDateDelegate
@available(iOS 16.0, *)
extension MonitoringViewController: UICalendarSelectionSingleDateDelegate {
    @available(iOS 16.0, *)
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        print("masuk?")
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
