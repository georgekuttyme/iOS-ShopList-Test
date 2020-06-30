//
//  APIClient.swift
//  Shop-List
//
//  Created by Legends on 29/06/20.
//  Copyright © 2020 Legends. All rights reserved.
//

import Alamofire

internal protocol APIClient {

    func execute(route: APIRequest,
                 completionHandler: @escaping NetworkCompletionHandler)
}
