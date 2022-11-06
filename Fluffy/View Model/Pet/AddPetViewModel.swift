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
   
    private var provider = BaseProviders()
    private var addPetErrorCaseObject = BehaviorRelay<addPetErrorCase>(value: .petBreedTidakAda())
        
    var addPetErrorObjectObserver : Observable<addPetErrorCase> {
        return addPetErrorCaseObject.asObservable()
    }
    
    init() {
        self.provider = { return BaseProviders()}()
        
    }
    
    func testFunction() {
        addPetErrorCaseObject.accept(.petTypeTidakAda())
    }
    
//    func addPet(_ petID : UUID, _ petAge : Int16?, _ petData: String?, _ petBreed : String?, _ petGender : String?,_ petName : String? ,_ petSize : String?,_ petType : String?, _ dateCreated : Date)-> Void ) {
//        if petData?.count != 0 && petBreed?.count != 0 && petGender?.count != 0 && petName?.count != 0 && petSize?.count != 0 && petType?.count != 0 {
////            provider.addPet(<#T##UUID#>, <#T##Int16#>, <#T##String#>, <#T##String#>, <#T##String#>, <#T##String#>, <#T##String#>, <#T##String#>, <#T##Date#>) { result in
////                <#code#>
////            }
//        }else {
//
//        }
//    }
    
}
