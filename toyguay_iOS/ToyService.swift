//
//  ToyService.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 11/3/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import Foundation

class ToyService: NSObject {
    
    func getToys(taskCallback: @escaping (ServiceStatus,
        [ToyData]?) -> ()) {
        
        let downloable:ToysDownloadable = ToysDownloadable()
        
        downloable.getToys { (endDone, toys) in
            
            var status:ServiceStatus
            if endDone == true {
                
                status = ServiceStatus(status: Status.done, description: "")
                DispatchQueue.main.async {
                    taskCallback(status,toys)
                }
            }else {
                
                if toys == nil {
                    //Error al obtener datos
                    status = ServiceStatus(status: Status.genericError, description: "No se han podido obtener los datos del servidor")
                    DispatchQueue.main.async {
                        taskCallback(status,nil)
                    }
                    
                }else {
                    //No hay elementos
                    status = ServiceStatus(status: Status.done, description: "No hay datos en el servidor")
                    DispatchQueue.main.async {
                        taskCallback(status,[])
                    }
                }
                
            }
            
        }
    }
}
