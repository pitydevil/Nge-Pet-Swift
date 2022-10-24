//
//  ModalSearchLocationViewController.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 24/10/22.
//

import UIKit

class ModalSearchLocationViewController: UIViewController {
    
    let data = ["Cakung, Jakarta Timur, Jakarta 13955",
                "Medan Satria, Bekasi, Jawa Barat 14212",
                "Jatinangor, Sumedang, Jawa barat 12301",
                "Jatinangor, Sumedang, Jawa Barat asdasdkjasndajshdhbubhdjhvsjjsvjghvjsgdyufsgufygsuyfgsudyfsba",]
    
    var filteredData: [String]!
    
    private lazy var indicator: UIImageView = {
        let indicator = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
        indicator.image = UIImage(systemName: "minus", withConfiguration: config)
        indicator.tintColor = UIColor(named: "grey2")
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var headline: ReuseableLabel = {
        let headline = ReuseableLabel(labelText: "Cari Pet Hotel", labelType: .titleH1, labelColor: .black)
        return headline
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.searchBarStyle = .prominent
        searchBar.searchTextField.font = UIFont(name: "Inter-Medium", size: 12)
        searchBar.searchTextField.backgroundColor = UIColor(named: "grey3")
        searchBar.searchTextField.layer.cornerRadius = 8
        searchBar.tintColor = UIColor(named: "grey1")
        searchBar.barTintColor = UIColor(named: "white")
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = searchBar.barTintColor?.cgColor
        searchBar.placeholder = "Cari Hewan"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var modalTableView: UITableView = {
        let modalTableView = UITableView(frame: CGRect(), style: .plain)
        modalTableView.delegate = self
        modalTableView.dataSource = self
        modalTableView.backgroundColor = UIColor(named: "white")
        modalTableView.translatesAutoresizingMaskIntoConstraints = false
        modalTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        modalTableView.showsVerticalScrollIndicator = false
        modalTableView.isScrollEnabled = true
        modalTableView.separatorStyle = .singleLine
        return modalTableView
    }()
    
    private lazy var customBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Lanjut", showText: .notShow)
        customBar.barBtn.addTarget(self, action: #selector(searchSelected), for: .touchUpInside)
        return customBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "white")
        
        filteredData = data
        
        //MARK: - Add Subview
        view.addSubview(indicator)
        view.addSubview(headline)
        view.addSubview(searchBar)
        view.addSubview(modalTableView)
        view.addSubview(customBar)
        
        //MARK: - Setup Constraint
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),

            headline.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            headline.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            headline.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -198),
            
            searchBar.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            customBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            modalTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            modalTableView.widthAnchor.constraint(equalToConstant: 342),
            modalTableView.bottomAnchor.constraint(equalTo: customBar.topAnchor, constant: -20),
            modalTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
        ])

    }
    
    @objc func searchSelected() {
        dismiss(animated: true)
    }

}

extension ModalSearchLocationViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = []
        
        if searchText == "" {
            filteredData = data
        } else {
            for fruit in data {
                if fruit.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(fruit)
                }
            }
        }
        self.modalTableView.reloadData()
    }
}

extension ModalSearchLocationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        
        cell.textLabel?.text = filteredData[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Inter-Medium", size: 12)
        cell.textLabel?.numberOfLines = 3
        cell.backgroundColor = UIColor(named: "grey3")
        cell.layer.cornerRadius = 8
        
        return cell
    }
    
}
