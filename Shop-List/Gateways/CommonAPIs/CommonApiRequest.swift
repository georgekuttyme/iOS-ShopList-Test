//
//  CommonApiRequest.swift
//  Shop-List
//
//  Created by Legends on 29/06/20.
//  Copyright © 2020 Legends. All rights reserved.
//

import UIKit
import Alamofire
class CommonApiRequest: APIRequest {

    override init() {
        super.init()
    }
    convenience init(path: String) {
           self.init()
           self.path = self.path ?? "" + path
       }
}
