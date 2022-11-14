//
//  ModalSelectPetViewModal.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 10/11/22.
//

import Foundation
import RxSwift
import RxCocoa

class ModalSelectPetViewModel {
    
    //MARK: - Object Declaration
    private var provider = BaseProviders()
    private var petArray: Observable<[Pets]>?
    private let petModelArray = BehaviorRelay<[Pets]>(value: [])
    var petModelArrayObserver: Observable<[Pets]> {
        return petModelArray.asObservable()
    }
    
    init() {
        self.provider = { return BaseProviders()}()
    }
    
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func getAllPet() {
        petArray = provider.callDatabase()
        petArray?.subscribe(onNext: { (value) in
            var petModel = [Pets]()
            for pet in value {
                petModel.append(pet)
            }
            self.petModelArray.accept(petModel)
        }, onError: { (error) in
            _ = self.petModelArrayObserver.catch { (error) in
                Observable.empty()
            }
        }).disposed(by: bags)
    }
}
