//
//  Toy+CoreDataClass.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 12/2/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import Foundation
import CoreData


public class Toy: NSManagedObject {
    
    static let entityName = "Toy"
    
    let sameOne = CoreDataStack.defaultStack(modelName: "toyguay_iOS")
    
    convenience init(name: String, descriptionText: String, imageURL: String, price: Float, userId: Int, inContext context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: Toy.entityName, in: context)
        if (Toy.exists(name, inContext: context) == false){
            self.init(entity: entity!, insertInto: context)
            self.name = name
            self.descriptionText = descriptionText
            self.imageURL = imageURL
            self.price = price
            self.userId = 0
        }
        else{
            self.init(entity: entity!, insertInto: nil)
        }

    }

}
extension Toy{
    static func exists(_ name: String, inContext context: NSManagedObjectContext?) -> Bool {
        let fr = NSFetchRequest<Toy>(entityName: Toy.entityName)
        fr.fetchLimit = 1
        fr.fetchBatchSize = 1
        fr.predicate = NSPredicate(format: "name CONTAINS [cd] %@", name)
        do{
            let result = try context?.fetch(fr)
            guard let resp = result else{
                return false
            }
            return ((resp.count)>0)
        } catch{
            return false;
        }
        
    }
}
