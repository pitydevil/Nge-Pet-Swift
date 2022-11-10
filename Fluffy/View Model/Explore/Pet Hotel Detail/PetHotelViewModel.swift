//
//  PetHotelViewModel.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 10/11/22.
//

import Foundation
import RxCocoa
import RxSwift

struct PetHotelViewModel {
    //MARK: - OBJECT DECLARATION
    private let networkService       : NetworkServicing
    private var petHotelModel   = BehaviorRelay<PetHotelsDetail>(value: PetHotelsDetail(petHotelID: 0, petHotelName: "", petHotelDescription: "", petHotelLongitude: "", petHotelLatitude: "", petHotelAddress: "", petHotelKelurahan: "", petHotelKecamatan: "", petHotelKota: "", petHotelProvinsi: "", petHotelPos: "", petHotelStartPrice: "", supportedPet: [SupportedPet](), petHotelImage: [PetHotelImage](), fasilitas: [Fasilitas](), sopGeneral: [SopGeneral](), asuransi: [AsuransiDetail](), cancelSOP: [CancelSOP]()))
    var locationObject          = BehaviorRelay<Location>(value: Location(longitude: 0.0, latitude: 0.0))
    var petHotelID                   = BehaviorRelay<Int>(value: 0)
    
    //MARK: - OBSERVABLE OBJECT DECLARATION
    var petHotelModelArrayObserver   : Observable<PetHotelsDetail> {
        return petHotelModel.asObservable()
    }

    //MARK: - INIT OBJECT
    init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
    }
    
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func getCurrentPage(_ collectionView : UICollectionView, _ currentPage : Int) -> Int {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
        return currentPage
    }
    
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func openGoogleMap() {
        let lat = self.locationObject.value.latitude
        let long = self.locationObject.value.longitude
          if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
              if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(lat),\(long)&directionsmode=driving") {
                        UIApplication.shared.open(url, options: [:])
               }
          }else {
                if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lat),\(long)&directionsmode=driving") {
                    UIApplication.shared.open(urlDestination)
            }
        }
    }
    
    //MARK: - OBJECT DECLARATION
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func fetchPetHotelDetail() async {
        let endpoint = ApplicationEndpoint.getPetHotelDetail(petHotelID: petHotelID.value)
        let result = await networkService.request(to: endpoint, decodeTo: Response<PetHotelsDetail>.self)
        switch result {
        case .success(let response):
            if let petHotel = response.data {
                self.petHotelModel.accept(petHotel)
            }
        case .failure(let error):
            print(error)
        }
    }
}
