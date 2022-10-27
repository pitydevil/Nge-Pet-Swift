//
//  FasilitasViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 25/10/22.
//

import UIKit

class FasilitasViewController: UIViewController {

    //MARK: Subviews
    private lazy var customBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Tutup", showText: .notShow)
        customBar.barBtn.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        customBar.barBtn.isEnabled = true
        customBar.barBtn.configuration?.baseBackgroundColor = UIColor(named: "grey2")
        customBar.barBtn.configuration?.baseForegroundColor = UIColor(named: "white")
        return customBar
    }()
    
    private lazy var sesuaiPaket:ReuseableLabel = ReuseableLabel(labelText: "*) Sesuai Paket", labelType: .bodyP2, labelColor: .grey1)
    
    private lazy var headline: ReuseableLabel = {
        let headline = ReuseableLabel(labelText: "Fasilitas yang Ditawarkan", labelType: .titleH1, labelColor: .black)
        return headline
    }()
    
    private lazy var facilityTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(FasilitasTableViewCell.self, forCellReuseIdentifier: FasilitasTableViewCell.cellId)
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "white")
        return tableView
    }()
    
    @objc func dismissModal() {
        dismiss(animated: true)
    }
    
    //MARK: viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "white")
        // Do any additional setup after loading the view.
        view.addSubview(headline)
        view.addSubview(facilityTableView)
        view.addSubview(customBar)
        
        headline.topAnchor.constraint(equalTo: view.topAnchor, constant: 48).isActive = true
        headline.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        headline.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        
        customBar.addSubview(sesuaiPaket)
        customBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        customBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        customBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        sesuaiPaket.leftAnchor.constraint(equalTo: customBar.leftAnchor, constant: 24).isActive = true
        sesuaiPaket.topAnchor.constraint(equalTo: customBar.topAnchor, constant: 37).isActive = true
        
        facilityTableView.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 40).isActive = true
        facilityTableView.bottomAnchor.constraint(equalTo: customBar.topAnchor).isActive = true
        facilityTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        facilityTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
    }
    
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension FasilitasViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FasilitasTableViewCell.cellId) as! FasilitasTableViewCell
        cell.configureView(image: UIImage(named: "mapIcon")!, description: "Pembersihan Tempat Makan", add: true)
        cell.backgroundColor = .clear
        return cell
    }
    
    
}
