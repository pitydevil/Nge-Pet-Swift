//
//  SelectBookingDetailsViewController.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 01/11/22.
//

import UIKit

struct ExpandableNames {
    var isExpanded: Bool = false
    var namesIs: String
}

@available(iOS 16.0, *)
class SelectBookingDetailsViewController: UIViewController {
    
    var filteredData: [ExpandableNames] = []
    
    var names = [
        ExpandableNames(isExpanded: false, namesIs: "Bonnie"),
        ExpandableNames(isExpanded: false, namesIs: "Chiron"),
        ExpandableNames(isExpanded: false, namesIs: "Budiman"),
        ExpandableNames(isExpanded: false, namesIs: "Toro"),
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
        let tableView = UITableView(frame: CGRect(), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(named: "grey3")
        tableView.register(SelectPackageTableViewCell.self, forCellReuseIdentifier: SelectPackageTableViewCell.cellId)
        tableView.register(CatatanKhususTableViewCell.self, forCellReuseIdentifier: CatatanKhususTableViewCell.cellId)
        tableView.register(ExpandableHeaderView.self, forHeaderFooterViewReuseIdentifier: ExpandableHeaderView.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsMultipleSelection = true
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 20
        tableView.isScrollEnabled = true
        return tableView
    }()
    
    private lazy var btmBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Lanjut", showText: .notShow)
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
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grey2")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "grey3")
        navigationItem.titleView = setTitle(title: "Katze Nesia Cat Hotel", subtitle: "Bekasi, Jawa Barat")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        filteredData = names
        
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
        let vc = DateSelectionViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

//MARK: Navigation Title
@available(iOS 16.0, *)
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
@available(iOS 16.0, *)
extension SelectBookingDetailsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = searchText.isEmpty ? names : names.filter({ ExpandableNames in
            return ExpandableNames.namesIs.range(of: searchText, options: .caseInsensitive) != nil
        })
        self.packageTableView.reloadData()
    }
}

@available(iOS 16.0, *)
extension SelectBookingDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ExpandableHeaderView.identifier) as! ExpandableHeaderView
        
        //MARK: - Add Pet Data Here
        headerView.configure(iconPackage: "birman", namePet: filteredData[section].namesIs, sizePet: "Kucing Sedang", racePet: " - Domestic")
        
        headerView.switchBtn.addTarget(self, action: #selector(didChangeSwitch), for: .valueChanged)
        headerView.switchBtn.tag = section
        
        return headerView
    }
    
    @objc func didChangeSwitch(button: UISwitch) {
        let section = button.tag
        var indexPaths = [IndexPath]()
        filteredData[section].isExpanded = !filteredData[section].isExpanded
        
        for row in 0...1 {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let cell = packageTableView.headerView(forSection: section)
        if filteredData[section].isExpanded {
            packageTableView.insertRows(at: indexPaths, with: .fade)
            cell?.contentView.layer.shadowColor = UIColor(named: "white")?.cgColor
            cell?.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            cell?.contentView.addSubview(separator)
            NSLayoutConstraint.activate([
                separator.bottomAnchor.constraint(equalTo: (cell?.contentView.bottomAnchor)!),
                separator.heightAnchor.constraint(equalToConstant: 1),
                separator.widthAnchor.constraint(equalToConstant: 300),
                separator.centerXAnchor.constraint(equalTo: (cell?.contentView.centerXAnchor)!),
            ])
        } else if !names[section].isExpanded {
            packageTableView.deleteRows(at: indexPaths, with: .fade)
            cell?.contentView.layer.shadowColor = UIColor(named: "grey1")?.cgColor
            cell?.contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
            separator.removeFromSuperview()
        }    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredData[section].isExpanded {
            return 0
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = HotelPackageViewController()
            vc.modalPresentationStyle = .pageSheet
            self.present(vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = CatatanViewController()
            vc.modalPresentationStyle = .pageSheet
            vc.passingCellContent = { [weak self] text in
                DispatchQueue.main.async {
                    let path = IndexPath(row: 1, section: indexPath.section)
                    let cell = self!.packageTableView.cellForRow(at: path) as! CatatanKhususTableViewCell
                    cell.configure(textDetails: text)
                }
            }
            self.present(vc, animated: true)
        }
    }
}
