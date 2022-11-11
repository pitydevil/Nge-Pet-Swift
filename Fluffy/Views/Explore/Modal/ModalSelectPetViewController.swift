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
    
    var totalCell = 3
    var isChecked = true
    let checkedImage = UIImage(systemName: "checkmark.square.fill")
    let uncheckedImage = UIImage(systemName: "square")
    
    //MARK: - Show Empty State vs Exist State
    var isPetExist = true
    
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
        addPetBtn.addTarget(self, action: #selector(addPet), for: .touchUpInside)
        return addPetBtn
    }()
    
    private lazy var headline: ReuseableLabel = {
        let headline = ReuseableLabel(labelText: "Pilih Hewan", labelType: .titleH1, labelColor: .black)
        return headline
    }()
    
    private lazy var modalTableView: UITableView = {
        let modalTableView = UITableView(frame: CGRect(), style: .plain)
        modalTableView.delegate = self
        modalTableView.dataSource = self
        modalTableView.backgroundColor = UIColor(named: "white")
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
        customBar.barBtn.addTarget(self, action: #selector(petSelected), for: .touchUpInside)
        customBar.boxBtn.addTarget(self, action: #selector(isClicked), for: .touchUpInside)
        customBar.boxBtn.setImage(checkedImage, for: .normal)
        return customBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "white")
        
        if isPetExist == true {
            petExist()
        } else {
            emptyPet()
        }
        
    }
    
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
    
    public var passingPet: ((String?) -> Void)?
    
    //MARK: - Button Target
    @objc func petSelected() {
        passingPet?("\(modalTableView.indexPathsForSelectedRows?.count ?? 0) hewan dipilih")
        dismiss(animated: true)
    }
    
    @objc func addPet() {
        dismiss(animated: true)
    }
    
    @objc func isClicked() {
        isChecked = !isChecked
        for index in 0...totalCell {
            let indexPath = IndexPath(row: index, section: 0)
            if isChecked {
                customBar.boxBtn.setImage(checkedImage, for: .normal)
                if let cell = modalTableView.cellForRow(at: indexPath) as? ModalMonitoringTableViewCell {
                    cell.configure(namePet: "Budiman", petImage: "pawprint.fill", imageCheckmark: true)
                    modalTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    customBar.hewanDipilih.text = "Semua hewan dipilih"
                }
            } else {
                customBar.boxBtn.setImage(uncheckedImage, for: .normal)
                if let cell = modalTableView.cellForRow(at: indexPath) as? ModalMonitoringTableViewCell {
                    cell.configure(namePet: "Budiman", petImage: "pawprint.fill", imageCheckmark: false)
                    modalTableView.deselectRow(at: indexPath, animated: true)
                    customBar.hewanDipilih.text = "Tidak ada hewan dipilih"
                }
            }
        }
    }

}

extension ModalSelectPetViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ModalMonitoringTableViewCell.cellId, for: indexPath) as! ModalMonitoringTableViewCell
        cell.contentView.backgroundColor = UIColor(named: "grey3")
        cell.configure(namePet: "Budiman", petImage: "pawprint.fill", imageCheckmark: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        modalTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = modalTableView.cellForRow(at: indexPath) as! ModalMonitoringTableViewCell
        cell.configure(namePet: "Budiman", petImage: "pawprint.fill", imageCheckmark: true)
        customBar.hewanDipilih.text = "\(modalTableView.indexPathsForSelectedRows?.count ?? 0) hewan dipilih"
        if modalTableView.indexPathsForSelectedRows?.count == totalCell {
            customBar.boxBtn.setImage(checkedImage, for: .normal)
            isChecked = true
            customBar.hewanDipilih.text = "Semua hewan dipilih"
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = modalTableView.cellForRow(at: indexPath) as! ModalMonitoringTableViewCell
        cell.configure(namePet: "Budiman", petImage: "pawprint.fill", imageCheckmark: false)
        customBar.hewanDipilih.text = "\(modalTableView.indexPathsForSelectedRows?.count ?? 0) hewan dipilih"
        customBar.boxBtn.setImage(uncheckedImage, for: .normal)
        isChecked = false
        if modalTableView.indexPathsForSelectedRows?.count == nil {
            customBar.hewanDipilih.text = "Tidak ada hewan dipilih"
        }
    }
    
}

//MARK: - Adding Line Spacing for UILabel
extension UILabel {
    var spacing:CGFloat {
        get {return 0}
        set {
            let textAlignment = self.textAlignment
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = newValue
            let attributedString = NSAttributedString(string: self.text ?? "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
            self.attributedText = attributedString
            self.textAlignment = textAlignment
        }
    }
}
