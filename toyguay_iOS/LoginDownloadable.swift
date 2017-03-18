//
//  LoginDownloable.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 13/3/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import Foundation

class LoginDownloadable: Downloadable {
    
    var username: String?
    var password: String?
    
    override init() {
        
        super.init()
        
    }
    
    func postLogin( taskCallback: @escaping (Bool,
        String?) -> ()) {
        
        let post_data: NSDictionary = NSMutableDictionary()
        
        post_data.setValue(username, forKey: "user")
        post_data.setValue(password, forKey: "password")
        
        var paramString = ""
        
        for (key, value) in post_data{
            paramString = paramString + (key as! String) + "=" + (value as! String) + "&"
        }
        
        if let url:URL = self.postLoginURL() {
            var request: URLRequest = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 30)
            request.httpMethod = "POST"
            
            request.httpBody = paramString.data(using: String.Encoding.utf8)
            
            self.execSecureTask(request: request)  { (finishDone, responseObject) in
                
                if finishDone == true {
                    if let completeJSON:[String:Any?] = responseObject as? [String:Any?] {
                        if let token:String = completeJSON["token"] as? String {
                            print(token)
                            taskCallback(true, token)
                        }
                    }
                }else {
                    taskCallback(false, nil)
                }
            }
        }else {
            taskCallback(false, nil)
        }
    }
    
    func setData(username: String, password: String){
        self.username = username
        self.password = password
    }
    
    
    private func postLoginURL() -> URL? {
        return URL(string:  Config.kBaseURL + "/api/v1/users/authenticate")
    }
    
}

