//
//  ModalMonitoringViewModel.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 12/11/22.
//

import RxCocoa
import RxSwift

class ModalSelectPetMonitoringViewModel {
    
    //MARK: - OBJECT DECLARATION
    private var monitoringEnumCaseModel    = BehaviorRelay<monitoringCase>(value: .empty)
    var monitoringStateSelectionEnumModel  = BehaviorRelay<stateSelectectionCase>(value: .kosong)
    var petFirstSelectionModelArray  = BehaviorRelay<[PetsSelection]>(value: [])
    var petSelectionModelArray  = BehaviorRelay<[PetsSelection]>(value: [])
    var petSelectedModelArray   = BehaviorRelay<[PetsSelection]>(value: [])
    var selectedIndexPetModel   = BehaviorRelay<Int>(value: -1)
    
    //MARK: - OBJECT OBSERVABLE DECLARATION
    var monitoringEnumCaseObserver : Observable<monitoringCase> {
        return monitoringEnumCaseModel.asObservable()
    }
    
    var monitoringStateEnumCaseObserver : Observable<stateSelectectionCase> {
        return monitoringStateSelectionEnumModel.asObservable()
    }
    
    var petFirstSelectionArrayObserver : Observable<[PetsSelection]> {
        return petFirstSelectionModelArray.asObservable()
    }
    
    var petSelectedArrayObserver : Observable<[PetsSelection]> {
        return petSelectedModelArray.asObservable()
    }
    
    //MARK: - Observer for Pet Type Value
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func checkMonitoringModalState() {
        if petSelectionModelArray.value.count != 0 {
            monitoringEnumCaseModel.accept(.terisi)
        }else {
            monitoringEnumCaseModel.accept(.empty)
        }
    }
    
    //MARK: - Observer for Pet Type Value
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func checkStateSelection() {
        if petSelectionModelArray.value.count == petSelectedModelArray.value.count {
            monitoringStateSelectionEnumModel.accept(.full)
        }else if petSelectedModelArray.value.count > 0  && petSelectedModelArray.value.count < petSelectionModelArray.value.count {
            monitoringStateSelectionEnumModel.accept(.parsial(jumlah: petSelectedModelArray.value.count))
        }else {
            monitoringStateSelectionEnumModel.accept(.kosong)
        }
    }
    
    //MARK: - Observer for Pet Type Value
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func selectAndDeselectAllPet() {
        var tempPetSelectionModelArray = petSelectionModelArray.value
        var tempPetSelectedModelArray  = petSelectedModelArray.value
        switch monitoringStateSelectionEnumModel.value {
            case .full:
                tempPetSelectionModelArray = tempPetSelectionModelArray.map { obj in
                    var pets = obj
                    pets.isChecked = false
                    return pets
                }
                tempPetSelectedModelArray.removeAll()
                monitoringStateSelectionEnumModel.accept(.kosong)
            case .kosong:
                tempPetSelectionModelArray = tempPetSelectionModelArray.map { obj in
                    var pets = obj
                    pets.isChecked = true
                    return pets
                }
                tempPetSelectedModelArray = tempPetSelectionModelArray
                monitoringStateSelectionEnumModel.accept(.full)
            case .parsial:
                tempPetSelectionModelArray = tempPetSelectionModelArray.map { obj in
                    var pets = obj
                    pets.isChecked = true
                    return pets
                }
                tempPetSelectedModelArray = tempPetSelectionModelArray
                monitoringStateSelectionEnumModel.accept(.full)
        }
        petSelectedModelArray.accept(tempPetSelectedModelArray)
        petFirstSelectionModelArray.accept(tempPetSelectionModelArray)
    }
    
    //MARK: - Observer for Pet Type Value
    /// Returns boolean true or false
    /// from the given components.
    /// - Parameters:
    ///     - allowedCharacter: character subset that's allowed to use on the textfield
    ///     - text: set of character/string that would like  to be checked.
    func didSelectResponse() {
        var tempPetSelectedModelArray  = petSelectedModelArray.value
        var tempPetSelectionModelArray = petSelectionModelArray.value

        if tempPetSelectionModelArray[selectedIndexPetModel.value].isChecked!  {
            tempPetSelectionModelArray[selectedIndexPetModel.value].isChecked = false
            let index = tempPetSelectedModelArray.firstIndex(where: { $0.petName == tempPetSelectionModelArray[selectedIndexPetModel.value].petName })
            tempPetSelectedModelArray.remove(at: index!)
        } else {
            tempPetSelectedModelArray.append(petSelectionModelArray.value[selectedIndexPetModel.value])
            tempPetSelectionModelArray[selectedIndexPetModel.value].isChecked = true
        }
        petSelectedModelArray.accept(tempPetSelectedModelArray)
        petFirstSelectionModelArray.accept(tempPetSelectionModelArray)
    }
}
