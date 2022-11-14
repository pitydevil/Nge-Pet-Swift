//
//  ModalSelectPetViewController.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 17/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class ModalSelectPetViewController: UIViewController {
    
    //MARK: OBJECT DECLARATION
    private let modalMonitoringViewModel = ModalSelectPetMonitoringViewModel()
    private var monitoringEnumCaseModel  = BehaviorRelay<monitoringCase>(value: .empty)
    var petSelectionModelArray           = BehaviorRelay<[PetsSelection]>(value: [])
    var petSelectedModelArray            = BehaviorRelay<[PetsSelection]>(value: [])
    var petBodyModelArray            = BehaviorRelay<[PetBody]>(value: [])
    var monitoringStateSelectionEnumModel  = BehaviorRelay<stateSelectectionCase>(value: .kosong)
    
    //MARK: OBJECT OBSERVER DECLARATION
    var petsSelectedModelArrayObserver : Observable<[PetsSelection]> {
        return petSelectedModelArray.asObservable()
    }
    
    var petsSelectionModelArrayObserver : Observable<[PetsSelection]> {
        return petSelectionModelArray.asObservable()
    }
    
    private var monitoringEnumCaseObserver : Observable<monitoringCase> {
        return monitoringEnumCaseModel.asObservable()
    }
    
    var petsBodhyModelArrayObserver : Observable<[PetBody]> {
       return petBodyModelArray.asObservable()
    }
    
    //MARK: - SUBVIEWS
    private lazy var indicator: UIImageView = {
        let indicator = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
        indicator.image = UIImage(systemName: "minus", withConfiguration: config)
        indicator.tintColor = UIColor(named: "grey2")
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var emptyHeadline: ReuseableLabel = {
        let emptyHeadline = ReuseableLabel(labelText: "Yah, Daftar Hewannmu Kosong!", labelType: .titleH1, labelColor: .black)
        emptyHeadline.textAlignment = .center
        return emptyHeadline
    }()
    
    private lazy var emptyImage: UIImageView = {
        let emptyImage = UIImageView()
        emptyImage.image = UIImage(named: "emptyPet")
        emptyImage.contentMode = .scaleAspectFit
        emptyImage.translatesAutoresizingMaskIntoConstraints = false
        return emptyImage
    }()
    
    private lazy var emptyCaption: ReuseableLabel = {
        let emptyCaption = ReuseableLabel(labelText: "Yuk, Tambah Hewan dan Permudah Pencarian Hotelmu!", labelType: .bodyP1, labelColor: .grey1)
        emptyCaption.textAlignment = .center
        emptyCaption.spacing = 5
        return emptyCaption
    }()
    
    private lazy var addPetBtn: ReusableButton = {
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let addPetBtn = ReusableButton(titleBtn: "Tambah Hewan", styleBtn: .normal, icon: UIImage(systemName: "plus", withConfiguration: config))
        return addPetBtn
    }()
    
    private lazy var headline: ReuseableLabel = {
        let headline = ReuseableLabel(labelText: "Pilih Hewan", labelType: .titleH1, labelColor: .black)
        return headline
    }()
    
    private lazy var modalTableView: UITableView = {
        let modalTableView = UITableView(frame: CGRect(), style: .plain)
        modalTableView.backgroundColor = UIColor(named: "white")
        modalTableView.delegate = self
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
        customBar.barBtn.isEnabled = false
        customBar.boxBtn.setImage(UIImage(systemName: "square"), for: .normal)
        return customBar
    }()
    
    //MARK: - Setup Layout
    private func emptyPet(){
        //MARK: - Add Subview Empty Pet
        view.addSubview(indicator)
        view.addSubview(emptyHeadline)
        view.addSubview(emptyImage)
        view.addSubview(emptyCaption)
        view.addSubview(addPetBtn)
        
        //MARK: - Setup Layout Empty Pet
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
            
            emptyHeadline.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyHeadline.topAnchor.constraint(equalTo: view.topAnchor, constant: 123),
            emptyHeadline.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emptyHeadline.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            emptyImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyImage.topAnchor.constraint(equalTo: emptyHeadline.bottomAnchor, constant: 8),
            emptyImage.heightAnchor.constraint(equalToConstant: 270),
            emptyImage.widthAnchor.constraint(equalToConstant: 270),
            
            emptyCaption.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyCaption.topAnchor.constraint(equalTo: emptyImage.bottomAnchor, constant: 8),
            emptyCaption.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emptyCaption.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            addPetBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addPetBtn.topAnchor.constraint(equalTo: emptyCaption.bottomAnchor, constant: 20),
        ])
    }
    
    private func petExist() {
        //MARK: - Add Subview Pet
        view.addSubview(indicator)
        view.addSubview(headline)
        view.addSubview(modalTableView)
        view.addSubview(customBar)
        
        //MARK: - Setup Layout Pet
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
            
            headline.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            headline.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            headline.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -222),
            
            customBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            modalTableView.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 20),
            modalTableView.widthAnchor.constraint(equalToConstant: 342),
            modalTableView.bottomAnchor.constraint(equalTo: customBar.topAnchor, constant: -20),
            modalTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
        ])
    }
    
    //MARK: - VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        modalMonitoringViewModel.petSelectionModelArray.accept(petSelectionModelArray.value)
        modalMonitoringViewModel.checkMonitoringModalState()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "white")
                        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        modalMonitoringViewModel.monitoringEnumCaseObserver.subscribe(onNext: { [self] (value) in
            switch value {
            case .terisi:
                petExist()
            case .empty:
                emptyPet()
            }
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        modalMonitoringViewModel.petFirstSelectionArrayObserver.skip(1).subscribe(onNext: { [self] (value) in
            petSelectionModelArray.accept(value)
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        modalMonitoringViewModel.petSelectedArrayObserver.subscribe(onNext: { [self] (value) in
            petSelectedModelArray.accept(value)
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        petsSelectedModelArrayObserver.skip(1).subscribe(onNext: { (value) in
            DispatchQueue.main.async { [self] in
                customBar.barBtn.isEnabled = value.count != 0 ? true : false
            }
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        petSelectionModelArray.bind(to: modalTableView.rx.items(cellIdentifier: ModalMonitoringTableViewCell.cellId, cellType: ModalMonitoringTableViewCell.self)) { [self] row, model, cell in
            modalMonitoringViewModel.petSelectionModelArray.accept(petSelectionModelArray.value)
            modalMonitoringViewModel.petSelectedModelArray.accept(petSelectedModelArray.value)
            modalMonitoringViewModel.checkStateSelection()
            cell.contentView.backgroundColor = UIColor(named: "grey3")
            cell.configure(model)
        }.disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        modalTableView.rx.itemSelected.subscribe(onNext: { [self] (indexPath) in
            modalMonitoringViewModel.selectedIndexPetModel.accept(indexPath.row)
            modalMonitoringViewModel.petSelectionModelArray.accept(petSelectionModelArray.value)
            modalMonitoringViewModel.petSelectedModelArray.accept(petSelectedModelArray.value)
            modalMonitoringViewModel.didSelectResponse()
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        modalMonitoringViewModel.monitoringStateEnumCaseObserver.skip(1).subscribe(onNext: { [self] (value) in
            monitoringStateSelectionEnumModel.accept(value)
            switch value {
            case .full:
                customBar.boxBtn.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
                customBar.hewanDipilih.text = "Semua hewan dipilih"
            case .kosong:
                customBar.boxBtn.setImage(UIImage(systemName: "square"), for: .normal)
                customBar.hewanDipilih.text = "Tidak ada hewan dipilih"
            case .parsial(let jumlah):
                customBar.boxBtn.setImage(UIImage(systemName: "square"), for: .normal)
                customBar.hewanDipilih.text = "\(jumlah) hewan dipilih"
            }
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        customBar.boxBtn.rx.tap.bind { [self] in
            modalMonitoringViewModel.petSelectionModelArray.accept(petSelectionModelArray.value)
            modalMonitoringViewModel.monitoringStateSelectionEnumModel.accept(monitoringStateSelectionEnumModel.value)
            modalMonitoringViewModel.selectAndDeselectAllPet()
        }.disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        customBar.barBtn.rx.tap.bind { [self] in
            let pets = petSelectedModelArray.value.map { obj -> PetBody in
                return PetBody(petName: obj.petName!, petType: obj.petType!, petSize: obj.petSize!)
            }
            petBodyModelArray.accept(pets)
            dismiss(animated: true)
        }.disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        addPetBtn.rx.tap.bind { [self] in
            let vc = AddPetViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }.disposed(by: bags)
    }
    
//    isChecked = !isChecked
//    for index in 0...totalCell {
//        let indexPath = IndexPath(row: index, section: 0)
//        if isChecked {
//            customBar.boxBtn.setImage(checkedImage, for: .normal)
//            if let cell = modalTableView.cellForRow(at: indexPath) as? ModalMonitoringTableViewCell {
//               // cell.configure(namePet: "Budiman", petImage: "pawprint.fill", imageCheckmark: true)
//                modalTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
//                customBar.hewanDipilih.text = "Semua hewan dipilih"
//            }
//        } else {
//            customBar.boxBtn.setImage(uncheckedImage, for: .normal)
//            if let cell = modalTableView.cellForRow(at: indexPath) as? ModalMonitoringTableViewCell {
//             //   cell.configure(namePet: "Budiman", petImage: "pawprint.fill", imageCheckmark: false)
//                modalTableView.deselectRow(at: indexPath, animated: true)
//                customBar.hewanDipilih.text = "Tidak ada hewan dipilih"
//            }
//        }
//    }
//    customBar.hewanDipilih.text = "\(modalTableView.indexPathsForSelectedRows?.count ?? 0) hewan dipilih"
//    if modalTableView.indexPathsForSelectedRows?.count == totalCell {
//        customBar.boxBtn.setImage(checkedImage, for: .normal)
//        isChecked = true
//        customBar.hewanDipilih.text = "Semua hewan dipilih"
//    }
    @objc func addPet() {
        dismiss(animated: true)
    }
}

extension ModalSelectPetViewController:  UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
