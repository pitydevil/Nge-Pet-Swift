//
//  SelectBookingDetailsTableViewCell.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 15/11/22.
//

import UIKit

class SelectBookingDetailsTableViewCell: UITableViewCell {
    
    var delegate : SelectPetProtocol?
    
    //MARK: - IDENTIFIER
    static let identifier = "SelectBookingDetailsTableViewCell"
    
    //MARK: - SUBVIEWS
    private lazy var firstView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "poodle")
        icon.backgroundColor = UIColor(named: "white")
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.clipsToBounds = true
        return icon
    }()
    
    private lazy var petName = ReuseableLabel(labelText: "Bom Bom", labelType: .titleH2, labelColor: .black)
    private lazy var petSize = ReuseableLabel(labelText: "Anjing Sedang", labelType: .bodyP2, labelColor: .black)
    private lazy var petRace = ReuseableLabel(labelText: " - Poodle", labelType: .bodyP2, labelColor: .black)
    
   lazy var switchBtn: UISwitch = {
        let switchBtn = UISwitch()
        switchBtn.onTintColor = UIColor(named: "primaryMain")
        switchBtn.thumbTintColor = UIColor(named: "white")
        switchBtn.backgroundColor = UIColor(named: "grey2")
        switchBtn.layer.cornerRadius = 16
        switchBtn.layer.masksToBounds = true
        switchBtn.clipsToBounds = true
        switchBtn.translatesAutoresizingMaskIntoConstraints = false
        switchBtn.addTarget(self, action: #selector(responseSwitch), for: .valueChanged)
        return switchBtn
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grey2")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(named: "grey3")
        self.selectionStyle = .none
        
        //MARK: - Setup Content View
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = UIColor(named: "white")
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        contentView.layer.masksToBounds = false
        contentView.layer.shadowRadius = 4.0
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowColor = UIColor(named: "grey1")?.cgColor
        
        //MARK: - Add Subview
//        contentView.addSubview(firstView)
        
        contentView.addSubview(icon)
        contentView.addSubview(petName)
        contentView.addSubview(petSize)
        contentView.addSubview(petRace)
        contentView.addSubview(switchBtn)
        contentView.addSubview(separator)
        
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 48),
            icon.heightAnchor.constraint(equalToConstant: 48),
            
            petName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            petName.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 12),
            
            petSize.topAnchor.constraint(equalTo: petName.bottomAnchor, constant: 4),
            petSize.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 12),
            
            petRace.leadingAnchor.constraint(equalTo: petSize.trailingAnchor),
            petRace.topAnchor.constraint(equalTo: petName.bottomAnchor, constant: 4),
            
            switchBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            switchBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            separator.bottomAnchor.constraint(equalTo: (contentView.bottomAnchor)),
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.widthAnchor.constraint(equalToConstant: 300),
            separator.centerXAnchor.constraint(equalTo: (contentView.centerXAnchor)),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ pets: OrderDetailBody){
        icon.image = UIImage(named: pets.petData)
        petName.text = "\(pets.petName )"
        petSize.text = "\(pets.petSize )"
        petRace.text = " - \(pets.petType )"
    }
    
    @objc func responseSwitch(sender : UISwitch) {
        delegate?.selectPetProtocol(cell: self)
    }
}
