//
//  Base Providers.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 03/10/22.
//

import CoreData
import RxCocoa
import RxSwift

class BaseProviders {
    //MARK: - OPEN CONTEXT PROVIDERS
    lazy var persistContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Fluffi")
        
        container.loadPersistentStores{ _, error in
            guard error == nil else {
                fatalError("Unresolved error \(String(describing: error))")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        
        return container
    }()
    
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistContainer.newBackgroundContext()
        taskContext.undoManager = nil
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
}

//MARK: - CRUD DATABASE FUNCTION
extension BaseProviders  {
    //MARK: - UPDATE EXISTING PET DATA BASED ON PETID ARGUMENTS
    func deletePet(_ petID : UUID, completion: @escaping(_ result: Bool)->Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pet")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "petID == %@", petID as CVarArg )
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    completion(true)
                }else {
                    completion(false)
                }
            }
        }
    }
    
    //MARK: - UPDATE EXISTING PET DATA BASED ON PETID ARGUMENTS
    func updateExisting(_ petID : UUID, _ petAge : Int16, _ petData: String, _ petBreed : String, _ petGender : String,_ petName : String ,_ petSize : String,_ petType : String, completion: @escaping(_ result: Bool) -> Void) {
        let taskContext = newTaskContext()
           
        if NSEntityDescription.entity(forEntityName: "Pet", in: taskContext) != nil {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pet")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "petID = %@", petID as CVarArg)
            
            if let results = try? taskContext.fetch(fetchRequest).first {
                var pet : Pet?
                pet = results as? Pet
                pet!.petAge = petAge
                pet!.petBreed = petBreed
                pet!.petData = petData
                pet!.petName = petName
                pet!.petSize = petSize
                pet!.petType = petType
                pet!.petGender = petGender
                do {
                    try taskContext.save()
                    completion(true)
                } catch let error as NSError {
                    completion(false)
                    print("Could not save: \(error.userInfo)")
                }
            }else {
                completion(false)
            }
        }
    }
    
    //MARK: - ADD PET to CORE DATA, with 7 arguments (REQUIRED)
    func addPet(_ petID : UUID, _ petAge : Int16, _ petData: String, _ petBreed : String, _ petGender : String,_ petName : String ,_ petSize : String,_ petType : String, _ dateCreated : Date ,completion: @escaping(_ result: Bool) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            if let entity = NSEntityDescription.entity(forEntityName: "Pet", in: taskContext) {
                let member = NSManagedObject(entity: entity, insertInto: taskContext)
                member.setValue(petID, forKeyPath: "petID")
                member.setValue(petAge, forKeyPath: "petAge")
                member.setValue(petData, forKeyPath: "petData")
                member.setValue(petBreed, forKeyPath: "petBreed")
                member.setValue(petGender, forKeyPath: "petGender")
                member.setValue(petName, forKeyPath: "petName")
                member.setValue(petSize, forKeyPath: "petSize")
                member.setValue(petType, forKeyPath: "petType")
                member.setValue(dateCreated, forKeyPath: "dateCreated")
                do {
                    try taskContext.save()
                    completion(true)
                } catch let error as NSError {
                    completion(false)
                    print("Could not save: \(error.userInfo)")
                }
            }
        }
    }
}

extension BaseProviders : DatabaseRequestProtocol {
    func callDatabase<T: Codable>() -> Observable<T>  {
        return Observable<T>.create { observer in
            let taskContext = self.newTaskContext()
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pet")
                do {
                    var petArray : [Pets] = []
                    let results = try taskContext.fetch(fetchRequest)
                    for pet in results {
                        let pet = Pets(petID: pet.value(forKey: "petID") as? UUID, petData: pet.value(forKey: "petData") as? String, petAge: pet.value(forKey: "petAge") as? Int16, petBreed: pet.value(forKey: "petBreed") as? String, petName: pet.value(forKey: "petName") as? String, petSize: pet.value(forKey: "petSize") as? String, petType: pet.value(forKey: "petType") as? String, petGender: pet.value(forKey: "petGender") as? String, dateCreated : pet.value(forKey: "dateCreated") as? Date)
                        petArray.append(pet)
                    }
                    observer.onNext(petArray as! T)
                } catch let error as NSError {
                    observer.onError(error)
                }
            }
            return Disposables.create {
            }
        }
    }
}
