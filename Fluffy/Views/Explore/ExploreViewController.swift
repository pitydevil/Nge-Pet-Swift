//
//  ExploreViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 17/10/22.
//
import UIKit

@available(iOS 16.0, *)
class ExploreViewController: UIViewController {
    
    //MARK: Subviews
    private let scrollView:UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = UIColor(named: "primaryMain")
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private lazy var exploreRect:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "primaryMain")
        return view
    }()
    private lazy var roundedCorner:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "grey3")
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private lazy var exploreLabel:ReuseableLabel = ReuseableLabel(labelText: "Hello, Mau nitip hewan di mana nih?", labelType: .titleH1, labelColor: .white)
    
    private lazy var searchLocation: UITextField = {
        let textField = UITextField()
        textField.setLeftView(image: UIImage(systemName: "mappin.and.ellipse")!, color: UIColor(named: "white")!)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "primary2")
        textField.layer.cornerRadius = 12
        textField.attributedPlaceholder = NSAttributedString(string: "Lokasi Hotel", attributes: [
            .foregroundColor: UIColor(named: "primary4") as Any,
            .font: UIFont(name: "Inter-Medium", size: 12)!
        ])
        textField.addTarget(self, action: #selector(toSearchModal), for: .editingDidBegin)
        return textField
    }()
    
    private lazy var searchDate: UITextField = {
        let textField = UITextField()
        textField.setLeftView(image: UIImage(systemName: "calendar")!, color: UIColor(named: "white")!)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "primary2")
        textField.layer.cornerRadius = 12
        textField.attributedPlaceholder = NSAttributedString(string: "Tanggal Reservasi", attributes: [
            .foregroundColor: UIColor(named: "primary4") as Any,
            .font: UIFont(name: "Inter-Medium", size: 12)!
        ])
        textField.addTarget(self, action: #selector(toDateModal), for: .editingDidBegin)
        return textField
    }()
    
    private lazy var searchPet: UITextField = {
        let textField = UITextField()
        textField.setLeftView(image: UIImage(systemName: "pawprint.fill")!, color: UIColor(named: "white")!)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "primary2")
        textField.layer.cornerRadius = 12
        textField.attributedPlaceholder = NSAttributedString(string: "Pilih Hewan", attributes: [
            .foregroundColor: UIColor(named: "primary4") as Any,
            .font: UIFont(name: "Inter-Medium", size: 12)!
        ])
        textField.addTarget(self, action: #selector(toSelectPetModal), for: .editingDidBegin)
        return textField
    }()
    
    private lazy var searchButton:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Cari Hotel", styleBtn:.longOutline)
        btn.translatesAutoresizingMaskIntoConstraints = false
                btn.addTarget(self, action: #selector(search), for: .touchUpInside)
        return btn
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(ExploreTableViewCell.self, forCellReuseIdentifier: ExploreTableViewCell.cellId)
        tableView.separatorColor = .clear
        tableView.allowsSelection = true
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "grey3")
        return tableView
    }()
    //MARK: -ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
//        self.navigationItem.backBarButtonItem?.tintColor = UIColor(named: "grey1")
        view.backgroundColor = UIColor(named: "grey3")
        self.navigationController?.navigationBar.tintColor = UIColor(named: "primaryMain")
        view.addSubview(scrollView)

        scrollView.addSubview(exploreRect)
        scrollView.addSubview(exploreLabel)
        scrollView.addSubview(searchLocation)
        scrollView.addSubview(searchDate)
        scrollView.addSubview(searchPet)
        scrollView.addSubview(searchButton)
        scrollView.addSubview(roundedCorner)
        scrollView.addSubview(tableView)
        view.insetsLayoutMarginsFromSafeArea = false
        setupUI()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Navigation Customization
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.navigationBar.shadowImage = nil
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        // Remove 'Back' text and Title from Navigation Bar
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc func toSearchModal() {
        let vc = ModalSearchLocationViewController()
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true)
    }
    
    @objc func search() {
        let vc = SearchExploreViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @available(iOS 16.0, *)
    @objc func toDateModal() {
        let vc = ModalCheckInOutViewController()
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true)
    }
    
    @objc func toSelectPetModal() {
        let vc = ModalSelectPetViewController()
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true)
    }
    
}


//MARK: Setup Layout
@available(iOS 16.0, *)
extension ExploreViewController{
    func setupUI(){
        
        //MARK: Scroll View Constraints
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 5000)
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        //MARK: Red Rectangle Constraints
        exploreRect.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        exploreRect.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        exploreRect.heightAnchor.constraint(equalToConstant: 450).isActive = true
        exploreRect.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        
        //MARK: Explore Label Constraints
        exploreLabel.topAnchor.constraint(equalTo: exploreRect.topAnchor, constant: 68).isActive = true
        exploreLabel.leftAnchor.constraint(equalTo: exploreRect.leftAnchor, constant: 16).isActive = true
        exploreLabel.rightAnchor.constraint(equalTo: exploreRect.rightAnchor, constant: -16).isActive = true
        exploreLabel.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        //MARK: Search Location Constraints
        searchLocation.topAnchor.constraint(equalTo: exploreLabel.bottomAnchor, constant: 20).isActive = true
        searchLocation.leftAnchor.constraint(equalTo: exploreRect.leftAnchor, constant: 16).isActive = true
        searchLocation.rightAnchor.constraint(equalTo: exploreRect.rightAnchor, constant: -16).isActive = true
        searchLocation.heightAnchor.constraint(equalToConstant: 44).isActive = true

        //MARK: Search Date Constraints
        searchDate.topAnchor.constraint(equalTo: searchLocation.bottomAnchor, constant: 12).isActive = true
        searchDate.leftAnchor.constraint(equalTo: exploreRect.leftAnchor, constant: 16).isActive = true
        searchDate.rightAnchor.constraint(equalTo: exploreRect.rightAnchor, constant: -16).isActive = true
        searchDate.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        //MARK: Search Pet Constraints
        searchPet.topAnchor.constraint(equalTo: searchDate.bottomAnchor, constant: 12).isActive = true
        searchPet.leftAnchor.constraint(equalTo: exploreRect.leftAnchor, constant: 16).isActive = true
        searchPet.rightAnchor.constraint(equalTo: exploreRect.rightAnchor, constant: -16).isActive = true
        searchPet.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        //MARK: Search Button Constraints
        searchButton.topAnchor.constraint(equalTo: searchPet.bottomAnchor, constant: 20).isActive = true
        searchButton.leftAnchor.constraint(equalTo: exploreRect.leftAnchor, constant: 16).isActive = true
        searchButton.rightAnchor.constraint(equalTo: exploreRect.rightAnchor, constant: -16).isActive = true
        
        //        MARK: Rounded Corner Constraints
        roundedCorner.heightAnchor.constraint(equalToConstant: 40).isActive = true
        roundedCorner.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        roundedCorner.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        roundedCorner.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        roundedCorner.bottomAnchor.constraint(equalTo: exploreRect.bottomAnchor).isActive = true
        
        //MARK: Table View Constraints
        tableView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 440).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        tableView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 5000).isActive = true
        tableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
}

//MARK: UITableViewDataSource, UITableViewDelegate

@available(iOS 16.0, *)
extension ExploreViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 20
        }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: ExploreTableViewCell.cellId) as! ExploreTableViewCell
            cell.backgroundColor = .clear
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 248
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newViewController = PetHotelViewController()
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}

//MARK: add left image
extension UITextField {
    func setLeftView(image: UIImage, color:UIColor) {
        let iconView = UIImageView(frame: CGRect(x: 21, y: 10, width: 16, height: 16)) // set your Own size
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 32))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
        self.tintColor = color
    }
}
