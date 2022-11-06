//
//  EditPetViewModel.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 06/11/22.
//

import Foundation
import RxCocoa
import RxSwift

class EditPetViewModel {
   
    private var provider = BaseProviders()
    private var addPetErrorCaseObject = BehaviorRelay<addPetErrorCase>(value: .petBreedTidakAda())
    
    var selectedIndexObject = BehaviorRelay<Int>(value: -1)
    var petsObject = BehaviorRelay<Pets>(value: Pets())
    var addPetErrorObjectObserver : Observable<addPetErrorCase> {
        return addPetErrorCaseObject.asObservable()
    }
    
    init() {
        self.provider = { return BaseProviders()}()
    }
    
    //MARK: - Picker View Delegate and Datasource Function
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func calculateIndex(_ petIconDataObject : [String]) -> Int {
        let index = petIconDataObject.firstIndex { $0 == petsObject.value.petData!}
        return index!
    }
    
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func checkSelectedIndex(_ currIndex : Int) -> UIColor{
        if selectedIndexObject.value == currIndex {
            return UIColor(named: "primaryMain")!
        }else if selectedIndexObject.value == -1 {
            return UIColor(named: "white")!
        }else {
            return UIColor(named: "white")!
        }
    }
    
    //MARK: - Base Provider Function
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func updateExistingPet() {
        if petsObject.value.petData?.count != 0 && petsObject.value.petBreed?.count != 0 && petsObject.value.petGender?.count != 0 && petsObject.value.petName?.count != 0 && petsObject.value.petSize?.count != 0 && petsObject.value.petType?.count != 0 && petsObject.value.petAge != nil {
            provider.updateExisting(petsObject.value.petID!, petsObject.value.petAge!,  petsObject.value.petData! ,petsObject.value.petBreed!,  petsObject.value.petGender!,  petsObject.value.petName!,  petsObject.value.petSize!,  petsObject.value.petType!) { [self] result in
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
