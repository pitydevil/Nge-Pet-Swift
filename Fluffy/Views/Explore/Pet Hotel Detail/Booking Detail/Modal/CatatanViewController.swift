//
//  CatatanViewController.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 02/11/22.
//

import UIKit
import RxSwift
import RxCocoa

class CatatanViewController: UIViewController {
    
    //MARK: - OBJECT DECLARATION
    var petHotelModelObject                     = BehaviorRelay<OrderDetailBody>(value: OrderDetailBody(petName: "", petType: "", petSize: "", packagename: "", packageID: 0, orderDetailPrice: 0, isExpanded: false, customSOP: [CustomSopBody]()))
    var customSOPModelArrayObject               = BehaviorRelay<[String]>(value: [])
    var sopModelArrayObject               = BehaviorRelay<[CustomSopBody]>(value: [])
        
    //MARK: - OBJECT OBSERVER DECLARATION
    var petHotelModelObserver : Observable<OrderDetailBody> {
        return petHotelModelObject.asObservable()
    }
    
    var customSOPModelArrayObserver : Observable<[String]> {
        return customSOPModelArrayObject.asObservable()
    }
    
    var sopModelArrayObserver : Observable<[CustomSopBody]> {
        return sopModelArrayObject.asObservable()
    }
    
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
    
    private let btnCatatan = ReusableButton(titleBtn: "Tambah", styleBtn: .longOutline)
    
    private lazy var customBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Simpan", showText: .notShow)
        return customBar
    }()
    
    private func setupUI() {
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

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
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
        customSOPModelArrayObserver.subscribe(onNext: { (value) in
            DispatchQueue.main.async { [self] in
                customBar.barBtn.isEnabled = value.isEmpty ? false : true
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
        sopModelArrayObserver.subscribe(onNext: { [self] (value) in
            let customSOP = value.map { obj -> String in
                return obj.customSopName
            }
            cellContent = value.count + 1
            customSOPModelArrayObject.accept(customSOP)
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        customBar.barBtn.rx.tap.bind { [self] in
            let customSopBody = customSOPModelArrayObject.value.map { obj -> CustomSopBody in
                return CustomSopBody(customSopName: obj)
            }
            var tempOrderDetailBody = petHotelModelObject.value
            tempOrderDetailBody.customSOP = customSopBody
            petHotelModelObject.accept(tempOrderDetailBody)
            dismiss(animated: true)
        }.disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        btnCatatan.rx.tap.bind { [self] in
            let indexPath = IndexPath(row: cellContent, section: 0)
            cellContent += 1
            modalTableView.insertRows(at: [indexPath], with: .bottom)
            btnCatatan.isEnabled = false
        }.disposed(by: bags)
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
        footerView.addSubview(btnCatatan)
        btnCatatan.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        btnCatatan.leadingAnchor.constraint(equalTo: footerView.leadingAnchor).isActive = true
        btnCatatan.trailingAnchor.constraint(equalTo: footerView.trailingAnchor).isActive = true
        btnCatatan.isEnabled = false
        return footerView
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
        if indexPath.row < cellContent - 1 {
            cell.catatanKhusus.text = customSOPModelArrayObject.value[indexPath.row]
        }
        cell.catatanKhusus.delegate = self
        cell.catatanKhusus.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
////        if indexPath.row < cellContent - 1 {
////            let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, nil) in
////                let refreshAlert = UIAlertController(title: "Hapus Catatan Khusus", message: "Apakah anda yakin ingin menghapus catatan khusus ini?", preferredStyle: .alert)
////
////                refreshAlert.addAction(UIAlertAction(title: "Hapus", style: .destructive, handler: { [self] (action: UIAlertAction!) in
////                    var tempSopModel = customSOPModelArrayObject.value
////                    tempSopModel.remove(at: indexPath.row)
////                    customSOPModelArrayObject.accept(tempSopModel)
////                    tableView.reloadData()
////                }))
////                refreshAlert.addAction(UIAlertAction(title: "Batal", style: .default, handler: { (action: UIAlertAction!) in
////                    refreshAlert .dismiss(animated: true, completion: nil)
////                }))
////                self.present(refreshAlert, animated: true, completion: nil)
////            }
////            delete.backgroundColor = UIColor.systemRed
////            delete.image = UIImage(systemName: "trash.circle.fill")
////            let config = UISwipeActionsConfiguration(actions: [delete])
////            config.performsFirstActionWithFullSwipe = false
////            return config
////        }else {
////            return nil
////        }
//    }
}

extension CatatanViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let index = IndexPath(row: textField.tag, section: 0)
        if let cell = modalTableView.cellForRow(at: index as IndexPath)as? CatatanTableViewCell {
           var tempSopModel = customSOPModelArrayObject.value
           if cell.catatanKhusus.text != "" {
               if customSOPModelArrayObject.value.isEmpty {
                   tempSopModel.append(cell.catatanKhusus.text ?? "")
               }else {
                   if index.row < cellContent - 1 {
                       tempSopModel[index.row] = cell.catatanKhusus.text ?? ""
                   }else {
                       tempSopModel.append(cell.catatanKhusus.text ?? "")
                   }
               }
               customSOPModelArrayObject.accept(tempSopModel)
               btnCatatan.isEnabled = true
           }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
