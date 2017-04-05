//
//  Downloable.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 11/3/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import Foundation

struct Config {
    static let kBaseURL: String =  "http://toyguay.com"
    static let kTemporalHeaderAuthenticator: String = ""
}


class Downloadable {
    
    
    func execSecureTask(request: URLRequest, taskCallback: @escaping (Bool,
        AnyObject?) -> ()) {
        
        let localRequest: URLRequest = self.setLogedHeaders(inRequest: request)
        self.execTask(request: localRequest, taskCallback: taskCallback)
    }
    
    
    func execTask(request: URLRequest, taskCallback: @escaping (Bool,
        AnyObject?) -> ()) {
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let data = data {
                print(data)
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                    taskCallback(true, json as AnyObject?)
                } else {
                    taskCallback(false, json as AnyObject?)
                }
            }else {
                
                taskCallback(false, nil)
            }
        })
        task.resume()
    }
    
    private func setLogedHeaders(inRequest request: URLRequest) -> URLRequest {
        
        var localRequest: URLRequest = request
        localRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        return localRequest
    }
    
}
