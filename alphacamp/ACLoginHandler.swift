//
//  ACLoginHandler.swift
//  alphacamp-swift
//
//  Created by martin on 2016/3/21.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import Foundation
import UIKit

class ACLoginHandler {

    let API_KEY: String = "d7f2c2180a4f27dfb485f1574affa45ced56e0e6"
    let API_URL: NSURL? = NSURL(string: "https://dojo.alphacamp.co")
    lazy var LOGIN_URL: NSURL? = NSURL(string: "/api/v1/login", relativeToURL: self.API_URL)
    lazy var session: NSURLSession = NSURLSession.sharedSession()

    func login(email: String, password: String) {

        if let url = LOGIN_URL {

            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = "email=\(email)&password=\(password)&api_key=\(API_KEY)".dataUsingEncoding(NSUTF8StringEncoding)
            
            let task = session.dataTaskWithRequest(request, completionHandler: {
                (let data, let response, let error) -> Void in

                guard data != nil else {
                    return
                }

                if let jsonObj = try? NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers), json = jsonObj as? [String:AnyObject] {
                    print(json)
                }
            })
            
            task.resume()
        }
    }
}
