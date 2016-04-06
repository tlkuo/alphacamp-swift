//
//  ACUserManager.swift
//  alphacamp-swift
//
//  Created by martin on 2016/4/4.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import Foundation
import Alamofire

protocol ACUserDelegate: class {
    func validateUserSuccess()
    func validateUserFail()
}

class ACUserManager {
    weak var delegate: ACUserDelegate?
    
    init(delegate: ACUserDelegate) {
        self.delegate = delegate
    }

    func validateUser(auth_token: String) {

        guard let config = ACConfig.sharedConfig else {
            print("ACConfig: error")
            return
        }
        
        Alamofire
        .request(.GET, config.userUrl, parameters: ["api_key": config.apiKey, "auth_token": auth_token])
        .response { (request, response, data, error) in
            if response?.statusCode == 200 {
                self.delegate?.validateUserSuccess()
            } else {
                self.delegate?.validateUserFail()
            }
        }
    }
}
