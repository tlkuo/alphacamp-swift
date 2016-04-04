//
//  ACLoginHandler.swift
//  alphacamp-swift
//
//  Created by martin on 2016/3/21.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

protocol ACLoginDelegate: class {
    func loginSuccess(token: String)
    func loginFail(message: String)
}

class ACLoginHandler {
    
    weak var delegate: ACLoginDelegate?
    
    init(delegate: ACLoginDelegate) {
        self.delegate = delegate
    }

    func login(email: String, password: String) {

        guard let config = ACConfig.sharedConfig else {
            print("ACConfig: error")
            return
        }

        Alamofire
        .request(.POST, config.loginUrl, parameters: ["email": email, "password": password, "api_key": config.apiKey])
        .responseJSON { response in
            let httpResponse = response.response
            let jsonResponse = response.result.value

            guard httpResponse?.statusCode == 200 else {

                if let message = jsonResponse?["message"] as? String {
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

            guard let token = jsonResponse?["auth_token"] as? String else {
                self.delegate?.loginFail("auth_token: unknown")
                return
            }

            self.delegate?.loginSuccess(token)
        }
    }
}
