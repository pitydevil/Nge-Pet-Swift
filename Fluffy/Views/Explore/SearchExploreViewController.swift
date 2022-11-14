//
//  SearchExploreViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 02/11/22.
//

import UIKit
import RxCocoa
import RxSwift

@available(iOS 16.0, *)
class SearchExploreViewController: UIViewController {
    
    //MARK: - OBJECT DECLARATION
    var petHotelList = BehaviorRelay<[PetHotels]>(value: [])
    var modalSearchLocationObject = BehaviorRelay<ExploreSearchBody>(value: ExploreSearchBody(longitude: 0.0, latitude: 0.0, checkInDate: "", checkOutDate: "", pets: [PetBody]()))
    var locationNameObject = BehaviorRelay<String>(value: String())
    
    //MARK: OBJECT OBSERVER DECLARATION
    var modalSearchLocationObserver : Observable<ExploreSearchBody> {
        return modalSearchLocationObject.asObservable()
    }
    var locationNameObjectObserver : Observable<String> {
        return locationNameObject.asObservable()
    }
    
    //MARK: Subviews
    private lazy var searchTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 306, height: 40))
        textField.setLeftView(image: UIImage(systemName: "magnifyingglass")!, color: UIColor(named: "grey1")!)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "grey3")
        textField.layer.cornerRadius = 12
        textField.attributedPlaceholder = NSAttributedString(string: "lokasi", attributes: [
            .foregroundColor: UIColor(named: "grey1") as Any,
            .font: UIFont(name: "Inter-Medium", size: 12)!
        ])
        textField.allowsEditingTextAttributes = false
//        textField.addTarget(self, action: #selector(toSelectPetModal), for: .editingDidBegin)
        return textField
    }()
    
    private lazy var navTitle:ReuseableLabel = ReuseableLabel(labelText: "Hasil Pencarian", labelType: .titleH2, labelColor: .black)
    
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = true
        sc.searchBar.placeholder = "lokasi"
        sc.searchBar.barTintColor = UIColor(named: "grey1")
        return sc
    }()
    
    lazy var leftButton:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Hari Ini", styleBtn:.normal,icon: UIImage(systemName: "calendar"))
        btn.configuration?.attributedTitle = AttributedString("Hari Ini", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 12)!]))
        btn.configuration?.baseBackgroundColor = UIColor(named: "grey3")
        btn.configuration?.baseForegroundColor = UIColor(named: "grey1")
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var rightButton:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Semua Hewan", styleBtn:.normal,icon: UIImage(systemName: "pawprint.fill"))
        btn.configuration?.attributedTitle = AttributedString("Semua Hewan", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 12)!]))
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.configuration?.baseBackgroundColor = UIColor(named: "grey3")
        btn.configuration?.baseForegroundColor = UIColor(named: "grey1")
        return btn
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(ExploreTableViewCell.self, forCellReuseIdentifier: ExploreTableViewCell.cellId)
        tableView.separatorColor = .clear
        tableView.allowsSelection = true
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.sectionHeaderTopPadding = 0
        return tableView
    }()
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "white")
        self.navigationItem.titleView = navTitle
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.tintColor = UIColor(named: "primaryMain")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        view.addSubview(searchTextField)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(tableView)
 
        searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        searchTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true

        leftButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        leftButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 12).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: (view.frame.size.width-52)/2).isActive = true
        
        rightButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        rightButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        rightButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 12).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: (view.frame.size.width-52)/2).isActive = true
        
        tableView.topAnchor.constraint(equalTo: leftButton.bottomAnchor, constant: 20).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
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
        locationNameObjectObserver.subscribe(onNext: {(value) in
            DispatchQueue.main.async { [self] in
                searchTextField.text = value
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
        modalSearchLocationObject.subscribe(onNext: {(value) in
            DispatchQueue.main.async { [self] in
                rightButton.setAttributeTitleText("\(value.pets.count) Hewan", 12)
                leftButton.setAttributeTitleText("\(value.checkInDate) - \(value.checkOutDate)", 12)
            }
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Bind Journal List with Table View
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        petHotelList.bind(to: tableView.rx.items(cellIdentifier: ExploreTableViewCell.cellId, cellType: ExploreTableViewCell.self)) { row, model, cell in
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 12
            cell.selectedBackgroundView = backgroundView
            cell.petHotelSupportedObject.accept(model.petHotelSupportedPet)
            cell.setup(model)
        }.disposed(by: bags)
        
        //MARK: - Bind Journal List with Table View
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        tableView.rx.itemSelected.subscribe(onNext: { [self] (indexPath) in
            self.tableView.deselectRow(at: indexPath, animated: true)
            let petHotelViewController = PetHotelViewController()
            petHotelViewController.modalPresentationStyle = .fullScreen
            petHotelViewController.hidesBottomBarWhenPushed = true
            petHotelViewController.petHotelDetailID.accept(petHotelList.value[indexPath.row].petHotelID)
            self.navigationController?.pushViewController(petHotelViewController, animated: true)
        }).disposed(by: bags)
    }
}

@available(iOS 16.0, *)
extension SearchExploreViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 216
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        if section>=1{
            return 32
        }
        return 0
    }
}

@available(iOS 16.0, *)
extension SearchExploreViewController :  UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
