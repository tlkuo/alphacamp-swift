//
//  ACConfig.swift
//  alphacamp-swift
//
//  Created by martin on 2016/4/4.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import Foundation

class ACConfig {

    static let fireBaseUrlString: String = "https://alphacamp-frb.firebaseio.com"
    static let sharedConfig: ACConfig? = ACConfig()

    let apiKey: String
    let apiUrl: NSURL
    let loginUrl: NSURL
    let userUrl: NSURL
    let courseUrl: NSURL

    init?() {
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
            loginUrl    = NSURL(string: loginPathStr, relativeToURL: apiUrl),
            userPathStr = apiPathDic["User"] as? String,
            userUrl    = NSURL(string: userPathStr, relativeToURL: apiUrl),
            coursePathStr = apiPathDic["Course"] as? String,
            courseUrl    = NSURL(string: coursePathStr, relativeToURL: apiUrl)
        else {
            print("Dojo.plist: error")
            return nil
        }

        self.apiKey = apiKeyStr
        self.apiUrl = apiUrl
        self.loginUrl = loginUrl
        self.userUrl = userUrl
        self.courseUrl = courseUrl
    }
}
