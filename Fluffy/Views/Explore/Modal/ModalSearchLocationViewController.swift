//
//  ModalSearchLocationViewController.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 24/10/22.
//

import MapKit
import UIKit
import RxCocoa
import RxSwift

class ModalSearchLocationViewController: UIViewController {
    
    //MARK: - OBJECT DECLARATION
    private var modalSearchLocationViewModel = ModalSearchLocationViewModel()
    private var searchCompleterObject        = BehaviorRelay<MKLocalSearchCompleter>(value: MKLocalSearchCompleter())
    private var searchResultsObject          = BehaviorRelay<[MKLocalSearchCompletion]>(value: [])
    private var modalSearchLocationObject    = BehaviorRelay<LocationDetail>(value: LocationDetail(longitude: 0.0, latitude: 0.0, locationName: ""))
    
    //MARK: - OBJECT OBSERVER DECLARATION
    var searchResultsObjectObserver: Observable<[MKLocalSearchCompletion]> {
        return searchResultsObject.asObservable()
    }
    
    //MARK: - OBJECT OBSERVER DECLARATION
    var modalSearchObjectObserver: Observable<LocationDetail> {
        return modalSearchLocationObject.asObservable()
    }
    
    //MARK: - SUBVIEWS
    public var passingLocation: ((String?) -> Void)?
    private lazy var indicator: UIImageView = {
        let indicator = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
        indicator.image = UIImage(systemName: "minus", withConfiguration: config)
        indicator.tintColor = UIColor(named: "grey2")
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var headline: ReuseableLabel = {
        let headline = ReuseableLabel(labelText: "Cari Pet Hotel", labelType: .titleH1, labelColor: .black)
        return headline
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.searchBarStyle = .prominent
        searchBar.searchTextField.font = UIFont(name: "Inter-Medium", size: 12)
        searchBar.searchTextField.backgroundColor = UIColor(named: "grey3")
        searchBar.searchTextField.layer.cornerRadius = 8
        searchBar.tintColor = UIColor(named: "grey1")
        searchBar.barTintColor = UIColor(named: "white")
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = searchBar.barTintColor?.cgColor
        searchBar.placeholder = "Cari Lokasi Pet Hotel"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var modalTableView: UITableView = {
        let modalTableView = UITableView(frame: CGRect(), style: .plain)
        modalTableView.backgroundColor = UIColor(named: "gray3")
        modalTableView.translatesAutoresizingMaskIntoConstraints = false
        modalTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        modalTableView.showsVerticalScrollIndicator = false
        modalTableView.isScrollEnabled = true
        modalTableView.separatorStyle = .singleLine
        return modalTableView
    }()
        
    private func setupUI() {
        view.backgroundColor = UIColor(named: "white")
    
        //MARK: - Add Subview
        view.addSubview(indicator)
        view.addSubview(headline)
        view.addSubview(searchBar)
        view.addSubview(modalTableView)
        
        //MARK: - Setup Constraint
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),

            headline.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            headline.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            headline.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -198),
            
            searchBar.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            modalTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            modalTableView.widthAnchor.constraint(equalToConstant: 342),
            modalTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            modalTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        searchCompleterObject.value.delegate = self
        
        //MARK: - Bind Journal List with Table View
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        searchResultsObject.bind(to: modalTableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, model, cell in
            cell.textLabel?.text = model.title
            cell.detailTextLabel?.text = model.subtitle
        }.disposed(by: bags)
        
        //MARK: - Bind Journal List with Table View
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        modalTableView.rx.itemSelected.subscribe(onNext: { [self] (indexPath) in
            modalTableView.deselectRow(at: indexPath, animated: true)
            modalSearchLocationViewModel.searchResultsObject.accept(searchResultsObject.value[indexPath.row])
            modalSearchLocationViewModel.getLocationObject()
        }).disposed(by: bags)
        
        //MARK: - Bind Journal List with Table View
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        modalSearchLocationViewModel.modalSearchObjectObserver.skip(1).subscribe(onNext: { [self] (value) in
            modalSearchLocationObject.accept(value)
            self.dismiss(animated: true)
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
    }
}

extension ModalSearchLocationViewController :  MKLocalSearchCompleterDelegate  {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResultsObject.accept(completer.results)
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
    }
}

extension ModalSearchLocationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleterObject.value.queryFragment = searchText
    }
}
