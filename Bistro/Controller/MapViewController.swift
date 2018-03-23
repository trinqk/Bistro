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
    
    let filterContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1).cgColor
        view.layer.borderWidth = 3.0
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D!
    
    let secret = yelpAPIKey
    var yelpAPIClient: CDYelpAPIClient!
    
    // Variables
    var filterOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Variable setups
        yelpAPIClient = CDYelpAPIClient(apiKey: secret)
        
        // Visual setups
        setUpButton()
        view.addSubview(filterContainerView)
        setUpFilterView()
        filterContainerView.isHidden = true
        
        // Delegates
        mapView.showsPointsOfInterest = false
        if CLLocationManager.authorizationStatus() != .authorizedAlways
        {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
    }
    
    
    
    @IBAction func searchButton(_ sender: Any) {
//        yelpAPIClient.searchBusinesses(byTerm: "Food",
//                                       location: nil,
//                                       latitude: currentCoordinate.latitude,
//                                       longitude: currentCoordinate.longitude,
//                                       radius: 10000,
//                                       categories: [.food],
//                                       locale: nil,
//                                       limit: 20,
//                                       offset: 0,
//                                       sortBy: .rating,
//                                       priceTiers: [.oneDollarSign, .twoDollarSigns, .threeDollarSigns, .fourDollarSigns],
//                                       openNow: true,
//                                       openAt: nil,
//                                       attributes: nil) { (response) in
//
//                                        if let responseArray = response,
//                                            let businesses = responseArray.businesses,
//                                            businesses.count > 0 {
//                                            for output in businesses {
//                                                print("\(String(describing: output.name))")
//                                            }
//                                        }
//        }
        
        if filterOn == false {
            filterContainerView.isHidden = false
            filterOn = true
        } else {
            filterContainerView.isHidden = true
            filterOn = false
        }
        
    }
    
    // MARK: VISUAL SETUPS
    // Additional Setup
    func setUpButton() {
        searchButtonOutlet.backgroundColor = UIColor.white
        searchButtonOutlet.layer.cornerRadius = 0.5 * searchButtonOutlet.bounds.size.width
        searchButtonOutlet.imageEdgeInsets = UIEdgeInsetsMake(8,8,8,8)
        searchButtonOutlet.clipsToBounds = true
    }
    
    func setUpFilterView() {
        filterContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        filterContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        filterContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        filterContainerView.heightAnchor.constraint(equalToConstant: 400).isActive = true
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





