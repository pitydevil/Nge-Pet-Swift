//
//  CatatanViewController.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 02/11/22.
//

import UIKit

class CatatanViewController: UIViewController {
    
    var cellContent = 1
    
    private lazy var indicator: UIImageView = {
        let indicator = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
        indicator.image = UIImage(systemName: "minus", withConfiguration: config)
        indicator.tintColor = UIColor(named: "grey2")
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var headline: ReuseableLabel = {
        let headline = ReuseableLabel(labelText: "Catatan Khusus", labelType: .titleH1, labelColor: .black)
        return headline
    }()
    
    private lazy var modalTableView: UITableView = {
        let modalTableView = UITableView(frame: CGRect(), style: .plain)
        modalTableView.delegate = self
        modalTableView.dataSource = self
        modalTableView.backgroundColor = UIColor(named: "white")
        modalTableView.register(CatatanTableViewCell.self, forCellReuseIdentifier: CatatanTableViewCell.identifier)
        modalTableView.translatesAutoresizingMaskIntoConstraints = false
        modalTableView.allowsMultipleSelection = false
        modalTableView.separatorStyle = .none
        modalTableView.showsVerticalScrollIndicator = false
        modalTableView.sectionHeaderTopPadding = 0
        modalTableView.isScrollEnabled = true
        return modalTableView
    }()
    
    private lazy var customBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Simpan", showText: .notShow)
        customBar.barBtn.addTarget(self, action: #selector(catatanKhusus), for: .touchUpInside)
        return customBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "white")
        
        //MARK: - Add Subview
        view.addSubview(indicator)
        view.addSubview(headline)
        view.addSubview(modalTableView)
        view.addSubview(customBar)
        
        //MARK: - Setup Const
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),

            headline.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            headline.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            headline.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -164),
            
            modalTableView.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 0),
            modalTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            modalTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            modalTableView.bottomAnchor.constraint(equalTo: customBar.topAnchor, constant: 20),
            
            customBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func catatanKhusus() {
        dismiss(animated: true)
    }
    
}

extension CatatanViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 38
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        let btn = ReusableButton(titleBtn: "Tambah", styleBtn: .longOutline)
        footerView.addSubview(btn)
        btn.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        btn.leadingAnchor.constraint(equalTo: footerView.leadingAnchor).isActive = true
        btn.trailingAnchor.constraint(equalTo: footerView.trailingAnchor).isActive = true
        btn.addTarget(self, action: #selector(tambahCatatan), for: .touchUpInside)
        btn.isEnabled = true
        return footerView
    }
    
    @objc func tambahCatatan(_ sender: UIButton) {
        let indexPath = IndexPath(row: cellContent, section: 0)
        cellContent += 1
        modalTableView.insertRows(at: [indexPath], with: .bottom)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CatatanTableViewCell.identifier, for: indexPath) as! CatatanTableViewCell
        cell.contentView.backgroundColor = UIColor(named: "white")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = modalTableView.cellForRow(at: indexPath) as! CatatanTableViewCell
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = modalTableView.cellForRow(at: indexPath) as! CatatanTableViewCell
        
    }
}
