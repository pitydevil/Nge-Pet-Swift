//
//  PetViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 17/10/22.
//

import UIKit

class PetViewController: UIViewController {
    
    private lazy var modalTableView: UITableView = {
        let modalTableView = UITableView(frame: CGRect(), style: .plain)
        modalTableView.delegate = self
        modalTableView.dataSource = self
        modalTableView.backgroundColor = UIColor(named: "grey3")
        modalTableView.register(PetTableViewCell.self, forCellReuseIdentifier: PetTableViewCell.cellId)
        modalTableView.translatesAutoresizingMaskIntoConstraints = false
        modalTableView.allowsMultipleSelection = true
        modalTableView.separatorStyle = .none
        modalTableView.showsVerticalScrollIndicator = false
        modalTableView.sectionHeaderTopPadding = 20
        modalTableView.isScrollEnabled = true
        return modalTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "grey3")
        
        //MARK: - Setup Navigation Controller
        navigationController?.navigationBar.tintColor = UIColor(named: "primaryMain")
        navigationController?.navigationBar.topItem?.titleView = ReuseableLabel(labelText: "Hewan Peliharaanku", labelType: .titleH2, labelColor: .black)
        var config = UIImage.SymbolConfiguration(hierarchicalColor: UIColor(named: "primaryMain") ?? .systemPink)
        config = config.applying(UIImage.SymbolConfiguration(weight: .bold))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus", withConfiguration: config), style: .done, target: self, action: #selector(toAddPet))
        self.navigationController?.navigationItem.titleView = ReuseableLabel(labelText: "Hewan Peliharaanku", labelType: .titleH2, labelColor: .black)
        
        //MARK: - Setup Navigation Color
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "grey3")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.backButtonDisplayMode = .minimal
        
        //MARK: - Setup View
        view.addSubview(modalTableView)
        NSLayoutConstraint.activate([
            modalTableView.topAnchor.constraint(equalTo: view.topAnchor),
            modalTableView.widthAnchor.constraint(equalToConstant: 342),
            modalTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            modalTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
        ])
        
    }
    
    @objc func toAddPet() {
        let vc = AddPetViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension PetViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PetTableViewCell.cellId, for: indexPath) as! PetTableViewCell
        cell.contentView.backgroundColor = UIColor(named: "white")
        cell.configure(petImage: "poodle", racePet: "Poodle", namePet: "Bombom", sexPet: "female", typePet: "Anjing Besar", agePet: "2 Tahun")
        return cell
    }
    

}
