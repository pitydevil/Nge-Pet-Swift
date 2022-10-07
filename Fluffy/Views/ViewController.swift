//
//  ViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 05/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    private var card:MonitoringCard = {
        let card = MonitoringCard(frame: (CGRect(x: 0, y: 0, width: 342, height: 432)), location: "Klaten", cardTitleString: "Jessica Pet Shop", cardDescription: "Tolong kasih makan ya kasih makan yakasih makan ya", timeStamp: "8m", dogNameString: "Miki", petIconString: "pugIcon", newPost: true, carouselData: [CarouselData(image: UIImage(named: "slide1")), CarouselData(image: UIImage(named: "slide2")), CarouselData(image: UIImage(named: "slide3"))])
        return card
    }()

    private var carouselView: CarouselView?
    private var carouselData = [CarouselData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        carouselView = CarouselView(pages: 3)
//        carouselData.append(CarouselData(image: UIImage(named: "slide1")))
//        carouselData.append(CarouselData(image: UIImage(named: "slide2")))
//        carouselData.append(CarouselData(image: UIImage(named: "slide3")))
//
//        carouselView?.configureView(with: carouselData)
//        carouselView?.backgroundColor = .brown
//        view.backgroundColor = .systemGray2
//        guard let carouselView = carouselView else { return }
//        view.addSubview(carouselView)
//        carouselView.translatesAutoresizingMaskIntoConstraints = false
//        carouselView.widthAnchor.constraint(equalToConstant: 302).isActive = true
//        carouselView.heightAnchor.constraint(equalToConstant: 314).isActive = true
//        carouselView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        carouselView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.backgroundColor = .systemGray2
        view.addSubview(card)
        card.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        card.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        card.widthAnchor.constraint(equalToConstant:342).isActive = true
        card.heightAnchor.constraint(greaterThanOrEqualToConstant: 432).isActive = true
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        carouselView?.configureView(with: carouselData)
    }
    
}
