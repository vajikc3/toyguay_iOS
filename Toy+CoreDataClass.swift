//
//  Toy+CoreDataClass.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 20/3/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import Foundation
import CoreData


public class Toy: NSManagedObject {
    static let entityName = "Toy"
    
    let sameOne = CoreDataStack.defaultStack(modelName: "toyguay_iOS")
    
    
    convenience init(id: String, name: String, descriptionText: String, imageURL: String, price: Float, userId: String, createdDate: Date, latitude: Double, longitude: Double, state: String, username: String, inContext context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: Toy.entityName, in: context)
        if (Toy.exists(name, inContext: context) == false){
            self.init(entity: entity!, insertInto: context)
            self.id = id
            self.name = name
            self.descriptionText = descriptionText
            self.imageURL = imageURL
            self.price = price
            self.userId = userId
            self.createdDate = createdDate as NSDate?
            self.latitude = latitude
            self.longitude = longitude
            self.state = state
            self.username = username
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
