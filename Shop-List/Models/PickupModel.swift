//
//  PickupModel.swift
//  Shop-List
//
//  Created by Legends on 29/06/20.
//  Copyright © 2020 Legends. All rights reserved.
//

import Foundation

class PickupModel: NSObject, Codable, NSCoding {
    let pickup:[PickupDetails]?
    enum CodingKeys: String, CodingKey {
        case pickup
    }
    func encode(with coder: NSCoder) {
        coder.encode(self.pickup, forKey: "pickup")
    }
    
    required init?(coder: NSCoder) {
        self.pickup = coder.decodeObject(forKey: "pickup") as? [PickupDetails]
    }
}

class PickupDetails: NSObject, Codable, NSCoding {

    var locationId: Int?
    var name: String?
    var address: String?
    var city: String?
    var active: Bool?
    var latitude: Double?
    var longitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case locationId = "id_pickup_location"
        case name = "alias"
        case address = "address1"
        case city,active,latitude,longitude
    }

    override init() {
    }
    required init?(coder aDecoder: NSCoder) {
    self.locationId = aDecoder.decodeObject(forKey: "id_pickup_location") as? Int
    self.name = aDecoder.decodeObject(forKey: "alias") as? String
    self.address = aDecoder.decodeObject(forKey: "address1") as? String
    self.city = aDecoder.decodeObject(forKey: "city") as? String
    self.active = aDecoder.decodeObject(forKey: "active") as? Bool
    self.latitude = aDecoder.decodeObject(forKey: "latitude") as? Double
    self.longitude = aDecoder.decodeObject(forKey: "longitude") as? Double
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.locationId, forKey: "id_pickup_location")
        aCoder.encode(self.name, forKey: "alias")
        aCoder.encode(self.address, forKey: "address1")
        aCoder.encode(self.city, forKey: "city")
        aCoder.encode(self.active, forKey: "active")
        aCoder.encode(self.latitude, forKey: "latitude")
        aCoder.encode(self.longitude, forKey: "longitude")
    }
}

struct ShopPickupDetails {
    var name: String?
    var address: String?
    var city: String?
    var active: Bool?
    var distance: Double?
}
