//
//  SelectPackageTableViewCell.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 01/11/22.
//

import UIKit

class SelectPackageTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let cellId = "SelectPackageTableViewCell"
    
    private lazy var hotelPackage = ReuseableLabel(labelText: "Paket Hotel", labelType: .titleH2, labelColor: .black)
    
    private lazy var details = ReuseableLabel(labelText: "Pilih Paket Hotel", labelType: .bodyP2, labelColor: .black)
    
    private lazy var chevronRight: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor(named: "black")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grey2")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //MARK: - Setup Cell
        self.backgroundColor = UIColor(named: "white")
        self.selectionStyle = .none
        
        contentView.layer.cornerRadius = 8
        
        contentView.addSubview(hotelPackage)
        contentView.addSubview(details)
        contentView.addSubview(chevronRight)
        contentView.addSubview(separator)
        
        //MARK: - Setup Constraint
        NSLayoutConstraint.activate([
            hotelPackage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            hotelPackage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            
            details.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            details.topAnchor.constraint(equalTo: hotelPackage.bottomAnchor, constant: 4),
            
            chevronRight.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            chevronRight.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            separator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//MARK: - Public
extension SelectPackageTableViewCell {
    public func configure(textDetails: String?){
        details.text = textDetails
    }
}

