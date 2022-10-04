//
//  CheckViewController.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 04/10/22.
//

import UIKit

class CheckViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        label.text = "My Font"
        view.addSubview(label)
        label.center = view.center
        label.textColor = .white
        label.font = UIFont(name: "Inter-Medium", size: 32)
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
