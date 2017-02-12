//
//  Transaction+CoreDataProperties.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 12/2/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction");
    }

    @NSManaged public var idUser: Int32
    @NSManaged public var type: String?
    @NSManaged public var state: NSNumber?
    @NSManaged public var toy: Toy?

}
