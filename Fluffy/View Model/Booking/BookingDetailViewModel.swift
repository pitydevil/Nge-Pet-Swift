//
//  BookingDetailViewModel.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 08/11/22.
//

import Foundation
import RxSwift
import RxCocoa

class BookingDetailViewModel {
    
    //MARK: - OBJECT DECLARATION
    private let networkService    : NetworkServicing
    private let orderModelArray   = BehaviorRelay<DetailedOrder>(value: DetailedOrder(orderID: 0, orderCode: "", orderDateCheckin: "", orderDateCheckout: "", orderTotalPrice: "", orderStatus: "", userID: "", petHotelID: "", createdAt: "", updatedAt: "", petHotel: PetHotel(petHotelID: 0, petHotelName: "", petHotelDescription: "", petHotelLongitude: "", petHotelLatitude: "", petHotelAddress: "", petHotelKelurahan: "", petHotelKecamatan: "", petHotelKota: "", petHotelProvinsi: "", petHotelPos: "", cancelSOP: [CancelSOP](), petHotelImage: [PetHotelImage]()), orderDetail: [CustomOrderDetail]()))
    private var genericHandlingErrorObject = BehaviorRelay<genericHandlingError>(value: .success)
    var orderDetailId = BehaviorRelay<Int>(value: 0)

    //MARK: - OBJECT OBSERVER DECLARATION
    var orderModelArrayObserver   : Observable<DetailedOrder> {
        return orderModelArray.asObservable()
    }
    
    var genericHandlingErrorObserver   : Observable<genericHandlingError> {
        return genericHandlingErrorObject.asObservable()
    }

    //MARK: - INIT OBJECT
    init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
    }
    
    //MARK: - OBJECT DECLARATION
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func fetchDetailOrder() async {
        let endpoint = ApplicationEndpoint.getDetailOrderID(orderID: orderDetailId.value)
        let result = await networkService.request(to: endpoint, decodeTo: Response<DetailedOrder>.self)
        switch result {
        case .success(let response):
            genericHandlingErrorObject.accept(genericHandlingError(rawValue: response.status ?? 500) ?? .unexpectedError)
            if let order = response.data {
                self.orderModelArray.accept(order)
            }
        case .failure(_):
            genericHandlingErrorObject.accept((genericHandlingError(rawValue: 500)!))
        }
    }
}
