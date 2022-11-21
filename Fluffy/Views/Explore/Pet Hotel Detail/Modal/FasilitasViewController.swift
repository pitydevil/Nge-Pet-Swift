//
//  FasilitasViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 25/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class FasilitasViewController: UIViewController {
    
    //MARK: - OBJECT DECLARATION
    var fasilitasModelArray   = BehaviorRelay<[Fasilitas]>(value: [])
    
    //MARK: Subviews
    private lazy var customBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Tutup", showText: .notShow)
        customBar.barBtn.isEnabled = true
        customBar.barBtn.configuration?.baseBackgroundColor = UIColor(named: "primaryMain")
        customBar.barBtn.configuration?.baseForegroundColor = UIColor(named: "white")
        return customBar
    }()
    
    private lazy var sesuaiPaket:ReuseableLabel = ReuseableLabel(labelText: "*) Sesuai Paket", labelType: .bodyP2, labelColor: .grey1)
    
    private lazy var headline: ReuseableLabel = {
        let headline = ReuseableLabel(labelText: "Fasilitas yang Ditawarkan", labelType: .titleH1, labelColor: .black)
        return headline
    }()
    
    private lazy var facilityTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(FasilitasTableViewCell.self, forCellReuseIdentifier: FasilitasTableViewCell.cellId)
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "white")
        return tableView
    }()
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "white")
        view.addSubview(headline)
        view.addSubview(facilityTableView)
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
        
        facilityTableView.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 40).isActive = true
        facilityTableView.bottomAnchor.constraint(equalTo: customBar.topAnchor).isActive = true
        facilityTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        facilityTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
    }
    
    //MARK: viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        customBar.barBtn.rx.tap.bind { [self] in
            dismiss(animated: true)
        }.disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        fasilitasModelArray.bind(to: facilityTableView.rx.items(cellIdentifier:  FasilitasTableViewCell.cellId, cellType: FasilitasTableViewCell.self)) { row, model, cell in
            cell.configure(model)
            cell.backgroundColor = .clear
        }.disposed(by: bags)
    }
}
