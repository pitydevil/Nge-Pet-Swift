//
//  AddPetViewModel.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 06/11/22.
//

import Foundation
import RxSwift
import RxCocoa

class AddPetViewModel {
   
    //MARK: - VARIABLE DECLARATION
    private var provider = BaseProviders()
    private var addPetErrorCaseObject = BehaviorRelay<addPetErrorCase>(value: .petBreedTidakAda())
    
    //MARK: - OBSERVABLE OBJECT DECLARATION
    var petsObject = BehaviorRelay<Pets>(value: Pets())
    var addPetErrorObjectObserver : Observable<addPetErrorCase> {
        return addPetErrorCaseObject.asObservable()
    }
    
    init() {
        self.provider = { return BaseProviders()}()
        
    }

    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func addPet() {
        if petsObject.value.petData?.count != 0 && petsObject.value.petBreed?.count != 0 && petsObject.value.petGender?.count != 0 && petsObject.value.petName?.count != 0 && petsObject.value.petSize?.count != 0 && petsObject.value.petType?.count != 0 && petsObject.value.petAge != nil {
            
            provider.addPet(petsObject.value.petID!, petsObject.value.petAge!,  petsObject.value.petData! ,petsObject.value.petBreed!,  petsObject.value.petGender!,  petsObject.value.petName!,  petsObject.value.petSize!,  petsObject.value.petType!, petsObject.value.dateCreated!) { [self] result in
                switch result {
                    case true:
                        addPetErrorCaseObject.accept(.sukses())
                    case false:
                        addPetErrorCaseObject.accept(.petAddGagal())
                }
            }
        }else {
            if petsObject.value.petAge == nil {
                addPetErrorCaseObject.accept(.petAgeTidakAda())
            }

            if petsObject.value.petData?.count == 0 {
                addPetErrorCaseObject.accept(.petIconTidakAda())
            }

            if petsObject.value.petBreed?.count == 0 {
                addPetErrorCaseObject.accept(.petBreedTidakAda())
            }

            if petsObject.value.petGender?.count == 0 {
                addPetErrorCaseObject.accept(.petGenderTidakAda())
            }
            if petsObject.value.petName?.count == 0 {
                addPetErrorCaseObject.accept(.petNameTidakAda())
            }
            if petsObject.value.petSize?.count == 0{
                addPetErrorCaseObject.accept(.petSizeTidakAda())
            }

            if petsObject.value.petType?.count == 0 {
                addPetErrorCaseObject.accept(.petTypeTidakAda())
            }
        }
    }
    
}
