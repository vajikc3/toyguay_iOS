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
    var price: String?
    var categories: String?
    var images: [String]?
    
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
 
        for (key, value) in post_data{
//            if let value = value as? [String] {
//                value.forEach({ (blobId: String) in
//                    paramString = paramString + (key as! String) + "=" + blobId + "&"
//                })
//            
//            }
//            else{
            paramString = paramString + (key as! String) + "=" + (value as! String) + "&"
         //   }
        }
        
        if let url:URL = self.postToyURL() {
            var request: URLRequest = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 30)
            request.httpMethod = "POST"
            
            request.httpBody = paramString.data(using: String.Encoding.utf8)
            
            self.execSecureTask(request: request)  { (finishDone, responseObject) in
                
                if finishDone == true {
                    
                    if let completeJSON:[String:Any?] = responseObject as? [String:Any?] {
                        if let json:[[String:Any?]] = completeJSON["toy"] as? [[String:Any?]] {
                            var toy:[ToyData] = [ToyData]()
                            print(toy)
                            for element: [String: Any?] in json{
                                for key in element.keys {
                                    if key == "_id", let toyId = element[key] {
                                        if (self.images?.count)! > 0 {
                                            self.postImage(toyId: toyId as! String)
                                        }
                                        taskCallback(true, toyId as! String)
                                    }
                                }
                            }
                        }else {
                            taskCallback(false, nil)
                        }
                    }
                    
                }else {
                    print("\(responseObject)")
                    taskCallback(false, nil)
                }
            }
        }else {
            taskCallback(false, nil)
        }
    }
    
    func setData(name: String, description: String, price: String, categories: String, images: [String]){
        self.name = name
        self.description = description
        self.price = price
        self.categories = categories
        self.images = images
    }
    
    
    private func postToyURL() -> URL? {
        let token: String = User.usuario?.token ?? ""
        print("token: \(token)")
        return URL(string:  Config.kBaseURL + "/api/v1/toys?token=" + token)
    }
    
    private func postImage(toyId: String) {
        let url = self.postToyURL()
        let paramString: String =  "url" + (images?[0])! + "&toyid=" + (toyId)
        var request: URLRequest = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 30)
        request.httpMethod = "POST"
        
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        self.execSecureTask(request: request)  { (finishDone, responseObject) in
            
            if finishDone == true {
                print("url subida")
                
//                if let completeJSON:[String:Any?] = responseObject as? [String:Any?] {
//                    if let json:[[String:Any?]] = completeJSON["toy"] as? [[String:Any?]] {
//                        var toy:[ToyData] = [ToyData]()
//                        print(toy)
//                        for element: [String: Any?] in json{
//                            for key in element.keys {
//                                if key == "_id", let toyId = element[key] {
//                                    if (self.images?.count)! > 0 {
//                                        self.postImage(toyId)
//                                    }
//                                    taskCallback(true, toyId as! String)
//                                }
//                            }
//                        }
//                    }else {
//                        taskCallback(false, nil)
//                    }
//                }
                
       
            }
        }
        
    }
    
}
