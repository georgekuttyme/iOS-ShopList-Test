//
//  CommonApiGateway.swift
//  Shop-List
//
//  Created by Legends on 29/06/20.
//  Copyright © 2020 Legends. All rights reserved.
//

import UIKit

private let pickupLocations     = "pickup-locations/"

protocol CommonApiGateway {
    func getPickupLocation(completionHandler: @escaping (_ response: Any?) -> Void)
}

class CommonApiGateWayImplementation: CommonApiGateway {
    
    func getPickupLocation(completionHandler: @escaping (Any?) -> Void) {
        let apiGateway = APIClientImplementation()
            let urlPath = pickupLocations
            let request = APIRequest(path: urlPath, params: nil)
            apiGateway.execute(route: request) { (response) in
                if response.error != nil {
                    completionHandler(nil)
                } else {
                    do {
                        let decoder = Foundation.JSONDecoder()
                        let decodedData = try decoder.decode(PickupModel.self, from: response.data!)
                        completionHandler(decodedData)
                    } catch {
                        completionHandler(nil)
                    }
                }
            }
    }
}
