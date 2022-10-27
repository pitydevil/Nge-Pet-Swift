//
//  PetSizeViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 25/10/22.
//

import UIKit

class PetSizeViewController: UIViewController {

    //MARK: Subviews
    private lazy var customBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Tutup", showText: .notShow)
//        customBar.barBtn.addTarget(self, action: #selector(checkinSelected), for: .touchUpInside)
        customBar.barBtn.isEnabled = true
        customBar.barBtn.configuration?.baseBackgroundColor = UIColor(named: "grey2")
        customBar.barBtn.configuration?.baseForegroundColor = UIColor(named: "white")
        customBar.barBtn.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        return customBar
    }()
    
    private lazy var sesuaiPaket:ReuseableLabel = ReuseableLabel(labelText: "*) Sesuai Paket", labelType: .bodyP2, labelColor: .grey1)
    
    private lazy var headline: ReuseableLabel = {
        let headline = ReuseableLabel(labelText: "Ukuran Hewan", labelType: .titleH1, labelColor: .black)
        return headline
    }()
    
    private lazy var petSizeTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(PetSizeExplainationTableViewCell.self, forCellReuseIdentifier: PetSizeExplainationTableViewCell.cellId)
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "white")
        tableView.estimatedRowHeight = 128
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    @objc func dismissModal() {
        dismiss(animated: true)
    }
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "white")
        view.addSubview(headline)
        view.addSubview(petSizeTableView)
        view.addSubview(customBar)
        
        headline.topAnchor.constraint(equalTo: view.topAnchor, constant: 48).isActive = true
        headline.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        headline.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        
        customBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        customBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        customBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        petSizeTableView.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 40).isActive = true
        petSizeTableView.bottomAnchor.constraint(equalTo: customBar.topAnchor).isActive = true
        petSizeTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        petSizeTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        
    }
    
}
//MARK: UITableViewDelegate, UITableViewDataSource
extension PetSizeViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PetSizeExplainationTableViewCell.cellId) as! PetSizeExplainationTableViewCell
        cell.configureView(petTypeString: "Kucing Kecil (S)", description: "Kucing kecil merupakan kucing dengan ukuran panjang kurang dari xx cm. Ras kucing yang biasanya termasuk kucing kecil adalah xxx, xxx, dan xxx.")
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
}
