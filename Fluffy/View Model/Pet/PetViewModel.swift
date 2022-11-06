//
//  PetViewModel.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 04/11/22.
//

import RxSwift
import RxCocoa

class PetViewModel {
    
    private var provider = BaseProviders()
    
    private var petArray: Observable<[Pets]>?
    private let petModelArray = BehaviorRelay<[Pets]>(value: [])
    var petModelArrayObserver: Observable<[Pets]> {
        return petModelArray.asObservable()
    }

    init() {
        self.provider = { return BaseProviders()}()
    }

    func getAllPet() {
        petArray = provider.callDatabase()
        petArray?.subscribe(onNext: { (value) in
            var petModel = [Pets]()
            for pet in value {
                petModel.append(pet)
            }
            self.petModelArray.accept(petModel)
        }, onError: { (error) in
            _ = self.petModelArrayObserver.catchError { (error) in
                Observable.empty()
            }
        }).disposed(by: bags)
    }
}
