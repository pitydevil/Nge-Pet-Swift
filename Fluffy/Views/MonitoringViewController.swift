//
//  MonitoringViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 13/10/22.
//

import UIKit

@available(iOS 16.0, *)
class MonitoringViewController: UIViewController {
    
    //MARK: Subviews
    private lazy var dateButton:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Hari Ini         ", styleBtn:.normal, icon: UIImage(systemName: "calendar"))
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
        tableView.delegate = self
        tableView.dataSource = self
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
    
    //MARK: -ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(named: "grey3")
        view.addSubview(dateButton)
        view.addSubview(selectPetButton)
        view.addSubview(tableView)
        setupLayout()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    @objc func selectPetModal(){
        let vc = ModalMonitoringViewController()
        vc.modalPresentationStyle = .pageSheet
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
    
}

//MARK: UICalendarSelectionSingleDateDelegate
@available(iOS 16.0, *)
extension MonitoringViewController: UICalendarSelectionSingleDateDelegate {
    @available(iOS 16.0, *)
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        let currentDate = Date()
        let currentYear = Calendar.current.component(.year, from: Date())
        let df = DateFormatter()
        var titleLbl = ""
        
        if dateComponents?.year == currentYear && dateComponents?.date != currentDate{
            df.dateFormat = "dd MMM"
            titleLbl = df.string(from: (dateComponents?.date)!)
        }
        else{
            df.dateFormat = "dd MMM yy"
            titleLbl = df.string(from: (dateComponents?.date)!)
        }
        df.dateFormat = "dd MMM"
        let currDate = df.string(from: (currentDate))
        if currDate == titleLbl{
            titleLbl = "Hari Ini"
        }
        
        dateButton.titleLabel?.text = titleLbl
        calendarView.removeFromSuperview()
    }
}

//MARK: Setup Layout
@available(iOS 16.0, *)
extension MonitoringViewController{
    func setupLayout(){
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
    }
}

//MARK: UITableViewDataSource, UITableViewDelegate

@available(iOS 16.0, *)
extension MonitoringViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MonitoringTableViewCell.cellId) as! MonitoringTableViewCell
        cell.backgroundColor = .clear
        cell.configure(location: "Attlasian Pet Hotel", cardTitleString: "Kasih Makan ", timestamp: "7m", description: "Royal canin y, kucing sultan ni Royal canin y, kucing sultan ni Royal canin y, kucing sultan ni Royal canin y, kucing sultan ni Royal canin y, kucing sultan ni", petImage: "pugIcon", dogNameString: "Blekki Irrrrrrr", carouselData: [CarouselData(image: UIImage(named: "slide1")), CarouselData(image: UIImage(named: "slide2")), CarouselData(image: UIImage(named: "slide3")), CarouselData(image: UIImage(named: "slide1")), CarouselData(image: UIImage(named: "slide2"))], isNew: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: UICalendarViewDelegate
@available(iOS 16.0, *)
extension MonitoringViewController: UICalendarViewDelegate{
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
}
