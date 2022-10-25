//
//  NavController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 21/10/22.
//

import UIKit

class NavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
//            navBarAppearance.backgroundColor =  UIColor(red:250.0/250.0, green:253.0/255.0, blue:255.0/255.0, alpha: 1.0)
            navigationBar.shadowImage = UIImage()
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.standardAppearance = navBarAppearance
            navigationBar.scrollEdgeAppearance = navBarAppearance
            navigationBar.backgroundColor = UIColor(named: "primaryMain")
            
        }
        
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationItem.leftBarButtonItem?.tintColor = UIColor.blue
    }


}
