//
//  Search+CoreDataProperties.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 12/2/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import Foundation
import CoreData


extension Search {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Search> {
        return NSFetchRequest<Search>(entityName: "Search");
    }

    @NSManaged public var idUser: Int32
    @NSManaged public var toyName: String?
    @NSManaged public var toyDescription: String?
    @NSManaged public var priceRange: String?
    @NSManaged public var radiusRange: String?
    @NSManaged public var category: String?

}
