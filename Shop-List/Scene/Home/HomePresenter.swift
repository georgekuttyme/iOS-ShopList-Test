//
//  HomePresenter.swift
//  Shop-List
//
//  Created by Legends on 27/06/20.
//  Copyright © 2020 Legends. All rights reserved.
//

///      Managing Home view business Logics on Home presenter class
import UIKit

class HomePresenter: NSObject {
    weak var delegate: BasePresenterDelegate?
    var pickupList: [ShopPickupDetails] = [] {
        didSet {
            self.delegate?.updateView()
        }
    }
///    Returing the number of Rows for the tableview section
    func numberOfRows(in section: Int) -> Int {
        return pickupList.count
    }
///    Returing the height of Rows for the tableview section
    func getRawHeight() -> CGFloat {
        return 100
    }
///    Returing the data on the each section
    func getShopDetails(at indexPath: IndexPath) -> ShopPickupDetails? {
        if pickupList.count > indexPath.row {
            return self.pickupList[indexPath.row]
        }
        return nil
    }
///    Sorting the data on the list array based on the shortest distance
    func filterListByShortestDistance() {
        self.pickupList = pickupList.sorted(by: { Int ($0.distance?.rounded() ?? 0) > Int ($1.distance?.rounded() ?? 0) })
    }
///    Sorting the data on the list array based on the active/Inactive pickup points
    func filterListByActiveLocations(isActive: Bool) {
        self.pickupList = pickupList.filter { $0.active == isActive }
    }
    ///  Select/unselect a value from list
    func didSelectTableViewCell(at indexPath: IndexPath) {
        var selectedData = self.pickupList[indexPath.row]
        selectedData.didSelected = !(selectedData.didSelected ?? false)
        self.pickupList[indexPath.row] = selectedData
    }
}

extension HomePresenter {
///    fetch Details from API
    func fetchPickupLocation() {
        self.delegate?.showProgressView()
        let apiGateway = CommonApiGateWayImplementation()
        apiGateway.getPickupLocation { (response) in
            guard let pickupList = response else {
                self.delegate?.hideProgressView()
                self.delegate?.didFailAPICall()
                return
            }
            if let pickupList = pickupList as? PickupModel {
                self.pickupList = self.setupData(pickupDetails: pickupList.pickup) ?? []
                self.delegate?.hideProgressView()
            }
        }
    }
///    configuring the Data for Loading on TableView
///    Calculating the distance of the coordinates and adding to Array
    func setupData(pickupDetails: [PickupDetails]?) -> [ShopPickupDetails]? {
        var shopPickupList : [ShopPickupDetails] = []
        for details in pickupDetails ?? [] {
            let userLocation = LocationManager.shared.getUsersLocationCordinators()
            let shopCoordinates = LocationManager.shared.getLocationFromCoordinates(latitude: details.latitude, longitude: details.longitude)
            let distanceInKM = LocationManager.shared.getDistanceByTwoCordinators(firstPoint: userLocation, secondPoint: shopCoordinates)
            let locationDetails = ShopPickupDetails(name: details.name, address: details.address, city: details.city, active: details.active, distance: distanceInKM?.rounded())
            shopPickupList.append(locationDetails)
        }
        return shopPickupList
    }
}
