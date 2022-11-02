//
//  CatatanTableViewCell.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 02/11/22.
//

import UIKit

class CatatanTableViewCell: UITableViewCell {

    static let identifier = "CatatanTableViewCell"
    
    private lazy var catatanKhusus: UITextField = {
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //MARK: - Setup Cell
        self.backgroundColor = UIColor(named: "white")
        self.selectionStyle = .none
        
        //MARK: - Add Subview
        contentView.addSubview(catatanKhusus)
        
        //MARK: - Setup Constraint
        NSLayoutConstraint.activate([
            catatanKhusus.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            catatanKhusus.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            catatanKhusus.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            catatanKhusus.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            catatanKhusus.heightAnchor.constraint(equalToConstant: 38),
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
extension CatatanTableViewCell {
    public func configure() {
        
    }
}

extension CatatanTableViewCell: UITextFieldDelegate {
    
    //Dismiss Keyboard When Click Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentView.endEditing(true)
        return false
    }
}

