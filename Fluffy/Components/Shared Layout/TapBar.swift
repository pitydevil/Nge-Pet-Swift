//
//  TapBar.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 17/10/22.
//

import UIKit

class TapBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        tabBar.tintColor = UIColor(named: "primaryMain")
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor(named: "grey1")
        
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 5
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBar.layer.borderWidth = 0
        self.tabBar.clipsToBounds = false
        self.tabBar.backgroundColor = UIColor.white
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
        if #available(iOS
                      15.0, *) {
                UITabBar.appearance().standardAppearance = tabBarAppearance
        }
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        setupVCs()
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = NavController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
    
    func setupVCs() {
        if #available(iOS 16.0, *) {
            viewControllers = [
                createNavController(for: ExploreViewController(), title: NSLocalizedString("Jelajahi", comment: ""), image: UIImage(systemName: "magnifyingglass")!),
                createNavController(for: MonitoringViewController(), title: NSLocalizedString("Monitoring", comment: ""), image: UIImage(systemName: "display")!),
                createNavController(for: PetViewController(), title: NSLocalizedString("Peliharaan", comment: ""), image: UIImage(systemName: "pawprint.fill")!),
                createNavController(for: BookingViewController(), title: NSLocalizedString("Pesanan", comment: ""), image: UIImage(systemName: "doc.text.fill")!)
            ]
        } else {
            // Fallback on earlier versions
        }
    }
}
