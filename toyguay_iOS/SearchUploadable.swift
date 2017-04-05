//
//  SearchUploadable.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 20/3/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import Foundation

class SearchUploadable: Downloadable {
    var name: String?
    var description: String?
    var price: String?
    var categories: String?
    
    override init() {
        
        super.init()
        
    }
    
    func postNewToy( taskCallback: @escaping (Bool,
        String?) -> ()) {
        
        let post_data: NSDictionary = NSMutableDictionary()
        
        
        post_data.setValue(price, forKey: "price")
        post_data.setValue(categories, forKey: "categories")
        
        var paramString = ""
        
        for (key, value) in post_data{
            paramString = paramString + (key as! String) + "=" + (value as! String) + "&"
        }
        
        if let url:URL = self.postToyURL() {
            var request: URLRequest = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 30)
            request.httpMethod = "POST"
            
            request.httpBody = paramString.data(using: String.Encoding.utf8)
            
            self.execSecureTask(request: request)  { (finishDone, responseObject) in
                
                if finishDone == true {
                    print("toy uploaded")
                    taskCallback(true, nil)
                }else {
                    taskCallback(false, nil)
                }
            }
        }else {
            taskCallback(false, nil)
        }
    }
    
    func setData(name: String, description: String, price: String, categories: String){
        self.name = name
        self.description = description
        self.price = price
        self.categories = categories
    }
    
    
    private func postToyURL() -> URL? {
        let token: String = User.usuario?.token ?? ""
        print("token: \(token)")
        return URL(string:  Config.kBaseURL + "/api/v1/searches?token=" + token)
    }
    
}
