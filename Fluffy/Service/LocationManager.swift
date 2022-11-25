//
//  LocationManager.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 09/11/22.
//
import RxSwift
import RxCocoa
import CoreLocation

class LocationManager: CLLocationManager, CLLocationManagerDelegate  {
    
    //MARK: - OBJECT DECLARATION
    private let locationManager = CLLocationManager()
    var locationObject = BehaviorRelay<Location>(value: Location(longitude: 0.0, latitude: 0.0))
    var locationObjectObserver   : Observable<Location> {
        return locationObject.asObservable()
    }

    override init() {
        self.locationManager.requestWhenInUseAuthorization()
        super.init()
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
            }
        }
    }

    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = (manager.location?.coordinate)!
        locationObject.accept(Location(longitude: locValue.longitude, latitude: locValue.latitude))
    }
}
