//
//  Constants.swift
//  Shop-List
//
//  Created by Legends on 29/06/20.
//  Copyright © 2020 Legends. All rights reserved.
//

import UIKit

let apiBaseURL = "https://api-staging.pmlo.co/v3/"

/// Provide Images for the application
struct Images {
    static let sortIcon = UIImage(named: "sort")
    static let activeIcon = UIImage(named: "active")
    static let inActiveIcon = UIImage(named: "inActive")
}
/// Provide cell identifiers for the application
struct CellIdentifier {
    static let HomeTableviewCellIdentifier = "ShopDetailsCell"
}
/// Provide constant texts used in the application
struct ConstantLabels {
    static let applicationTitle = "Shop List"
    static let sortTitle = "Sort the pickup points"
    static let distance  = "Shortest distance"
    static let activeLocation = "Active locations"
    static let inActiveLocation = "Inactive locations"
    static let resetFilter = "Reset filter"
    static let cancel  = "Cancel"
    static let alert = "Alert"
    static let noData = "No data available"
    static let apiFail = "Something went wrong. Please try again"
}
