//
//  AddPetViewController.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 25/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class AddPetViewController: UIViewController {
    
    //MARK: - Variable Declaration
    private let addPetViewModel  = AddPetViewModel()
    private var petGenderObject  = BehaviorRelay<genderCase>(value: .male)
    private var petTypeObject = BehaviorRelay<petTypeCase>(value: .kucing)
    private var petIconObject = BehaviorRelay<petIconCase>(value: .dog1)
    private var petSizeObject = BehaviorRelay<petSizeCase>(value: .kucingKecil)
    
    private var petTypeObserver : Observable<petTypeCase> {
        return petTypeObject.asObservable()
    }
    private var petGenderObjectObserver: Observable<genderCase> {
        return petGenderObject.asObservable()
    }
    private var petSizeObserver : Observable<petSizeCase> {
        return petSizeObject.asObservable()
    }
    
    private let petIconData : [String]  = ["dog1","dog2","dog3","dog4","dog5","dog6","dog7","dog8","dog9"]
    private let petSizeData : [String?] = ["Kucing Kecil (Panjang 5 - 10 cm)", "Kucing Sedang (Panjang 10 - 15 cm)", "Kucing Besar (Panjang 15 - 20 cm)", "Anjing Kecil (Panjang 5 - 10 cm)", "Anjing Sedang (Panjang 10 - 15 cm)", "Anjing Besar (Panjang 15 - 20 cm)"]
    
    //MARK: Subviews
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = UIColor(named: "white")
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private lazy var scrollContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "white")
        return view
    }()
    
    private lazy var headline: ReuseableLabel = {
        let headline = ReuseableLabel(labelText: "Tambah Hewan", labelType: .titleH1, labelColor: .black)
        return headline
    }()
    
    private lazy var titleNamaHewan = ReuseableLabel(labelText: "Apa nama hewanmu?", labelType: .titleH3, labelColor: .black)
    
    private lazy var namaHewan: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "grey3")
        textField.layer.cornerRadius = 12
        textField.setLeftField(image: UIImage())
        textField.tintColor = UIColor(named: "black")
        textField.font = UIFont(name: "Inter-Medium", size: 12)
        textField.attributedPlaceholder = NSAttributedString(string: "Masukkan nama hewan...", attributes: [
            .foregroundColor: UIColor(named: "grey2") as Any,
            .font: UIFont(name: "Inter-Medium", size: 12)!
        ])
        textField.delegate = self
        return textField
    }()
    
    private lazy var titleTipeHewan = ReuseableLabel(labelText: "Hewanmu anjing atau kucing?", labelType: .titleH3, labelColor: .black)
    
    private lazy var hewanAnjing: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "secondary5")
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(named: "secondary5")?.cgColor
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "dog-icon")
        view.addSubview(imageView)
        
        let text = ReuseableLabel(labelText: "Anjing", labelType: .bodyP2, labelColor: .black)
        view.addSubview(text)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.tapHewanAnjing (_:)))
        view.addGestureRecognizer(gesture)
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 167),
            view.heightAnchor.constraint(equalToConstant: 82),
            
            imageView.widthAnchor.constraint(equalToConstant: 28),
            imageView.heightAnchor.constraint(equalToConstant: 28),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
        ])
        
        return view
    }()
    
    private lazy var hewanKucing: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "primary5")
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(named: "primary5")?.cgColor
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "cat-icon")
        view.addSubview(imageView)
        
        let text = ReuseableLabel(labelText: "Kucing", labelType: .bodyP2, labelColor: .black)
        view.addSubview(text)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.tapHewanKucing (_:)))
        view.addGestureRecognizer(gesture)
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 167),
            view.heightAnchor.constraint(equalToConstant: 82),
            
            imageView.widthAnchor.constraint(equalToConstant: 28),
            imageView.heightAnchor.constraint(equalToConstant: 28),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
        ])
        
        return view
    }()
    
    private lazy var titleUkuranHewan = ReuseableLabel(labelText: "Hewanmu termasuk ukuran apa?", labelType: .titleH3, labelColor: .black)
    
    private lazy var ukuranHewan: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "grey3")
        textField.layer.cornerRadius = 12
        textField.setLeftField(image: UIImage())
        textField.tintColor = UIColor(named: "black")
        textField.font = UIFont(name: "Inter-Medium", size: 12)
        textField.attributedPlaceholder = NSAttributedString(string: "Masukkan ukuran hewan...", attributes: [
            .foregroundColor: UIColor(named: "grey2") as Any,
            .font: UIFont(name: "Inter-Medium", size: 12)!
        ])
        textField.inputView = pickerUkuran
        return textField
    }()
    
    private lazy var pickerUkuran: UIPickerView = {
       let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    private lazy var titleJenisKelamin = ReuseableLabel(labelText: "Apa jenis kelaminnya?", labelType: .titleH3, labelColor: .black)
    
    private lazy var kelaminJantan: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "secondary5")
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(named: "secondary5")?.cgColor
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "male")
        view.addSubview(imageView)
        
        let text = ReuseableLabel(labelText: "Jantan", labelType: .bodyP2, labelColor: .black)
        view.addSubview(text)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.tapKelaminJantan (_:)))
        view.addGestureRecognizer(gesture)
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 167),
            view.heightAnchor.constraint(equalToConstant: 82),
            
            imageView.widthAnchor.constraint(equalToConstant: 28),
            imageView.heightAnchor.constraint(equalToConstant: 28),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
        ])
        
        return view
    }()
    
    private lazy var kelaminBetina: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "primary5")
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(named: "primary5")?.cgColor
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "female")
        view.addSubview(imageView)
        
        let text = ReuseableLabel(labelText: "Betina", labelType: .bodyP2, labelColor: .black)
        view.addSubview(text)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.tapKelaminBetina (_:)))
        view.addGestureRecognizer(gesture)
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 167),
            view.heightAnchor.constraint(equalToConstant: 82),
            
            imageView.widthAnchor.constraint(equalToConstant: 28),
            imageView.heightAnchor.constraint(equalToConstant: 28),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
        ])
        
        return view
    }()
    
    private lazy var titleUmurHewan = ReuseableLabel(labelText: "Umur hewanku", labelType: .titleH3, labelColor: .black)
    
    private lazy var titleUmurHewan2 = ReuseableLabel(labelText: "tahun", labelType: .bodyP2, labelColor: .black)
    
    private lazy var umurHewan: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "grey3")
        textField.layer.cornerRadius = 12
        textField.textAlignment = .center
        textField.tintColor = UIColor(named: "black")
        textField.font = UIFont(name: "Inter-Medium", size: 12)
        textField.attributedPlaceholder = NSAttributedString(string: "0", attributes: [
            .foregroundColor: UIColor(named: "grey2") as Any,
            .font: UIFont(name: "Inter-Medium", size: 12)!
        ])
        textField.keyboardType = .numberPad
        textField.delegate = self
        return textField
    }()
    
    private lazy var titleRasHewan = ReuseableLabel(labelText: "Apa ras hewanmu?", labelType: .titleH3, labelColor: .black)
    
    private lazy var rasHewan: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "grey3")
        textField.layer.cornerRadius = 12
        textField.setLeftField(image: UIImage())
        textField.tintColor = UIColor(named: "black")
        textField.font = UIFont(name: "Inter-Medium", size: 12)
        textField.attributedPlaceholder = NSAttributedString(string: "Masukkan jenis hewan...", attributes: [
            .foregroundColor: UIColor(named: "grey2") as Any,
            .font: UIFont(name: "Inter-Medium", size: 12)!
        ])
        textField.delegate = self
        return textField
    }()
    
    private lazy var titleIconHewan = ReuseableLabel(labelText: "Pilih icon hewan", labelType: .titleH3, labelColor: .black)
    
    private lazy var customBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Simpan", showText: .notShow)
        customBar.barBtn.addTarget(self, action: #selector(addPet), for: .touchUpInside)
        return customBar
    }()
    
    private lazy var iconCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 72, height: 72)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PetIconCollectionViewCell.self, forCellWithReuseIdentifier: PetIconCollectionViewCell.cellId)
        collectionView.backgroundColor = .clear
        collectionView.frame = view.bounds
        return collectionView
    }()
    
    private lazy var barBtnHapusPet: ReusableButton = {
        let barBtnHapusPet = ReusableButton(titleBtn: "Batal", styleBtn: .light)
        barBtnHapusPet.addTarget(self, action: #selector(batalPet), for: .touchUpInside)
        return barBtnHapusPet
    }()
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "white")
        
        navigationItem.titleView = ReuseableLabel(labelText: "Tambah Hewan", labelType: .titleH2, labelColor: .black)
        
        //MARK: - Add Subview
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContainer)
        
        //Dismiss Keyboard While Tapping View Screen
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
        
        scrollContainer.addSubview(headline)
        
        scrollContainer.addSubview(titleNamaHewan)
        scrollContainer.addSubview(namaHewan)
        
        scrollContainer.addSubview(titleTipeHewan)
        scrollContainer.addSubview(hewanAnjing)
        scrollContainer.addSubview(hewanKucing)
        
        scrollContainer.addSubview(titleUkuranHewan)
        scrollContainer.addSubview(ukuranHewan)
        
        scrollContainer.addSubview(titleJenisKelamin)
        scrollContainer.addSubview(kelaminJantan)
        scrollContainer.addSubview(kelaminBetina)
        
        scrollContainer.addSubview(titleUmurHewan)
        scrollContainer.addSubview(umurHewan)
        scrollContainer.addSubview(titleUmurHewan2)
        
        scrollContainer.addSubview(titleRasHewan)
        scrollContainer.addSubview(rasHewan)
        
        scrollContainer.addSubview(titleIconHewan)
        scrollContainer.addSubview(iconCollectionView)
        
        view.addSubview(customBar)
        view.addSubview(barBtnHapusPet)
      
        
        let scrollContentGuide = scrollView.contentLayoutGuide
        let scrollFrameGuide = scrollView.frameLayoutGuide
        
        //MARK: Setup Constraints
        NSLayoutConstraint.activate([
            
            //MARK: - ScrollView Constraints
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: customBar.topAnchor),
            
            scrollContainer.leadingAnchor.constraint(equalTo: scrollContentGuide.leadingAnchor),
            scrollContainer.trailingAnchor.constraint(equalTo: scrollContentGuide.trailingAnchor),
            scrollContainer.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor),
            scrollContainer.bottomAnchor.constraint(equalTo: scrollContentGuide.bottomAnchor),
            
            scrollContainer.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor),
            scrollContainer.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor),
            scrollContainer.heightAnchor.constraint(equalToConstant: 1050),
            
            //MARK: - Headline Constraint
            headline.topAnchor.constraint(equalTo: scrollContainer.topAnchor, constant: 20),
            headline.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            
            //MARK: - Input Nama Hewan Constraint
            titleNamaHewan.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            titleNamaHewan.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 20),
            
            namaHewan.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            namaHewan.topAnchor.constraint(equalTo: titleNamaHewan.bottomAnchor, constant: 12),
            namaHewan.heightAnchor.constraint(equalToConstant: 40),
            namaHewan.widthAnchor.constraint(equalToConstant: 342),
            
            //MARK: - Input Tipe Hewan Constraint
            titleTipeHewan.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            titleTipeHewan.topAnchor.constraint(equalTo: namaHewan.bottomAnchor, constant: 32),
            
            hewanAnjing.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            hewanAnjing.topAnchor.constraint(equalTo: titleTipeHewan.bottomAnchor, constant: 12),
            
            hewanKucing.leadingAnchor.constraint(equalTo: hewanAnjing.trailingAnchor, constant: 8),
            hewanKucing.topAnchor.constraint(equalTo: titleTipeHewan.bottomAnchor, constant: 12),
            
            //MARK: - Input Jenis Hewan Constraint
            titleUkuranHewan.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            titleUkuranHewan.topAnchor.constraint(equalTo: hewanAnjing.bottomAnchor, constant: 32),
            
            ukuranHewan.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            ukuranHewan.topAnchor.constraint(equalTo: titleUkuranHewan.bottomAnchor, constant: 12),
            ukuranHewan.heightAnchor.constraint(equalToConstant: 40),
            ukuranHewan.widthAnchor.constraint(equalToConstant: 342),
            
            //MARK: - Input Kelamin Hewan Constraint
            titleJenisKelamin.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            titleJenisKelamin.topAnchor.constraint(equalTo: ukuranHewan.bottomAnchor, constant: 32),
            
            kelaminJantan.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            kelaminJantan.topAnchor.constraint(equalTo: titleJenisKelamin.bottomAnchor, constant: 12),
            
            kelaminBetina.leadingAnchor.constraint(equalTo: kelaminJantan.trailingAnchor, constant: 8),
            kelaminBetina.topAnchor.constraint(equalTo: titleJenisKelamin.bottomAnchor, constant: 12),
            
            //MARK: - Input Umur Hewan Constraint
            titleUmurHewan.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            titleUmurHewan.topAnchor.constraint(equalTo: kelaminJantan.bottomAnchor, constant: 44),
            
            titleUmurHewan2.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -24),
            titleUmurHewan2.topAnchor.constraint(equalTo: kelaminJantan.bottomAnchor, constant: 44),
            
            umurHewan.leadingAnchor.constraint(equalTo: titleUmurHewan.trailingAnchor, constant: 74),
            umurHewan.trailingAnchor.constraint(equalTo: titleUmurHewan2.leadingAnchor, constant: -16),
            umurHewan.topAnchor.constraint(equalTo: kelaminJantan.bottomAnchor, constant: 32),
            umurHewan.heightAnchor.constraint(equalToConstant: 40),
            umurHewan.widthAnchor.constraint(equalToConstant: 124),
            
            //MARK: - Input Ras Hewan Constraint
            titleRasHewan.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            titleRasHewan.topAnchor.constraint(equalTo: umurHewan.bottomAnchor, constant: 32),
            
            rasHewan.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            rasHewan.topAnchor.constraint(equalTo: titleRasHewan.bottomAnchor, constant: 12),
            rasHewan.heightAnchor.constraint(equalToConstant: 40),
            rasHewan.widthAnchor.constraint(equalToConstant: 342),
            
            //MARK: - Input Icon Hewan Constraint
            titleIconHewan.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            titleIconHewan.topAnchor.constraint(equalTo: rasHewan.bottomAnchor, constant: 32),
            
            iconCollectionView.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            iconCollectionView.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -24),
            iconCollectionView.topAnchor.constraint(equalTo: titleIconHewan.bottomAnchor, constant: 12),
            iconCollectionView.bottomAnchor.constraint(equalTo: scrollContainer.bottomAnchor),
            
            customBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            barBtnHapusPet.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            barBtnHapusPet.centerYAnchor.constraint(equalTo: customBar.barBtn.centerYAnchor),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//
//        addPetViewModel.addPetErrorObjectObserver.subscribe(onNext: { [self] (value) in
//                //switch value {
////            case .sukses:
////                self.present(genericAlert(titleAlert: "", messageAlert: <#T##String#>, buttonText: <#T##String#>), animated: <#T##Bool#>)
////            case .petIconTidakAda:
////
////            case .petBreedTidakAda:
////
////            case .petGenderTidakAda:
////
////            case .petNameTidakAda:
////
////            case .petSizeTidakAda:
////
////            case .petTypeTidakAda:
////
//
//            }
//        }).disposed(by: bags)
//
        
        addPetViewModel.addPetErrorObjectObserver.skip(1).subscribe(onNext: { [self] (value) in
            let test = value
            print(value)
          //  self.present(genericAlert(titleAlert: value.errorTitle, messageAlert: value., buttonText: <#T##String#>), animated: <#T##Bool#>)
        }).disposed(by: bags)
        
        petTypeObserver.skip(1).subscribe(onNext: { [self] (value) in
            switch value {
                case .kucing:
                    hewanAnjing.layer.borderColor = UIColor(named: "secondary5")?.cgColor
                    hewanKucing.layer.borderColor = UIColor(named: "primaryMain")?.cgColor
                case .anjing:
                    hewanAnjing.layer.borderColor = UIColor(named: "secondaryMain")?.cgColor
                    hewanKucing.layer.borderColor = UIColor(named: "primary5")?.cgColor
            }
        }).disposed(by: bags)
        
        petSizeObserver.skip(1).subscribe(onNext: { [self] (value) in
            ukuranHewan.text = value.rawValue
        }).disposed(by: bags)
        
        petGenderObjectObserver.skip(1).subscribe(onNext: { [self] (value) in
            switch value {
            case .female:
                kelaminJantan.layer.borderColor = UIColor(named: "secondary5")?.cgColor
                kelaminBetina.layer.borderColor = UIColor(named: "primaryMain")?.cgColor
            case .male:
                kelaminJantan.layer.borderColor = UIColor(named: "secondaryMain")?.cgColor
                kelaminBetina.layer.borderColor = UIColor(named: "primary5")?.cgColor
            }
        }).disposed(by: bags)
    }
    
    @objc func batalPet() {
        dismiss(animated: true)
    }
    
    @objc func addPet() {
        addPetViewModel.testFunction()
        ///addPetViewModel.addPet(<#T##UUID#>, <#T##Int16?#>, <#T##String?#>, <#T##String?#>, <#T##String?#>, <#T##String?#>, <#T##String?#>, <#T##String?#>, <#T##Date#>, completion: <#T##(addPetErrorCase) -> Void#>)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func tapHewanAnjing(_ sender:UITapGestureRecognizer){
        petTypeObject.accept(.anjing)
    }

    @objc func tapHewanKucing(_ sender:UITapGestureRecognizer){
        petTypeObject.accept(.kucing)
    }

    @objc func tapKelaminJantan(_ sender:UITapGestureRecognizer){
        petGenderObject.accept(.male)
    }

    @objc func tapKelaminBetina(_ sender:UITapGestureRecognizer){
        petGenderObject.accept(.female)
    }
   
}

extension AddPetViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        petSizeData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        petSizeData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let petSize = petSizeCase(rawValue: petSizeData[row]!)
        petSizeObject.accept(petSize!)
        ukuranHewan.resignFirstResponder()
    }
}

extension AddPetViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == umurHewan {
            let allowedCharacters = "0123456789"
            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharacterSetIn = CharacterSet(charactersIn: string)
            let numbers = allowedCharacterSet.isSuperset(of: typedCharacterSetIn)
            return numbers
        }
        return true
    }
    
    //Dismiss Keyboard When Click Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
}

extension AddPetViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return petIconData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetIconCollectionViewCell.cellId, for: indexPath) as! PetIconCollectionViewCell
 
        //MARK: - Add Pet Icon Data Here
        cell.configure(petIconData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = iconCollectionView.cellForItem(at: indexPath) as! PetIconCollectionViewCell
        cell.contentView.backgroundColor = UIColor(named: "primaryMain")
        let petIconCase = petIconCase(rawValue: petIconData[indexPath.row])
        petIconObject.accept(petIconCase!)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = iconCollectionView.cellForItem(at: indexPath) as! PetIconCollectionViewCell
        cell.contentView.backgroundColor = UIColor(named: "white")
    }
    
}

extension UITextField {
    func setLeftField(image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20)) // set your Own size
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
