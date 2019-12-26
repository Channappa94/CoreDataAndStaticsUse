//
//  CoreDataSaticFile.swift
//  CoreDataAndStaticsUse
//
//  Created by IMCS2 on 12/24/19.
//  Copyright © 2019 com.phani. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class CorDataBase{
    
    static func saveData(_ nameAndNumber: CoreDataModel){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        let managerObjectConetext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Names", in: managerObjectConetext)!
        let pin = NSManagedObject(entity: entity, insertInto: managerObjectConetext)
        pin.setValue(nameAndNumber.name, forKey: "name")
        pin.setValue(nameAndNumber.number, forKey: "number")
        do{
            try managerObjectConetext.save()
        }catch let err as NSError{
            
        }
        
    }
    
    static func fetching() -> [CoreDataModel]{
        var fetchingData = [CoreDataModel]()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Names")
        do{
            let newPin : [NSManagedObject] = try (managedContext?.fetch(fetch))!
            for index in 0..<newPin.count{
                var placeAndNumber = CoreDataModel()
                placeAndNumber.name = (newPin[index].value(forKeyPath: "name") as? String)!
                placeAndNumber.number = (newPin[index].value(forKeyPath: "number") as? String)!
                fetchingData.append(placeAndNumber)
            }
        }catch{
        }
        return fetchingData
    }
    
    static func delete(_ nameAndNumber : CoreDataModel){
        guard  let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Names")
        //(name = %@):- name already exist inside core data as name. So this helps us to find a particular entry which we are about delete.
        fetch.predicate = NSPredicate(format:"(name = %@)" , nameAndNumber.name as CVarArg)
        do{
            let fetchtedResult = try managedContext.fetch(fetch) as! [NSManagedObject]
            for index in fetchtedResult{
                managedContext.delete(index)
                try managedContext.save()
            }
        }catch{
        }
    }
    
    static func update(_ nameAndNumber: CoreDataModel){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Names")
        fetch.predicate = NSPredicate(format: "(name = %@", nameAndNumber.name as CVarArg)
        do{
           let object = try managedContext.fetch(fetch)
            if object.count == 1{
                let objectUpdate = object.first as! NSManagedObject
                objectUpdate.setValue(nameAndNumber.name, forKey: "name")
            }
        }catch{

        }
    }

    
}
