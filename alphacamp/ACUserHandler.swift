//
//  ACUserHandler.swift
//  alphacamp-swift
//
//  Created by martin on 2016/4/4.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import Foundation
import Alamofire

protocol ACUserDelegate: class {
    func ACUserStatus(valid: Bool)
}

class ACUserHandler {
    weak var delegate: ACUserDelegate?
    
    init(delegate: ACUserDelegate) {
        self.delegate = delegate
    }

    func validate(auth_token: String) {

        guard let config = ACConfig.sharedConfig else {
            print("ACConfig: error")
            return
        }
        
        Alamofire
        .request(.GET, config.userUrl, parameters: ["api_key": config.apiKey, "auth_token": auth_token])
        .response { (request, response, data, error) in
            self.delegate?.ACUserStatus(response?.statusCode == 200)
        }
    }
}
