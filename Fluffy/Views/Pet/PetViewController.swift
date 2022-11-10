//
//  PetViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 17/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class PetViewController: UIViewController {
    
    //MARK: - VIEW CONTROLLER OBJECT
    private let petViewModel = PetViewModel()
    private let petList = BehaviorRelay<[Pets]>(value: [])
    
    private lazy var modalTableView: UITableView = {
        let modalTableView = UITableView(frame: CGRect(), style: .plain)
        modalTableView.delegate = self
    
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
    
    private func setupUI() {
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
        appearance.backgroundColor = UIColor(named: "white")
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
    
    override func viewWillAppear(_ animated: Bool) {
        petViewModel.getAllPet()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        petViewModel.petModelArrayObserver.subscribe(onNext: { (value) in
            self.petList.accept(value)
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        modalTableView.rx.itemSelected.subscribe(onNext: { (indexPath) in
            self.modalTableView.deselectRow(at: indexPath, animated: true)
            let editPetDetailController = EditPetViewController()
            editPetDetailController.petObject.accept(self.petList.value[indexPath.row])
            editPetDetailController.petObjectObserver.subscribe(onNext: { _ in
                self.modalTableView.reloadData()
            }).disposed(by: bags)
            editPetDetailController.modalPresentationStyle = .fullScreen
            self.present(editPetDetailController, animated: true)
        }).disposed(by: bags)
        
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        petList.bind(to: modalTableView.rx.items(cellIdentifier: "PetTableViewCell", cellType: PetTableViewCell.self)) { row, model, cell in
            cell.contentView.backgroundColor = UIColor(named: "white")
            cell.configure(model)
        }.disposed(by: bags)
    }
    
    @objc func toAddPet() {
        let vc = AddPetViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.present(vc, animated: true)
    }
}

//MARK: - PET TABLE VIEW DELEGATE
extension PetViewController: UITableViewDelegate {

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
}
