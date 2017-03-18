//
//  ServiceStatus.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 11/3/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import Foundation

enum Status {
    case done
    case genericError
    case serverError
    case conectivityError
}

struct ServiceStatus {
    
    let status: Status
    let description: String
}
