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
    
    //MARK: OBJECT DECLARATION
    private let petViewModel = PetViewModel()
    private let petList = BehaviorRelay<[Pets]>(value: [])
   
    private lazy var modalTableView: UITableView = {
        let modalTableView = UITableView(frame: CGRect(), style: .plain)
        modalTableView.backgroundColor = UIColor(named: "grey3")
        modalTableView.register(PetTableViewCell.self, forCellReuseIdentifier: PetTableViewCell.cellId)
        modalTableView.translatesAutoresizingMaskIntoConstraints = false
        modalTableView.allowsMultipleSelection = true
        modalTableView.isScrollEnabled         = true
        modalTableView.delegate                = self
        modalTableView.separatorStyle          = .none
        modalTableView.showsVerticalScrollIndicator = false
        modalTableView.sectionHeaderTopPadding = 20

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
        navigationController?.navigationItem.titleView = ReuseableLabel(labelText: "Hewan Peliharaanku", labelType: .titleH2, labelColor: .black)
        
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
            modalTableView.widthAnchor.constraint(equalToConstant: view.frame.width - 48),
            modalTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            modalTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        petViewModel.getAllPet()
    }

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
        petViewModel.petModelArrayObserver.subscribe(onNext: { [self] (value) in
            petViewModel.checkPetStateController(value)
            petList.accept(value)
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        petViewModel.monitoringEnumCaseObserver.subscribe(onNext: { [self] (value) in
            switch value {
            case .empty:
                print("empty")
            case .terisi:
                print("terisi")
            }
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        
        //MARK: - RESPONSE TABLE VIEW DIDSELECT DELEGATE FUNCTION
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        modalTableView.rx.itemSelected.subscribe(onNext: { [self] (indexPath) in
            self.modalTableView.deselectRow(at: indexPath, animated: true)
            let editPetDetailController = EditPetViewController()
            editPetDetailController.petObject.accept(petList.value[indexPath.row])
            editPetDetailController.petObjectObserver.subscribe(onNext: { [self] _ in
                modalTableView.reloadData()
            }).disposed(by: bags)
            editPetDetailController.modalPresentationStyle = .fullScreen
            present(editPetDetailController, animated: true)
        }).disposed(by: bags)
        
        //MARK: - BINDING PET LIST WITH TABLE VIEW
        /// - Parameters:
        ///     - modalTableView : UITableView
        ///     - petTableViewCell : UiTableViewCell
        petList.bind(to: modalTableView.rx.items(cellIdentifier: "PetTableViewCell", cellType: PetTableViewCell.self)) { row, model, cell in
            cell.contentView.backgroundColor = UIColor(named: "white")
            cell.configure(model)
        }.disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        petViewModel.removeErrorCaseObserver.skip(1).subscribe(onNext: { (value) in
            DispatchQueue.main.async { [self] in
                switch value {
                    case let .sukses(errorTitle, errorMessage):
                        present(genericAlert(titleAlert: errorTitle, messageAlert: errorMessage, buttonText: "OK"), animated: true)
                        petViewModel.getAllPet()
                    case let .gagalBuangPet(errorTitle, errorMessage):
                        present(genericAlert(titleAlert: errorTitle, messageAlert: errorMessage, buttonText: "OK"), animated: true)
                }
            }
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
    }
    
    @objc func toAddPet() {
        let vc = AddPetViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.present(vc, animated: true)
    }
}

//MARK: - PET TABLE VIEW DELEGATE
extension PetViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
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

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, nil) in
            let refreshAlert = UIAlertController(title: "Hapus Hewan Peliharaan", message: "Apakah anda yakin ingin menghapus hewan peliharaan ini?", preferredStyle: .alert)

            refreshAlert.addAction(UIAlertAction(title: "Hapus", style: .destructive, handler: { [self] (action: UIAlertAction!) in
                petViewModel.uuidModelObject.accept(petList.value[indexPath.row].petID!)
                petViewModel.deletePet()
            }))
            refreshAlert.addAction(UIAlertAction(title: "Batal", style: .default, handler: { (action: UIAlertAction!) in
                refreshAlert .dismiss(animated: true, completion: nil)
            }))
            self.present(refreshAlert, animated: true, completion: nil)
        }
        delete.backgroundColor = UIColor.systemRed
        delete.image = UIImage(systemName: "trash.circle.fill")
        let config = UISwipeActionsConfiguration(actions: [delete])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}
