//
//  Notifications.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 27/3/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import Foundation



protocol NotificationName {
    var name: Notification.Name { get }
}

extension RawRepresentable where RawValue == String, Self: NotificationName {
    var name: Notification.Name {
        get {
            return Notification.Name(self.rawValue)
        }
    }
}

class MyClass {
    enum Notifications: String, NotificationName {
        case myNotification
    }
}
