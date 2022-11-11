//
//  ModalMonitoringPetViewController.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 12/10/22.
//

import UIKit

class ModalMonitoringViewController: UIViewController {
    
    var isChecked = true
    let checkedImage = UIImage(systemName: "checkmark.square.fill")
    let uncheckedImage = UIImage(systemName: "square")
    
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
        return modalTableView
    }()
    
    private lazy var customBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Pilih", showText: .show)
        customBar.barBtn.addTarget(self, action: #selector(petSelected), for: .touchUpInside)
        customBar.boxBtn.addTarget(self, action: #selector(isClicked), for: .touchUpInside)
        customBar.boxBtn.setImage(checkedImage, for: .normal)
        return customBar
    }()
    
    private func setupUI() {
        
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
            modalTableView.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 20),
            modalTableView.widthAnchor.constraint(equalToConstant: 342),
            modalTableView.bottomAnchor.constraint(equalTo: customBar.topAnchor, constant: -20),
            modalTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc func petSelected() {
      //  completion?("\(modalTableView.indexPathsForSelectedRows?.count ?? 0) Hewan")
        dismiss(animated: true)
    }
    
    @objc func isClicked() {
        isChecked = !isChecked
        
        for index in 0...3 {
            let indexPath = IndexPath(row: index, section: 0)
            if isChecked {
                customBar.boxBtn.setImage(checkedImage, for: .normal)
                if let cell = modalTableView.cellForRow(at: indexPath) as? ModalMonitoringTableViewCell {
                    cell.configure(namePet: "Budiman", petImage: "pawprint.fill", imageCheckmark: true)
                    modalTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    customBar.hewanDipilih.text = "Semua hewan dipilih"
                }
            } else {
                customBar.boxBtn.setImage(uncheckedImage, for: .normal)
                if let cell = modalTableView.cellForRow(at: indexPath) as? ModalMonitoringTableViewCell {
                    cell.configure(namePet: "Budiman", petImage: "pawprint.fill", imageCheckmark: false)
                    customBar.hewanDipilih.text = "Tidak ada hewan dipilih"
                    modalTableView.deselectRow(at: indexPath, animated: true)
                }
            }
        }
    }
}

extension ModalMonitoringViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ModalMonitoringTableViewCell.cellId, for: indexPath) as! ModalMonitoringTableViewCell
        cell.contentView.backgroundColor = UIColor(named: "grey3")
        cell.configure(namePet: "Budiman", petImage: "pawprint.fill", imageCheckmark: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        modalTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = modalTableView.cellForRow(at: indexPath) as! ModalMonitoringTableViewCell
        cell.configure(namePet: "Budiman", petImage: "pawprint.fill", imageCheckmark: true)
        customBar.hewanDipilih.text = "\(modalTableView.indexPathsForSelectedRows?.count ?? 0) hewan dipilih"
        if modalTableView.indexPathsForSelectedRows?.count == 3 {
            customBar.boxBtn.setImage(checkedImage, for: .normal)
            isChecked = true
            customBar.hewanDipilih.text = "Semua hewan dipilih"
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = modalTableView.cellForRow(at: indexPath) as! ModalMonitoringTableViewCell
        cell.configure(namePet: "Budiman", petImage: "pawprint.fill", imageCheckmark: false)
        customBar.hewanDipilih.text = "\(modalTableView.indexPathsForSelectedRows?.count ?? 0) hewan dipilih"
        customBar.boxBtn.setImage(uncheckedImage, for: .normal)
        isChecked = false
        if modalTableView.indexPathsForSelectedRows?.count == nil {
            customBar.hewanDipilih.text = "Tidak ada hewan dipilih"
        }
    }
    
}
