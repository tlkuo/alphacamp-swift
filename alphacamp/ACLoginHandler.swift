//
//  ACLoginHandler.swift
//  alphacamp-swift
//
//  Created by martin on 2016/3/21.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import Foundation
import UIKit

protocol ACLoginDelegate: class {
    func loginSuccess(token: String)
    func loginFail(message: String)
}

class ACLoginHandler {

    let apiKey: String
    let apiUrl: NSURL
    let loginUrl: NSURL
    
    weak var delegate: ACLoginDelegate?
    
    init?(delegate: ACLoginDelegate) {

        guard let bundlePath = NSBundle.mainBundle().pathForResource("Dojo", ofType: "plist"),
            dojoDic     = NSDictionary(contentsOfFile: bundlePath),
            // API
            apiDic      = dojoDic["API"] as? [String: AnyObject],
            apiKeyStr   = apiDic["Key"] as? String,
            apiUrlStr   = apiDic["URL"] as? String,
            apiUrl      = NSURL(string: apiUrlStr),
            // PATH
            apiPathDic  = apiDic["Path"] as? [String: AnyObject],
            loginPathStr = apiPathDic["Login"] as? String,
            loginUrl    = NSURL(string: loginPathStr, relativeToURL: apiUrl)
        else {
            return nil
        }

        self.apiKey = apiKeyStr
        self.apiUrl = apiUrl
        self.loginUrl = loginUrl
        self.delegate = delegate
    }

    func login(email: String, password: String) {

        let request = NSMutableURLRequest(URL: loginUrl)

        request.HTTPMethod = "POST"
        request.HTTPBody = "email=\(email)&password=\(password)&api_key=\(apiKey)".dataUsingEncoding(NSUTF8StringEncoding)

        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {
            (let data, let response, let error) -> Void in

            let httpResponse = response as? NSHTTPURLResponse
            var jsonResponse = [String:AnyObject]()
            
            if let jsonData = data, jsonObj = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers),
                jsonDic = jsonObj as? [String:AnyObject] {
                jsonResponse = jsonDic
            }

            guard httpResponse?.statusCode == 200 else {

                if let message = jsonResponse["message"] as? String {
                    self.delegate?.loginFail("message: \(message)")
                }
                else if let statusCode = httpResponse?.statusCode {
                    self.delegate?.loginFail("statusCode: \(statusCode)")
                }
                else {
                    self.delegate?.loginFail("statusCode: unknown")
                }

                return
            }

            // {"auth_token":"c569587503a78250e2e58126940357ba096a755e","message":"Ok","user_id":239}

            guard let token = jsonResponse["auth_token"] as? String else {
                self.delegate?.loginFail("auth_token: unknown")
                return
            }

            self.delegate?.loginSuccess(token)
        })

        task.resume()
    }
}
