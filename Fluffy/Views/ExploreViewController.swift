//
//  ExploreViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 17/10/22.
//

import UIKit

@available(iOS 16.0, *)
class ExploreViewController: UITabBarController {
    
    private lazy var toModal: ReusableButton = {
        let toModal = ReusableButton(titleBtn: "toModal", styleBtn: .disabled)
        toModal.addTarget(self, action: #selector(modalShow), for: .touchUpInside)
        return toModal
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(toModal)
        toModal.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        toModal.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func modalShow() {
        let vc = ModalCheckInOutViewController()
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true)
    }

}
