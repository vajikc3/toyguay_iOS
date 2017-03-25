//
//  RegisterDownloable.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 15/3/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import Foundation

class RegisterDownloadable: Downloadable {
    
    var firstname: String?
    var lastname: String?
    var email: String?
    var username: String?
    var password: String?
    var rPassword: String?
    var latitude: String?
    var longitude: String?
    var city: String?
    var province: String?
    var country: String?
    
    override init() {
        
        super.init()
        
    }
    
    func postRegister(taskCallback: @escaping (Bool,
        String?) -> ()) {
        
        let post_data: NSDictionary = NSMutableDictionary()
        
        post_data.setValue(firstname, forKey: "first_name")
        post_data.setValue(lastname, forKey: "last_name")
        post_data.setValue(email, forKey: "email")
        post_data.setValue(username, forKey: "user")
        post_data.setValue(password, forKey: "password")
        post_data.setValue(rPassword, forKey: "password_repeat")
        post_data.setValue(latitude, forKey: "latitude")
        post_data.setValue(longitude, forKey: "longitude")
        post_data.setValue(city, forKey: "city")
        post_data.setValue(province, forKey: "province")
        post_data.setValue(country, forKey: "country")
        
        var paramString = ""
        
        for (key, value) in post_data{
            paramString = paramString + (key as! String) + "=" + (value as! String) + "&"
        }
        
        if let url:URL = self.postRegisterURL() {
            var request: URLRequest = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 30)
            request.httpMethod = "POST"
            
            request.httpBody = paramString.data(using: String.Encoding.utf8)
            
            self.execSecureTask(request: request)  { (finishDone, responseObject) in
                
                if finishDone == true {
                    print("register")
                    taskCallback(true, nil)
                }else {
                    if let completeJSON:[String:Any?] = responseObject as? [String:Any?] {
                        if let error:String = completeJSON["error"] as? String {
                            print(error)

                  
                            taskCallback(false, "\(error)")
                        }
                    }
                }
            }
            
            
        }else {
            taskCallback(false, nil)
        }
    }
    
    func setData(firstname: String,
                 lastname: String,
                 email: String,
                 username: String,
                 password: String,
                 rPassword: String,
                 latitude: String,
                 longitude: String,
                 city: String,
                 province: String,
                 country: String){
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.username = username
        self.password = password
        self.rPassword = rPassword
        self.latitude = latitude
        self.longitude = longitude
        self.city = city
        self.province = province
        self.country = country
    }
    
    
    private func postRegisterURL() -> URL? {
        return URL(string:  Config.kBaseURL + "/api/v1/users/register")
    }
    
}
