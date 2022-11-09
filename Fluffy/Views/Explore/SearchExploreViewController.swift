//
//  SearchExploreViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 02/11/22.
//

import UIKit

class SearchExploreViewController: UIViewController, UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }

    //MARK: Subviews
    private lazy var searchTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 306, height: 40))
        textField.setLeftView(image: UIImage(systemName: "magnifyingglass")!, color: UIColor(named: "grey1")!)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "grey3")
        textField.layer.cornerRadius = 12
        textField.attributedPlaceholder = NSAttributedString(string: "lokasi", attributes: [
            .foregroundColor: UIColor(named: "grey1") as Any,
            .font: UIFont(name: "Inter-Medium", size: 12)!
        ])
        textField.allowsEditingTextAttributes = false
//        textField.addTarget(self, action: #selector(toSelectPetModal), for: .editingDidBegin)
        return textField
    }()
    private lazy var navTitle:ReuseableLabel = ReuseableLabel(labelText: "Hasil Pencarian", labelType: .titleH2, labelColor: .black)
    
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = true
        sc.searchBar.placeholder = "lokasi"
        sc.searchBar.barTintColor = UIColor(named: "grey1")
        return sc
    }()
    lazy var leftButton:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Hari Ini", styleBtn:.normal,icon: UIImage(systemName: "calendar"))
        btn.configuration?.attributedTitle = AttributedString("Hari Ini", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 12)!]))
        btn.configuration?.baseBackgroundColor = UIColor(named: "grey3")
        btn.configuration?.baseForegroundColor = UIColor(named: "grey1")
        btn.translatesAutoresizingMaskIntoConstraints = false
        //        btn.addTarget(self, action: #selector(selectDate), for: .touchUpInside)
        return btn
    }()
    
    lazy var rightButton:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Semua Hewan", styleBtn:.normal,icon: UIImage(systemName: "pawprint.fill"))
        btn.configuration?.attributedTitle = AttributedString("Semua Hewan", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 12)!]))
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.configuration?.baseBackgroundColor = UIColor(named: "grey3")
        btn.configuration?.baseForegroundColor = UIColor(named: "grey1")
        
        //        btn.addTarget(self, action: #selector(selectDate), for: .touchUpInside)
        return btn
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(ExploreTableViewCell.self, forCellReuseIdentifier: ExploreTableViewCell.cellId)
        tableView.separatorColor = .clear
        tableView.allowsSelection = true
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "white")
//        self.navigationItem.searchController = searchController
        self.navigationItem.titleView = navTitle
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = UIColor(named: "primaryMain")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view.

        view.addSubview(searchTextField)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(tableView)
 
        searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        searchTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true

        leftButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        leftButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 12).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: (view.frame.size.width-52)/2).isActive = true
        
        rightButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        rightButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        rightButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 12).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: (view.frame.size.width-52)/2).isActive = true
        
        tableView.topAnchor.constraint(equalTo: leftButton.bottomAnchor, constant: 40).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}

@available(iOS 16.0, *)
extension SearchExploreViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 20
        }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: ExploreTableViewCell.cellId) as! ExploreTableViewCell
            cell.backgroundColor = .clear
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 248
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newViewController = PetHotelViewController()
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
