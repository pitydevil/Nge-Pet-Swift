//
//  PetViewModel.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 04/11/22.
//

import RxSwift
import RxCocoa

class PetViewModel {
    
    //MARK: - Object Declaration
    private var provider = BaseProviders()
    private var petArray: Observable<[Pets]>?
    private var removeErrorCaseObject = BehaviorRelay<removePetErrorCase>(value: .gagalBuangPet())
    private let petModelArray = BehaviorRelay<[Pets]>(value: [])
    var uuidModelObject = BehaviorRelay<UUID>(value: UUID())
    
    //MARK: - Object Observer Declaration
    var petModelArrayObserver: Observable<[Pets]> {
        return petModelArray.asObservable()
    }
    
    var removeErrorCaseObserver: Observable<removePetErrorCase> {
        return removeErrorCaseObject.asObservable()
    }

    //MARK: - Init Object Declaration
    init() {
        self.provider = BaseProviders()
    }
    
    //MARK: - Init Object Declaration
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func deletePet() {
        provider.deletePet(uuidModelObject.value) { [self] result in
            switch result {
                case true:
                    removeErrorCaseObject.accept(.sukses())
                case false:
                    removeErrorCaseObject.accept(.gagalBuangPet())
            }
        }
    }
    
    //MARK: - Init Object Declaration
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
