//
//  ToyCategory+CoreDataProperties.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 12/2/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import Foundation
import CoreData


extension ToyCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToyCategory> {
        return NSFetchRequest<ToyCategory>(entityName: "ToyCategory");
    }

    @NSManaged public var name: String?
    @NSManaged public var toy: Toy?
    @NSManaged public var category: Category?

}
