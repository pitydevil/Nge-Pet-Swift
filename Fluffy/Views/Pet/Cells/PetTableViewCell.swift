//
//  PetTableViewCell.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 25/10/22.
//

import UIKit

class PetTableViewCell: UITableViewCell {

    static let cellId = "PetTableViewCell"
    
    private lazy var petIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(red: 0.82, green: 0.82, blue: 0.83, alpha: 1.00)
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private lazy var petRace = ReuseableLabel(labelText: "Poodle", labelType: .bodyP2, labelColor: .grey1)
    private lazy var petName = ReuseableLabel(labelText: "Bom Bom", labelType: .titleH2, labelColor: .black)
    private lazy var petSex = UIImageView()
    private lazy var tipeText = ReuseableLabel(labelText: "Tipe          :", labelType: .titleH3, labelColor: .grey1)
    private lazy var petType = ReuseableLabel(labelText: "Anjing Besar", labelType: .bodyP2, labelColor: .grey1)
    private lazy var umurText = ReuseableLabel(labelText: "Umur       :", labelType: .titleH3, labelColor: .grey1)
    private lazy var petAge = ReuseableLabel(labelText: " 2 Tahun", labelType: .bodyP2, labelColor: .grey1)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //MARK: - Setup Cell
        self.backgroundColor = UIColor(named: "grey3")
        self.selectionStyle = .none
        
        contentView.layer.masksToBounds = false
        contentView.layer.shadowRadius = 4.0
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        contentView.layer.cornerRadius = 12
        
        //MARK: - Setup Autoresizingmask false
        petIcon.translatesAutoresizingMaskIntoConstraints = false
        petRace.translatesAutoresizingMaskIntoConstraints = false
        petName.translatesAutoresizingMaskIntoConstraints = false
        petSex.translatesAutoresizingMaskIntoConstraints = false
        petType.translatesAutoresizingMaskIntoConstraints = false
        petAge.translatesAutoresizingMaskIntoConstraints = false
        tipeText.translatesAutoresizingMaskIntoConstraints = false
        umurText.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: - Add Subview
        contentView.addSubview(petIcon)
        contentView.addSubview(petRace)
        contentView.addSubview(petName)
        contentView.addSubview(petSex)
        contentView.addSubview(tipeText)
        contentView.addSubview(umurText)
        contentView.addSubview(petType)
        contentView.addSubview(petAge)
        
        //MARK: - Setup Constraint
        NSLayoutConstraint.activate([
            
            // petIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            // petIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            // petIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -222),
            petIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            petIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            petIcon.heightAnchor.constraint(equalToConstant: 104),
            petIcon.widthAnchor.constraint(equalToConstant: 104),
            
            petRace.leadingAnchor.constraint(equalTo: petIcon.trailingAnchor, constant: 12),
            petRace.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),

            petName.leadingAnchor.constraint(equalTo: petIcon.trailingAnchor, constant: 12),
            petName.topAnchor.constraint(equalTo: petRace.bottomAnchor, constant: 4),

            petSex.leadingAnchor.constraint(equalTo: petName.trailingAnchor, constant: 4),
            petSex.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            petSex.heightAnchor.constraint(equalToConstant: 12),
            petSex.widthAnchor.constraint(equalToConstant: 12),

            tipeText.leadingAnchor.constraint(equalTo: petIcon.trailingAnchor, constant: 12),
            tipeText.topAnchor.constraint(equalTo: petName.bottomAnchor, constant: 12),

            umurText.leadingAnchor.constraint(equalTo: petIcon.trailingAnchor, constant: 12),
            umurText.topAnchor.constraint(equalTo: tipeText.bottomAnchor, constant: 4),

            petType.leadingAnchor.constraint(equalTo: tipeText.trailingAnchor, constant: 8),
            petType.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 76),

            petAge.leadingAnchor.constraint(equalTo: umurText.trailingAnchor, constant: 8),
            petAge.topAnchor.constraint(equalTo: petType.bottomAnchor, constant: 5),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        contentView.frame = contentView.frame.inset(by: margins)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(_ pets : Pets){
        petIcon.image = UIImage(named: pets.petData!)
        petRace.text  = pets.petBreed!
        petName.text  = pets.petName!
        petSex.image  = UIImage(named: pets.petGender!)
        petType.text  = "\(pets.petType!) \(pets.petSize!)"
        petAge.text   = "\(String(Int(pets.petAge!))) Tahun"
    }
}
