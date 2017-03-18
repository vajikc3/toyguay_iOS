//
//  File.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 17/3/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import Foundation

class ToyUploadable: Downloadable {
    var name: String?
    var description: String?
    var price: Float?
    var categories: [String]?
    
    override init() {
        
        super.init()
        
    }
    
    func postNewToy( taskCallback: @escaping (Bool,
        String?) -> ()) {
        
        let post_data: NSDictionary = NSMutableDictionary()
        
        post_data.setValue(name, forKey: "name")
        post_data.setValue(description, forKey: "description")
        post_data.setValue(price, forKey: "price")
        post_data.setValue(categories, forKey: "categories")
        
        var paramString = ""
 
//        for (key, value) in post_data{
//            paramString = paramString + (key as! String) + "=" + (value) + "&"
//        }
        
        if let url:URL = self.postToyURL() {
            var request: URLRequest = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 30)
            request.httpMethod = "POST"
            
            request.httpBody = try! JSONSerialization.data(withJSONObject: post_data, options: .prettyPrinted)
            
            self.execSecureTask(request: request)  { (finishDone, responseObject) in
                
                if finishDone == true {
                    print("toy uploaded")
                    taskCallback(true, nil)
                }else {
                    print("\(responseObject)")
                    taskCallback(false, nil)
                }
            }
        }else {
            taskCallback(false, nil)
        }
    }
    
    func setData(name: String, description: String, price: Float, categories: [String]){
        self.name = name
        self.description = description
        self.price = price
        self.categories = categories
    }
    
    
    private func postToyURL() -> URL? {
        let token: String = User.usuario?.token ?? ""
        print("token: \(token)")
        return URL(string:  Config.kBaseURL + "/api/v1/toys?token=" + token)
    }
    
}
