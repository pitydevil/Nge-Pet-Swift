//
//  ModalSearchLocationViewModel.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 10/11/22.
//

import RxCocoa
import MapKit
import RxSwift

class ModalSearchLocationViewModel {
    
    //MARK: - OBJECT DECLARATION
    private var modalSearchLocationObject = BehaviorRelay<LocationDetail>(value: LocationDetail(longitude: 0.0, latitude: 0.0, locationName: ""))
    var searchResultsObject       = BehaviorRelay<MKLocalSearchCompletion>(value: MKLocalSearchCompletion())
    //MARK: - OBJECT OBSERVER DECLARATION
    var modalSearchObjectObserver: Observable<LocationDetail> {
        return modalSearchLocationObject.asObservable()
    }
    
    func getLocationObject() {
        let result =  searchResultsObject.value
        let searchRequest = MKLocalSearch.Request(completion: result)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let coordinate = response?.mapItems[0].placemark.coordinate else {
                return
            }
            guard let name = response?.mapItems[0].name else {
                return
            }
            self.modalSearchLocationObject.accept(LocationDetail(longitude: coordinate.longitude, latitude: coordinate.latitude, locationName: name))
        }
    }
}
