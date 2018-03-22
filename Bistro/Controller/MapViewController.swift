//
//  ViewController.swift
//  Bistro
//
//  Created by Joshua  Lee on 3/19/18.
//  Copyright © 2018 Joshua  Lee. All rights reserved.
//

import UIKit
import CDYelpFusionKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchButtonOutlet: UIButton!
    
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D!
    
    let secret = yelpAPIKey
    var yelpAPIClient: CDYelpAPIClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Variable setups
        yelpAPIClient = CDYelpAPIClient(apiKey: secret)
        
        // Visual setups
        setUpView()
        
        // Delegates
        mapView.showsPointsOfInterest = false
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        if CLLocationManager.authorizationStatus() != .authorizedAlways
        {
            print("requesting permission")
            locationManager.requestAlwaysAuthorization()
        } else {
            print("getting location")
            locationManager.startUpdatingLocation()
        }
    }
    
    // Additional Setup
    func setUpView() {
        searchButtonOutlet.backgroundColor = UIColor.white
        searchButtonOutlet.layer.cornerRadius = 0.5 * searchButtonOutlet.bounds.size.width
        searchButtonOutlet.imageEdgeInsets = UIEdgeInsetsMake(8,8,8,8)
        searchButtonOutlet.clipsToBounds = true
    }
    
    @IBAction func searchButton(_ sender: Any) {
        yelpAPIClient.searchBusinesses(byTerm: "Food",
                                       location: nil,
                                       latitude: currentCoordinate.latitude,
                                       longitude: currentCoordinate.longitude,
                                       radius: 10000,
                                       categories: [.food],
                                       locale: nil,
                                       limit: 20,
                                       offset: 0,
                                       sortBy: .rating,
                                       priceTiers: [.oneDollarSign, .twoDollarSigns, .threeDollarSigns, .fourDollarSigns],
                                       openNow: true,
                                       openAt: nil,
                                       attributes: nil) { (response) in
                                        
                                       if let response = response,
                                           let businesses = response.businesses,
                                           businesses.count > 0 {
                                           print(businesses)
                                       }
        }
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        guard let currentLocation = locations.first else { return }
        currentCoordinate = currentLocation.coordinate
        mapView.userTrackingMode = .followWithHeading
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return MKOverlayRenderer()
    }
}





