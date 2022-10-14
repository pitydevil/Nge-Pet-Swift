//
//  MonitoringViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 13/10/22.
//

import UIKit

class MonitoringViewController: UIViewController {
    
    //MARK: Subviews
    private lazy var dateButton:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Hari Ini", styleBtn:.normal, icon: UIImage(systemName: "calendar"))
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var selectPetButton:ReusableButton = {
        var config = UIImage.SymbolConfiguration(hierarchicalColor: UIColor(named: "primaryMain") ?? .systemPink)
        config = config.applying(UIImage.SymbolConfiguration(weight: .bold))
        let btn = ReusableButton(titleBtn: "Semua Hewan", styleBtn: .frameless, icon: UIImage(systemName: "chevron.down", withConfiguration: config))
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var tableView = UITableView()
    
    //MARK: -ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(named: "grey3")
        view.addSubview(dateButton)
        view.addSubview(selectPetButton)
        view.addSubview(tableView)
        setupLayout()
    }
    
    func configTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor(named: "grey3")
        tableView.register(MonitoringTableViewCell.self, forCellReuseIdentifier: MonitoringTableViewCell.cellId)
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        //        tableView.rowHeight = 500
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension MonitoringViewController{
    func setupLayout(){
        dateButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        dateButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        dateButton.leftAnchor.constraint(greaterThanOrEqualTo: selectPetButton.rightAnchor, constant: 20).isActive = true
        
        selectPetButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        selectPetButton.centerYAnchor.constraint(equalTo: dateButton.centerYAnchor).isActive = true
        
        configTableView()
        tableView.topAnchor.constraint(equalTo: selectPetButton.bottomAnchor, constant: 40).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        tableView.rightAnchor.constraint(equalTo: dateButton.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension MonitoringViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MonitoringTableViewCell.cellId) as! MonitoringTableViewCell
        cell.backgroundColor = .clear
        cell.configure(location: "Klaten Klaten Klaten Klaten Klaten Klaten", cardTitleString: "Kasih Makan Kasih Makan ", timestamp: "7m", description: "Beri makan Beri makan Beri makan Beri makan Beri makan Beri makan Beri makan Beri makan Beri makan Beri makan Beri makan", petImage: "pugIcon", dogNameString: "Blekki Irrrrrrr")
        cell.carouselView.configureView(with: [CarouselData(image: UIImage(named: "slide1")), CarouselData(image: UIImage(named: "slide2")), CarouselData(image: UIImage(named: "slide3"))])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
//        return 600
    }
    

}

