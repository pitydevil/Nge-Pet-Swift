//
//  PetSizeViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 25/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class PetSizeViewController: UIViewController {

    //MARK: - OBSERVER OBJECT DECLARATION
    var supportedPetModelArray   = BehaviorRelay<[SupportedPetTypeDetail]>(value: [])
    
    //MARK: - OBSERVER OBJECT DECLARATION
    private var supportedPetModelArrayObservable : Observable<[SupportedPetTypeDetail]> {
        return supportedPetModelArray.asObservable()
    }
    
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
        let headline = ReuseableLabel(labelText: "Ukuran Hewan", labelType: .titleH1, labelColor: .black)
        return headline
    }()
    
    private lazy var petSizeTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(PetSizeExplainationTableViewCell.self, forCellReuseIdentifier: PetSizeExplainationTableViewCell.cellId)
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "white")
        tableView.estimatedRowHeight = 128
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "white")
        view.addSubview(headline)
        view.addSubview(petSizeTableView)
        view.addSubview(customBar)
        
        headline.topAnchor.constraint(equalTo: view.topAnchor, constant: 48).isActive = true
        headline.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        headline.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        
        customBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        customBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        customBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        petSizeTableView.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 40).isActive = true
        petSizeTableView.bottomAnchor.constraint(equalTo: customBar.topAnchor).isActive = true
        petSizeTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        petSizeTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
    }
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
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
        supportedPetModelArray.bind(to: petSizeTableView.rx.items(cellIdentifier:  PetSizeExplainationTableViewCell.cellId, cellType: PetSizeExplainationTableViewCell.self)) { row, model, cell in
            cell.configureView(model)
            cell.backgroundColor = .clear
        }.disposed(by: bags)
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension PetSizeViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
}
