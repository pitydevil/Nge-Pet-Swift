//
//  FasilitasTableViewCell.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 25/10/22.
//

import UIKit

class FasilitasTableViewCell: UITableViewCell {
    //MARK: SubViews
    private lazy var icon:UIImageView = {
       let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var descriptionLabel:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "", labelType: .bodyP1, labelColor: .grey1)
        return label
    }()
    
    private lazy var additional:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "*", labelType: .bodyP1, labelColor: .primaryMain)
        return label
    }()
    
    //MARK: Properties
    static let cellId = "FasilitasTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(icon)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(additional)
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
    }
    

}

//MARK: Setups
extension FasilitasTableViewCell{
    func setupConstraint(){
        icon.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        icon.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 12).isActive = true
//        descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        additional.leftAnchor.constraint(equalTo: descriptionLabel.rightAnchor).isActive = true
        additional.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor).isActive = true
        additional.topAnchor.constraint(equalTo:descriptionLabel.topAnchor).isActive = true
    }
}

// MARK: - Public
extension FasilitasTableViewCell {
    func configure(_ fasilitas : Fasilitas) {
        
        descriptionLabel.text = fasilitas.fasilitasName
        additional.text       = ""
        icon.image = UIImage(named: "material-symbols_assured-workload-rounded")!
          
//        if add{
//            additional.text = "*"
//        }else{
//            additional.text = ""
//        }
    }
}
