//
//  SelectBookingDetailsViewController.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 01/11/22.
//

import UIKit

struct ExpandableNames {
    
    var isExpanded: Bool
    let names: [String]
}

class SelectBookingDetailsViewController: UIViewController {
    
    var switchChange = false
    
    var twoDimensionalArray = [
        ExpandableNames(isExpanded: true, names: ["Amy", "Budi", "Jono", "Arum", "Sugiono"]),
        ExpandableNames(isExpanded: true, names: ["Chris", "Jhon", "Dhoe", "Sam"]),
        ExpandableNames(isExpanded: true, names: ["David", "Dan", "Maria"]),
        ExpandableNames(isExpanded: true, names: ["Angela", "Balmond"]),
    ]

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.searchBarStyle = .prominent
        searchBar.searchTextField.font = UIFont(name: "Inter-Medium", size: 12)
        searchBar.searchTextField.backgroundColor = UIColor(named: "white")
        searchBar.searchTextField.layer.cornerRadius = 8
        searchBar.tintColor = UIColor(named: "grey1")
        searchBar.barTintColor = UIColor(named: "grey3")
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = searchBar.barTintColor?.cgColor
        searchBar.placeholder = "Cari Hewan"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var packageTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(named: "grey3")
        tableView.register(SelectPackageTableViewCell.self, forCellReuseIdentifier: SelectPackageTableViewCell.cellId)
        tableView.register(CatatanKhususTableViewCell.self, forCellReuseIdentifier: CatatanKhususTableViewCell.cellId)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(ExpandableHeaderView.self, forHeaderFooterViewReuseIdentifier: ExpandableHeaderView.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsMultipleSelection = true
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 0
        tableView.isScrollEnabled = true
        return tableView
    }()
    
    private lazy var btmBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Pilih Paket", showText: .notShow)
        customBar.barBtn.addTarget(self, action: #selector(pilihPaket), for: .touchUpInside)
        customBar.translatesAutoresizingMaskIntoConstraints = false
        customBar.backgroundColor = UIColor(named: "primaryMain")
        customBar.barBtn.configuration?.baseBackgroundColor = UIColor(named: "white")
        customBar.barBtn.configuration?.baseForegroundColor = UIColor(named: "primaryMain")
        return customBar
    }()
    
    private lazy var selectedPet: ReuseableLabel = ReuseableLabel(labelText: "1 Hewan Dipilih", labelType: .bodyP2, labelColor: .white)
    
    private lazy var perDay: ReuseableLabel = ReuseableLabel(labelText: "/hari", labelType: .bodyP2, labelColor: .white)
    
    private lazy var price: ReuseableLabel = ReuseableLabel(labelText: "Rp60.000", labelType: .titleH2, labelColor: .white)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "grey3")
        navigationItem.titleView = setTitle(title: "Katze Nesia Cat Hotel", subtitle: "Bekasi, Jawa Barat")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        view.addSubview(searchBar)
        view.addSubview(packageTableView)
        
        view.addSubview(btmBar)
        btmBar.addSubview(selectedPet)
        btmBar.addSubview(price)
        btmBar.addSubview(perDay)
        
        //MARK: - Setup Constraint
        NSLayoutConstraint.activate([
            
            //MARK: - searchbar const
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -680),
            
            //MARK: - tableview const
            packageTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            packageTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            packageTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            packageTableView.bottomAnchor.constraint(equalTo: btmBar.topAnchor, constant: -20),
            packageTableView.widthAnchor.constraint(equalToConstant: 342),
            
            //MARK: tabbar constraint
            btmBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            btmBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            btmBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            //MARK: start label constraint
            selectedPet.topAnchor.constraint(equalTo: btmBar.topAnchor, constant: 20),
            selectedPet.leftAnchor.constraint(equalTo: btmBar.leftAnchor, constant: 24),
            
            //MARK: price constraint
            price.topAnchor.constraint(equalTo: selectedPet.bottomAnchor, constant: 0),
            price.leftAnchor.constraint(equalTo: selectedPet.leftAnchor),
            
            //MARK: per day constraint
            perDay.leftAnchor.constraint(equalTo: price.rightAnchor),
            perDay.topAnchor.constraint(equalTo: price.topAnchor),
            perDay.bottomAnchor.constraint(equalTo: price.bottomAnchor),
        ])
        
    }
    
    @objc func pilihPaket() {
        let vc = BookingConfirmationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

}

//MARK: Navigation Title
extension SelectBookingDetailsViewController {
    func setTitle(title:String, subtitle:String) -> UIView {
        let titleLabel = UILabel(frame: CGRectMake(0, -2, 0, 0))

        titleLabel.backgroundColor = .clear
        titleLabel.textColor = UIColor(named: "black")
        titleLabel.font = UIFont(name: "Poppins-Bold", size: 16)
        titleLabel.text = title
        titleLabel.sizeToFit()

        let subtitleLabel = UILabel(frame: CGRectMake(0, 18, 0, 0))
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.textColor = UIColor(named: "black")
        subtitleLabel.font = UIFont(name: "Inter-Medium", size: 12)
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()

        let titleView = UIView(frame: CGRectMake(0, 0, max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), 30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)

        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width

        if widthDiff < 0 {
            let newX = widthDiff / 2
            subtitleLabel.frame.origin.x = abs(newX)
        } else {
            let newX = widthDiff / 2
            titleLabel.frame.origin.x = newX
        }

        return titleView
    }
    
    func makeTransparentNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundColor = .white
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}

//MARK: - SearchBar Delegate
extension SelectBookingDetailsViewController: UISearchBarDelegate {
    
}

extension SelectBookingDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ExpandableHeaderView.identifier) as! ExpandableHeaderView
        
        //MARK: - Add Pet Data Here
        headerView.configure(iconPackage: "poodle", namePet: "Bom Bom", sizePet: "Anjing Sedang", racePet: " - Poodle")
        headerView.switchBtn.addTarget(self, action: #selector(didChangeSwitch), for: .valueChanged)
        
        headerView.switchBtn.tag = section
        
        return headerView
    }
    
    @objc func didChangeSwitch(button: UISwitch) {
        switchChange = !switchChange
        let section = button.tag
        var indexPaths = [IndexPath]()
        if switchChange == false {
            print("switch off")
//            packageTableView.deleteRows(at: [indexPath], with: .fade)
        } else {
            print("switch on")
            print(packageTableView.indexPathsForVisibleRows!)
            print(indexPaths)
            packageTableView.deleteRows(at: indexPaths, with: .fade)
//            packageTableView.insertRows(at: IndexPath, with: .fade)
            
//            for row in twoDimensionalArray[section].names.indices {
//                let indexPath = IndexPath(row: row, section: section)
//                indexPaths.append(indexPath)
//            }
//            let isExpanded = twoDimensionalArray[section].isExpanded
//            twoDimensionalArray[section].isExpanded = !isExpanded
//
//            if isExpanded {
//                packageTableView.deleteRows(at: indexPaths, with: .fade)
//            } else {
//                packageTableView.insertRows(at: indexPaths, with: .fade)
//            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if switchChange == false {
//            return 0
//        } else {
//            return 2
//        }
//        if !twoDimensionalArray[section].isExpanded {
//            return 0
//        }
//        return twoDimensionalArray[section].names.count
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CatatanKhususTableViewCell.cellId, for: indexPath) as! CatatanKhususTableViewCell
            cell.contentView.backgroundColor = UIColor(named: "white")
            cell.configure(textDetails: "Tambah catatan khusus")
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectPackageTableViewCell.cellId, for: indexPath) as! SelectPackageTableViewCell
        cell.contentView.backgroundColor = UIColor(named: "white")
        cell.configure(textDetails: "Pilih paket hotel")
        return cell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let name = twoDimensionalArray[indexPath.section].names[indexPath.row]
//        cell.textLabel?.text = name
//        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = HotelPackageViewController()
            vc.modalPresentationStyle = .pageSheet
            self.present(vc, animated: true)
        } else if indexPath.row == 1 {
            print("go to custom sop")
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

    }
    
}
