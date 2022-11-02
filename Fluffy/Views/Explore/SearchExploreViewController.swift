//
//  SearchExploreViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 02/11/22.
//

import UIKit

class SearchExploreViewController: UIViewController {

    //MARK: Subviews
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.setLeftView(image: UIImage(systemName: "magnifyingglass")!)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "primary2")
        textField.layer.cornerRadius = 12
        textField.attributedPlaceholder = NSAttributedString(string: "lokasi", attributes: [
            .foregroundColor: UIColor(named: "primary4") as Any,
            .font: UIFont(name: "Inter-Medium", size: 12)!
        ])
//        textField.addTarget(self, action: #selector(toSelectPetModal), for: .editingDidBegin)
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "grey3")
        self.navigationItem.titleView = searchTextField
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = UIColor(named: "primaryMain")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
        view.addSubview(searchTextField)
        
        searchTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
    }
    
}
