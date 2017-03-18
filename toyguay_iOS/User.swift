//
//  User.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 14/3/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import Foundation

class User {

    static var usuario: User?
    
    static func loggedUser() -> User? {
        return User.usuario
    }

    
    var nombre: String?
    var token: String?
    
}
