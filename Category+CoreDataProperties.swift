//
//  Category+CoreDataProperties.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 12/2/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category");
    }

    @NSManaged public var name: String?
    @NSManaged public var toyCategories: NSSet?

}

// MARK: Generated accessors for toyCategories
extension Category {

    @objc(addToyCategoriesObject:)
    @NSManaged public func addToToyCategories(_ value: ToyCategory)

    @objc(removeToyCategoriesObject:)
    @NSManaged public func removeFromToyCategories(_ value: ToyCategory)

    @objc(addToyCategories:)
    @NSManaged public func addToToyCategories(_ values: NSSet)

    @objc(removeToyCategories:)
    @NSManaged public func removeFromToyCategories(_ values: NSSet)

}
