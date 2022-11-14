//
//  HotelPackageViewController.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 02/11/22.
//

import UIKit
import RxSwift
import RxCocoa

class HotelPackageViewController: UIViewController {
    
    private let petHotelPackageViewModel       = PetHotelPackageViewModel()
    private var petHotelPackageModelArray      = BehaviorRelay<[PetHotelPackage]>(value: [])
    
    private var selectedCell = 0
    
    private lazy var indicator: UIImageView = {
        let indicator = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
        indicator.image = UIImage(systemName: "minus", withConfiguration: config)
        indicator.tintColor = UIColor(named: "grey2")
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var headline: ReuseableLabel = {
        let headline = ReuseableLabel(labelText: "Paket Hotel", labelType: .titleH1, labelColor: .black)
        return headline
    }()
    
    private lazy var modalTableView: UITableView = {
        let modalTableView = UITableView(frame: CGRect(), style: .plain)
        modalTableView.backgroundColor = UIColor(named: "grey3")
        modalTableView.delegate = self
        modalTableView.register(HotelPackageTableViewCell.self, forCellReuseIdentifier: HotelPackageTableViewCell.identifier)
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
        customBar.barBtn.addTarget(self, action: #selector(selectPackage), for: .touchUpInside)
        return customBar
    }()
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "grey3")
        
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
            headline.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -222),
            
            modalTableView.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 0),
            modalTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            modalTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            modalTableView.bottomAnchor.constraint(equalTo: customBar.topAnchor),
            
            customBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    //MARK: -VIEWWILLAPPEAR
    override func viewWillAppear(_ animated: Bool) {
        Task {
            petHotelPackageViewModel.supportedPetName.accept("Kucing")
            petHotelPackageViewModel.petHotelID.accept(1)
            await petHotelPackageViewModel.fetchPetHotelPackage()
        }
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
        petHotelPackageViewModel.petHotelPackageModelArrayObserver.subscribe(onNext: { [self] (value) in
            petHotelPackageModelArray.accept(value)
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        petHotelPackageModelArray.bind(to: modalTableView.rx.items(cellIdentifier: HotelPackageTableViewCell.identifier, cellType: HotelPackageTableViewCell.self)) { row, model, cell in
            print("budiman")
            cell.backgroundColor = UIColor(named: "white")
            cell.configure(model)
        }.disposed(by: bags)
    }
    
    @objc func selectPackage() {
        dismiss(animated: true)
    }

}

extension HotelPackageViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
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
        return 160
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HotelPackageTableViewCell.identifier, for: indexPath) as! HotelPackageTableViewCell
        cell.contentView.backgroundColor = UIColor(named: "white")
//        cell.configure(title: "Basic", detail: "- Memakai kandang besi ukuran 60 cm \n- Memakai kandang besi ukuran 60 cm", price: "Rp 60.000", select: false)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = modalTableView.cellForRow(at: indexPath) as! HotelPackageTableViewCell
//        cell.configure(title: "Basic", detail: "- Memakai kandang besi ukuran 60 cm \n- Memakai kandang besi ukuran 60 cm", price: "Rp 60.000", select: true)

    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = modalTableView.cellForRow(at: indexPath) as! HotelPackageTableViewCell
//        cell.configure(title: "Basic", detail: "- Memakai kandang besi ukuran 60 cm \n- Memakai kandang besi ukuran 60 cm", price: "Rp 60.000", select: false)

    }
}
