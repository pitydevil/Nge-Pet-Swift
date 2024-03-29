//
//  paketTableViewCell.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 28/10/22.
//

import UIKit

class paketTableViewCell: UITableViewCell {
    //MARK: SubViews
    private lazy var detailPaket:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "", labelType: .bodyP2, labelColor: .grey1)
        return label
    }()
    
    //MARK: Properties
    static let cellId = "paketTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(detailPaket)

        detailPaket.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        detailPaket.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        detailPaket.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        detailPaket.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

// MARK: - Public
extension paketTableViewCell {
    func configureView(_ customOrderDetail : CustomOrderDetail) {
        detailPaket.text = "\(customOrderDetail.petName) - Plus (\(customOrderDetail.customSOP.count))"
    }
    
    func configureOrderDetail(_ customOrderDetail : OrderDetail) {
        detailPaket.text = "\(customOrderDetail.petName) - Plus (\(customOrderDetail.customSopCount))"
    }
    
    func configureOrderDetail(_ customOrderDetail : OrderDetailBodyFinal) {
        detailPaket.text = "\(customOrderDetail.petName) - \(customOrderDetail.petType)"
    }
}
