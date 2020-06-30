//
//  LocationManager.swift
//  Shop-List
//
//  Created by Legends on 30/06/20.
//  Copyright © 2020 Legends. All rights reserved.
//

///  LocationManager- managing all the location related things

import UIKit
import CoreLocation

class LocationManager: NSObject {
    static let shared = LocationManager()
    var locationManager = CLLocationManager()
//      Initalizing location CLLocationManager
//      Loaction Fetcting only the using on the app forground and asking permission for acess location data
    func initLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
///    Fetching User location coordinates
    func getUsersLocationCordinators() -> CLLocationCoordinate2D? {
        return self.locationManager.location?.coordinate
    }
///    Generate a Location Coordinates from a latitude and longitude
    func getLocationFromCoordinates(latitude: Double?, longitude: Double?) -> CLLocationCoordinate2D? {
        return CLLocationCoordinate2DMake(latitude ?? 0.0, latitude ?? 0.0)
    }
///    Calculating Distance between two coordinates
///    Distance returing on Kilo meter
    func getDistanceByTwoCordinators(firstPoint: CLLocationCoordinate2D?, secondPoint: CLLocationCoordinate2D?) -> Double? {
        let firstCoordinate = CLLocation(latitude:firstPoint?.latitude ?? 0.0, longitude: firstPoint?.longitude ?? 0.0)
        let SecondCoordinate = CLLocation(latitude: secondPoint?.latitude ?? 0.0, longitude: secondPoint?.longitude ?? 0.0)
        let distanceInMeters = firstCoordinate.distance(from: SecondCoordinate)
        return distanceInMeters/1000
    }
}
///     CL Location Manager Delegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}
