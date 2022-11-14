//
//  RulesViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 25/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class RulesViewController: UIViewController {

    //MARK: - OBJECT DECLARATION
    var sopGeneralModelArray   = BehaviorRelay<[SopGeneral]>(value: [])
    
    //MARK: Subviews
    private lazy var customBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Tutup", showText: .notShow)
        customBar.barBtn.isEnabled = true
        customBar.barBtn.configuration?.baseBackgroundColor = UIColor(named: "grey2")
        customBar.barBtn.configuration?.baseForegroundColor = UIColor(named: "white")
        return customBar
    }()
    
    private lazy var sesuaiPaket:ReuseableLabel = ReuseableLabel(labelText: "*) Sesuai Paket", labelType: .bodyP2, labelColor: .grey1)
    
    private lazy var headline: ReuseableLabel = {
        let headline = ReuseableLabel(labelText: "Peraturan dan Kebijakan", labelType: .titleH1, labelColor: .black)
        return headline
    }()
    
    private lazy var rulesTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(PetHotelDetailTableViewCell.self, forCellReuseIdentifier: PetHotelDetailTableViewCell.cellId)
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
        view.addSubview(rulesTableView)
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
        
        rulesTableView.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 40).isActive = true
        rulesTableView.bottomAnchor.constraint(equalTo: customBar.topAnchor).isActive = true
        rulesTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        rulesTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
    }
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        sopGeneralModelArray.bind(to: rulesTableView.rx.items(cellIdentifier:  PetHotelDetailTableViewCell.cellId, cellType: PetHotelDetailTableViewCell.self)) { row, model, cell in
            cell.configureView(tabelType: "rules", description: model.sopGeneralsDescription)
            cell.backgroundColor = .clear
        }.disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        customBar.barBtn.rx.tap.bind { [self] in
            dismiss(animated: true)
        }.disposed(by: bags)
    }
}
