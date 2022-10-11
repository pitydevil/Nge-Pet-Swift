//
//  ViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 05/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    private var card:MonitoringCard = {
        let card = MonitoringCard(frame: (CGRect(x: 0, y: 0, width: 342, height: 432)), location: "Atlassian Pet Hotel Atlassian Pet Hotel", cardTitleString: "Kasih Makan Ya Makasih HHEHE", cardDescription: "Tolong kasih makan ya Tolong kasih makan ya Tolong kasih makan ya Tolong kasih makan ya Tolong kasih makan ya Tolong kasih makan ya Tolong kasih makan ya ", timeStamp: "8pm", dogNameString: "Blekki Irrrwhjfwej", petIconString: "pugIcon", newPost: false, carouselData: [CarouselData(image: UIImage(named: "slide1")), CarouselData(image: UIImage(named: "slide2")), CarouselData(image: UIImage(named: "slide3"))])
        return card
    }()

    private var carouselView: CarouselView?
    private var carouselData = [CarouselData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray2
        view.addSubview(card)
        card.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        card.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        card.widthAnchor.constraint(equalToConstant:342).isActive = true
        card.heightAnchor.constraint(greaterThanOrEqualToConstant: 432).isActive = true
//
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        carouselView?.configureView(with: carouselData)
        card.carouselView.configureView(with: [CarouselData(image: UIImage(named: "slide1")), CarouselData(image: UIImage(named: "slide2")), CarouselData(image: UIImage(named: "slide3"))])
    }
    
}
