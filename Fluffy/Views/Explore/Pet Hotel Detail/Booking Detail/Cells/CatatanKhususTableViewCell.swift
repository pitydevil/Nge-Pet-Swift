//
//  CatatanKhususTableViewCell.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 01/11/22.
//

import UIKit

class CatatanKhususTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let cellId = "CatatanKhususTableViewCell"
    
    private lazy var titleLbl = ReuseableLabel(labelText: "Catatan Khusus", labelType: .titleH2, labelColor: .black)
    
    private lazy var details = ReuseableLabel(labelText: "Tambah Catatan Khusus", labelType: .bodyP2, labelColor: .black)
    
    private lazy var chevronRight: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor(named: "black")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //MARK: - Setup Cell
        self.backgroundColor = UIColor(named: "grey3")
        self.selectionStyle = .none
        
        contentView.layer.cornerRadius = 8
        contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        contentView.layer.masksToBounds = false
        contentView.layer.shadowRadius = 4.0
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowColor = UIColor(named: "grey1")?.cgColor
        contentView.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        contentView.addSubview(titleLbl)
        contentView.addSubview(details)
        contentView.addSubview(chevronRight)
        
        //MARK: - Setup Constraint
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            details.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            details.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 4),
            details.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -40),
            chevronRight.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            chevronRight.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ orderDetailBody : OrderDetailBody){
        details.numberOfLines = 1
        if orderDetailBody.isExpanded {
            chevronRight.isHidden = false
            if orderDetailBody.customSOP.isEmpty {
                details.text =  "Tambah catatan khusus"
            }else {
                for order in orderDetailBody.customSOP {
                    details.text = "Catatan Khusus Anda: \(order.customSopName)..."
                    break
                }
            }
        }else {
            chevronRight.isHidden = true
            details.text = "Pilih hewan terlebih dahulu"
        }
    }
}
