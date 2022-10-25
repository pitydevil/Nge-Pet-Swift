//
//  RulesViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 25/10/22.
//

import UIKit

class RulesViewController: UIViewController {

    //MARK: Subviews
    private lazy var customBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Tutup", showText: .notShow)
//        customBar.barBtn.addTarget(self, action: #selector(checkinSelected), for: .touchUpInside)
        customBar.barBtn.isEnabled = false
        customBar.barBtn.configuration?.baseBackgroundColor = UIColor(named: "grey2")
        customBar.barBtn.configuration?.baseForegroundColor = UIColor(named: "white")
        return customBar
    }()
    
    private lazy var sesuaiPaket:ReuseableLabel = ReuseableLabel(labelText: "*) Sesuai Paket", labelType: .bodyP2, labelColor: .grey1)
    
    private lazy var headline: ReuseableLabel = {
        let headline = ReuseableLabel(labelText: "Peraturan dan Kebijakan", labelType: .titleH1, labelColor: .black)
        return headline
    }()
    
    private lazy var rulesTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(PetHotelDetailTableViewCell.self, forCellReuseIdentifier: PetHotelDetailTableViewCell.cellId)
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "white")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "white")
        // Do any additional setup after loading the view.
        view.addSubview(headline)
        view.addSubview(rulesTableView)
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
        
        rulesTableView.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 40).isActive = true
        rulesTableView.bottomAnchor.constraint(equalTo: customBar.topAnchor).isActive = true
        rulesTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        rulesTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RulesViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PetHotelDetailTableViewCell.cellId) as! PetHotelDetailTableViewCell
        cell.configureView(tabelType: "rules", description: "Fasilitas tambahan akan dikenakan biaya tambahan")
        cell.backgroundColor = .clear
        return cell
    }
    
    
}
