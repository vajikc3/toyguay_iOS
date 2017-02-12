//
//  Toy+CoreDataProperties.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 12/2/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import Foundation
import CoreData


extension Toy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Toy> {
        return NSFetchRequest<Toy>(entityName: "Toy");
    }

    @NSManaged public var name: String?
    @NSManaged public var decriptionText: String?
    @NSManaged public var price: Float
    @NSManaged public var imageURL: String?
    @NSManaged public var userId: Int32
    @NSManaged public var toyCategories: NSSet?
    @NSManaged public var images: NSSet?
    @NSManaged public var transaction: Transaction?

}

// MARK: Generated accessors for toyCategories
extension Toy {

    @objc(addToyCategoriesObject:)
    @NSManaged public func addToToyCategories(_ value: ToyCategory)

    @objc(removeToyCategoriesObject:)
    @NSManaged public func removeFromToyCategories(_ value: ToyCategory)

    @objc(addToyCategories:)
    @NSManaged public func addToToyCategories(_ values: NSSet)

    @objc(removeToyCategories:)
    @NSManaged public func removeFromToyCategories(_ values: NSSet)

}

// MARK: Generated accessors for images
extension Toy {

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: Image)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: Image)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)

}
