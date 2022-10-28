//
//  HargaTableViewCell.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 28/10/22.
//

import UIKit

class HargaTableViewCell: UITableViewCell {
    //MARK: SubViews
    
    private lazy var detailHarga:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "", labelType: .bodyP2, labelColor: .grey1)
        return label
    }()
    
    private lazy var subtotal:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "", labelType: .bodyP2, labelColor: .grey1)
        label.textAlignment = .right
        return label
    }()
    
    //MARK: Properties
    static let cellId = "HargaTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(detailHarga)
        contentView.addSubview(subtotal)
        
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0))
    }
    

}

//MARK: Setups
extension HargaTableViewCell{
    func setupConstraint(){
        detailHarga.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        detailHarga.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        detailHarga.rightAnchor.constraint(greaterThanOrEqualTo: subtotal.leftAnchor, constant: -20).isActive = true
        detailHarga.widthAnchor.constraint(equalToConstant: 245).isActive = true
        
        subtotal.topAnchor.constraint(equalTo: detailHarga.topAnchor).isActive = true
        subtotal.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
    }
}

// MARK: - Public
extension HargaTableViewCell {
    func configureView(detailHargaString:String, description:String) {
        detailHarga.text = detailHargaString
        
        subtotal.text = description
    }
}
