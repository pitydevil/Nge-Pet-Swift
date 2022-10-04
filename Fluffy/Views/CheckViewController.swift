//
//  CheckViewController.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 04/10/22.
//

import UIKit

class CheckViewController: UIViewController {

    private lazy var titlelabel: ReuseableLabel = {
        let label = ReuseableLabel(labelText: "Jessica", labelType: .titleH1, labelColor: .black)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemRed
        view.addSubview(titlelabel)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
