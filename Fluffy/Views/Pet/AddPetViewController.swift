//
//  AddPetViewController.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 25/10/22.
//

import UIKit

class AddPetViewController: UIViewController {
    
    //MARK: Subviews
    private let scrollView:UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = UIColor(named: "grey3")
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private lazy var titleNamaHewan = ReuseableLabel(labelText: "Apa nama hewanmu?", labelType: .titleH3, labelColor: .black)
    
    private lazy var namaHewan: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "grey3")
        textField.layer.cornerRadius = 12
        textField.attributedPlaceholder = NSAttributedString(string: "Masukkan nama hewanmu...", attributes: [
            .foregroundColor: UIColor(named: "grey2") as Any,
            .font: UIFont(name: "Inter-Medium", size: 12)!
        ])
        return textField
    }()
    
    private lazy var titleTipeHewan = ReuseableLabel(labelText: "Hewanmu anjing atau kucing?", labelType: .titleH3, labelColor: .black)
    
    private lazy var hewanAnjing: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "secondary5")
        view.layer.cornerRadius = 12
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "dog-icon")
        view.addSubview(imageView)
        
        let text = ReuseableLabel(labelText: "Anjing", labelType: .bodyP2, labelColor: .black)
        view.addSubview(text)
        
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
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "cat-icon")
        view.addSubview(imageView)
        
        let text = ReuseableLabel(labelText: "Kucing", labelType: .bodyP2, labelColor: .black)
        view.addSubview(text)
        
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
    
    private lazy var titleJenisHewan = ReuseableLabel(labelText: "Hewanmu termasuk jenis apa?", labelType: .titleH3, labelColor: .black)
    
    private lazy var jenisHewan: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "grey3")
        textField.layer.cornerRadius = 12
        textField.attributedPlaceholder = NSAttributedString(string: "Masukkan ukuran hewan...", attributes: [
            .foregroundColor: UIColor(named: "grey2") as Any,
            .font: UIFont(name: "Inter-Medium", size: 12)!
        ])
        return textField
    }()
    
    private lazy var titleJenisKelamin = ReuseableLabel(labelText: "Apa jenis kelaminnya?", labelType: .titleH3, labelColor: .black)
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "grey3")
        
        navigationItem.titleView = ReuseableLabel(labelText: "Tambah Hewan", labelType: .titleH2, labelColor: .black)
        
        view.addSubview(hewanKucing)
        hewanKucing.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hewanKucing.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    
}
