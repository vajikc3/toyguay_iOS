//
//  File.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 20/3/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import Foundation

class DeleteToy: Downloadable {
    
    var id: String?

    override init() {
        
        super.init()
        
    }
    
    func deleteToy( taskCallback: @escaping (Bool) -> ()) {
        
        if let url:URL = self.deleteToyURL() {
            var request: URLRequest = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 30)
            request.httpMethod = "DELETE"
            
            self.execSecureTask(request: request)  { (finishDone, responseObject) in
                
                if finishDone == true {
                    print("toy deleted")
                    taskCallback(true)
                }else {
                    print("\(responseObject)")
                    taskCallback(false)
                }
            }
        }else {
            taskCallback(false)
        }
    }
    
    func setToyToDelete(toy_id: String) {
        self.id = toy_id
    }
    
    private func deleteToyURL() -> URL? {
        let token: String = User.usuario?.token ?? ""
        return URL(string:  Config.kBaseURL + "/api/v1/toys/" + id! + "?token=" + token)
    }

}
