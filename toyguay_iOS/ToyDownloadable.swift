//
//  ToyDownloable.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 11/3/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import Foundation

class ToysDownloadable: Downloadable {
    
    override init() {
        
        super.init()
        
    }
    
    func getToys( taskCallback: @escaping (Bool,
        [ToyData]?) -> ()) {

        if let url:URL = self.getToysURL() {
            var request: URLRequest = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 30)
            request.httpMethod = "GET"
            
            self.execSecureTask(request: request)  { (finishDone, responseObject) in
                
                if finishDone == true {
                    
                    if let completeJSON:[String:Any?] = responseObject as? [String:Any?] {
                        if let json:[[String:Any?]] = completeJSON["rows"] as? [[String:Any?]] {
                            var toys:[ToyData] = [ToyData]()
                            print(toys)
                            for element: [String: Any?] in json{
                                if let assetUnwrappd:ToyData = self.generateToyData(fromDictionary: element) as ToyData? {
                                    toys.append(assetUnwrappd)
                                }
                            }
                            taskCallback(true, toys)
                        }else {
                            taskCallback(false, nil)
                        }
                    }
                }else {
                    taskCallback(false, nil)
                }
            }
        }else {
            taskCallback(false, [])
        }
    }
    
    
    private func getToysURL() -> URL? {
        return URL(string:  Config.kBaseURL + "/api/v1/toys")
    }
    
    private func generateToyData(fromDictionary dictionary: [String: Any?]) -> ToyData? {
        let id: String? = self.fill(dictionary: dictionary, withKey: "_id")
        let name: String? = self.fill( dictionary: dictionary, withKey: "name")
        let description: String? = self.fill( dictionary: dictionary, withKey: "description")
        let price: Float? = self.fill( dictionary: dictionary, withKey: "price")
        let categories: [String]? = self.fill( dictionary: dictionary, withKey: "categories")
        var image: [String]? = self.fill(dictionary: dictionary, withKey: "imageURL")
        let user: [String: Any?]? = self.fill(dictionary: dictionary, withKey: "seller")
        let nickname: String? = self.fill(dictionary: user!, withKey: "nick_name")
        let userId: String? = self.fill(dictionary: user!, withKey: "_id")
        let _: String? = self.fill(dictionary: dictionary, withKey: "createdAt")
        let locationDict: [String: Any?]? = self.fill(dictionary: user!, withKey: "location")
        var location: [Double]? = [0.0, 0.0]
        
        if locationDict == nil {
            location = [0.0, 0.0]
        } else {
            location = self.fill(dictionary: locationDict!, withKey: "coordinates")
        }
        let state: String? = self.fill(dictionary: dictionary, withKey: "state")
        
        if image?.count == 0 {
            image?.append("https://upload.wikimedia.org/wikipedia/commons/thumb/8/8b/Juguetes-Tule-Oaxaca-Mexico.jpg/250px-Juguetes-Tule-Oaxaca-Mexico.jpg")
        }

        let currentToy:ToyData = ToyData(id: id, name: name, description: description, price: price, categories: categories, image: image, nickname: nickname, userId: userId, creationDate: Date(), location: location, state: state)

        return currentToy
    }
    
    private func fill<T>(dictionary: [String: Any?], withKey key:String) -> T? {
        
        guard let value: Any = dictionary[key] else {
            
            return nil
        }
        if let result: T = value as? T {
            
            return result
        } else if let result: [String: Any] = value as? [String: Any] {
            if let value: T = dictionary[key] as? T {
                return value
                
            }
        }
        return nil
    }
}
