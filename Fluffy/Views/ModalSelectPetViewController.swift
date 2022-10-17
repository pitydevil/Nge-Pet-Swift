//
//  ModalSelectPetViewController.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 17/10/22.
//

import UIKit

class ModalSelectPetViewController: UIViewController {
    
    private lazy var indicator: UIImageView = {
        let indicator = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
        indicator.image = UIImage(systemName: "minus", withConfiguration: config)
        indicator.tintColor = UIColor(named: "grey2")
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var headline: ReuseableLabel = {
        let headline = ReuseableLabel(labelText: "Pilih Hewan", labelType: .titleH1, labelColor: .black)
        return headline
    }()
    
    private lazy var modalTableView: UITableView = {
        let modalTableView = UITableView()
        modalTableView.delegate = self
        modalTableView.dataSource = self
        modalTableView.backgroundColor = UIColor(named: "white")
        modalTableView.register(ModalMonitoringTableViewCell.self, forCellReuseIdentifier: ModalMonitoringTableViewCell.cellId)
        modalTableView.translatesAutoresizingMaskIntoConstraints = false
        modalTableView.separatorStyle = .none
        return modalTableView
    }()
    
    private lazy var customBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Pilih", showText: .show, isChecked: false)
        return customBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "white")
        
        view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        view.addSubview(headline)
        NSLayoutConstraint.activate([
            headline.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            headline.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
        ])
        
        view.addSubview(modalTableView)
        NSLayoutConstraint.activate([
            modalTableView.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 0),
            modalTableView.widthAnchor.constraint(equalToConstant: 342),
            modalTableView.heightAnchor.constraint(equalToConstant: view.bounds.height),
            modalTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
        ])
        
        view.addSubview(customBar)
        NSLayoutConstraint.activate([
            customBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            customBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        customBar.barBtn.addTarget(self, action: #selector(petSelected), for: .touchUpInside)
    }
    
    @objc func petSelected() {
        dismiss(animated: true)
    }

}

extension ModalSelectPetViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        var label = ReuseableLabel(labelText: "Sedang Dititipkan", labelType: .titleH2, labelColor: .black)
        if section == 0 {
            label = ReuseableLabel(labelText: "Sedang Dititipkan", labelType: .titleH2, labelColor: .black)
        } else {
            label = ReuseableLabel(labelText: "Belum Dititipkan", labelType: .titleH2, labelColor: .black)
        }
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ModalMonitoringTableViewCell.cellId, for: indexPath)
        if indexPath.section == 0 {
            cell.contentView.backgroundColor = UIColor(named: "grey3")
        } else {
            cell.contentView.backgroundColor = UIColor(named: "grey1")?.withAlphaComponent(0.5)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = modalTableView.cellForRow(at: indexPath) as! ModalMonitoringTableViewCell
        if indexPath.section == 0 {
            cell.isUserInteractionEnabled = true
            if cell.isChecked == false {
                cell.isChecked = true
                cell.checkedImage.image = UIImage(systemName: "checkmark")
            } else {
                cell.isChecked = false
                cell.checkedImage.image = UIImage()
            }
        } else {
            cell.isUserInteractionEnabled = false
            
        }
    }
    
}
