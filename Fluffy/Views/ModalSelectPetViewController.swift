//
//  ModalSelectPetViewController.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 17/10/22.
//

import UIKit

class ModalSelectPetViewController: UIViewController {
    
    var isChecked = false
    var isCheck = false
    let checkedImage = UIImage(systemName: "checkmark.square.fill")
    let uncheckedImage = UIImage(systemName: "square")
    var selectedCellPath: IndexPath?
    
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
        let modalTableView = UITableView(frame: CGRect(), style: .plain)
        modalTableView.delegate = self
        modalTableView.dataSource = self
        modalTableView.backgroundColor = UIColor(named: "white")
        modalTableView.register(ModalMonitoringTableViewCell.self, forCellReuseIdentifier: ModalMonitoringTableViewCell.cellId)
        modalTableView.translatesAutoresizingMaskIntoConstraints = false
        modalTableView.allowsMultipleSelection = true
        modalTableView.separatorStyle = .none
        modalTableView.showsVerticalScrollIndicator = false
        modalTableView.sectionHeaderTopPadding = 20
        modalTableView.isScrollEnabled = true
        return modalTableView
    }()
    
    private lazy var customBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Pilih", showText: .show)
        customBar.barBtn.addTarget(self, action: #selector(petSelected), for: .touchUpInside)
        customBar.boxBtn.addTarget(self, action: #selector(isClicked), for: .touchUpInside)
        return customBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "white")
        
        view.addSubview(indicator)
        view.addSubview(headline)
        view.addSubview(modalTableView)
        view.addSubview(customBar)
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 4)
        ])

        NSLayoutConstraint.activate([
            headline.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            headline.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            headline.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -222),
        ])
        
        NSLayoutConstraint.activate([
            customBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            customBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            modalTableView.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 0),
            modalTableView.widthAnchor.constraint(equalToConstant: 342),
            modalTableView.bottomAnchor.constraint(equalTo: customBar.topAnchor, constant: -20),
            modalTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
        ])
        
    }
    
    @objc func petSelected() {
        dismiss(animated: true)
    }
    
    @objc func isClicked() {
        isChecked = !isChecked
        for section in 0...5 {
            for index in 0...4 {
                let indexPath = IndexPath(row: index, section: section)
                if isChecked {
                    customBar.boxBtn.setImage(checkedImage, for: .normal)
                    if let cell = modalTableView.cellForRow(at: indexPath) as? ModalMonitoringTableViewCell {
                        cell.configure(namePet: "Budiman", petImage: "pawprint.fill", imageCheckmark: true)
                    }
                } else {
                    customBar.boxBtn.setImage(uncheckedImage, for: .normal)
                    if let cell = modalTableView.cellForRow(at: indexPath) as? ModalMonitoringTableViewCell {
                        cell.configure(namePet: "Budiman", petImage: "pawprint.fill", imageCheckmark: false)
                    }
                }
            }
        }
    }

}

extension ModalSelectPetViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = UILabel()
        title.font = UIFont(name: "Poppins-Bold", size: 16)
        title.text = self.tableView(tableView, titleForHeaderInSection: section)
        title.textColor = UIColor(named: "black")
        title.backgroundColor = UIColor(named: "white")
        return title
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionName: String
        switch section {
        case 0:
            sectionName = NSLocalizedString("Anjing Kecil (S)", comment: "Anjing Kecil (S)")
        case 1:
            sectionName = NSLocalizedString("Anjing Sedang (M)", comment: "Anjing Sedang (M)")
        case 2:
            sectionName = NSLocalizedString("Anjing Besar (L)", comment: "Anjing Besar (L)")
        case 3:
            sectionName = NSLocalizedString("Kucing Kecil (S)", comment: "Kucing Kecil (S)")
        case 4:
            sectionName = NSLocalizedString("Kucing Sedang (M)", comment: "Kucing Sedang (M)")
        case 5:
            sectionName = NSLocalizedString("Kucing Besar (L)", comment: "Kucing Besar (L)")
        default:
            sectionName = NSLocalizedString("Anjing Kecil (S)", comment: "Anjing Kecil (S)")
        }
        return sectionName
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ModalMonitoringTableViewCell.cellId, for: indexPath) as! ModalMonitoringTableViewCell
        cell.contentView.backgroundColor = UIColor(named: "grey3")
        cell.configure(namePet: "Budiman", petImage: "pawprint.fill", imageCheckmark: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = modalTableView.cellForRow(at: indexPath) as! ModalMonitoringTableViewCell
        cell.configure(namePet: "Budiman", petImage: "pawprint.fill", imageCheckmark: true)
        
        
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = modalTableView.cellForRow(at: indexPath) as! ModalMonitoringTableViewCell
        cell.configure(namePet: "Budiman", petImage: "pawprint.fill", imageCheckmark: false)

    }
    
}
