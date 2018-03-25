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
    
    let filterTabView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let filterTabViewLabel: UILabel = {
        let label = UILabel()
        label.text = "Bistro Filter"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont(name: "Helvetica Neue", size: 22.0)
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        label.textAlignment = .center
        return label
    }()

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchButtonOutlet: UIButton!
    @IBOutlet weak var searchRandomOutlet: UIButton!
    
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
        if filterOn == false {
            moveSearchButtonToCenter()
        }
    }
    
    @IBAction func confirmSearchButton(_ sender: Any) {
        print("hello")
    }
    
    
    // MARK: VISUAL SETUPS
    // Additional Setup
    func setUpButton() {
        searchButtonOutlet.backgroundColor = UIColor.white
        searchButtonOutlet.layer.cornerRadius = 0.5 * searchButtonOutlet.bounds.size.width
        searchButtonOutlet.layer.borderColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1).cgColor
        searchButtonOutlet.layer.borderWidth = 3.0
        searchButtonOutlet.imageEdgeInsets = UIEdgeInsetsMake(8,8,8,8)
        searchButtonOutlet.clipsToBounds = true
        
        searchRandomOutlet.backgroundColor = UIColor(red: 74/255, green: 255/255, blue: 171/255, alpha: 1.0)
        searchRandomOutlet.layer.cornerRadius = 0.5 * searchRandomOutlet.bounds.size.width
        searchRandomOutlet.layer.borderColor = UIColor.white.cgColor
        searchRandomOutlet.layer.borderWidth = 3.0
        searchRandomOutlet.imageEdgeInsets = UIEdgeInsetsMake(-8,-8,-8,-8)
        searchRandomOutlet.clipsToBounds = true
        searchRandomOutlet.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0 - view.center.x - searchRandomOutlet.frame.width).isActive = true
        searchRandomOutlet.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpFilterView() {
        filterContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        filterContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        filterContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        filterContainerView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        filterContainerView.addSubview(filterTabView)
        filterTabView.leadingAnchor.constraint(equalTo: filterContainerView.leadingAnchor).isActive = true
        filterTabView.topAnchor.constraint(equalTo: filterContainerView.topAnchor).isActive = true
        filterTabView.widthAnchor.constraint(equalTo: filterContainerView.widthAnchor).isActive = true
        filterTabView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        filterTabView.addSubview(closeButton)
        closeButton.trailingAnchor.constraint(equalTo: filterTabView.trailingAnchor, constant: -10).isActive = true
        closeButton.centerYAnchor.constraint(equalTo: filterTabView.centerYAnchor).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        closeButton.addTarget(self, action: #selector(moveSearchButtonToRight), for: .touchUpInside)
        
        filterTabView.addSubview(filterTabViewLabel)
        filterTabViewLabel.centerXAnchor.constraint(equalTo: filterTabView.centerXAnchor).isActive = true
        filterTabViewLabel.centerYAnchor.constraint(equalTo: filterTabView.centerYAnchor).isActive = true
        filterTabViewLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        filterTabViewLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    // MARK: ANIMATIONS
    func moveSearchButtonToCenter() {
        UIView.animate(withDuration: 0.5, animations: {
            self.searchButtonOutlet.center = CGPoint(x: self.view.frame.width + (self.searchButtonOutlet.frame.width / 2), y: self.searchButtonOutlet.center.y)
            self.searchRandomOutlet.center = CGPoint(x: self.view.center.x, y: self.searchRandomOutlet.center.y)
        })
        mapView.isUserInteractionEnabled = false
        filterContainerView.isHidden = false
        filterOn = true
    }
    
    @objc func moveSearchButtonToRight() {
        UIView.animate(withDuration: 0.5, animations: {
            self.searchButtonOutlet.center = CGPoint(x: self.view.frame.width - 16 - (self.searchButtonOutlet.frame.width / 2), y: self.searchButtonOutlet.center.y)
            self.searchRandomOutlet.center = CGPoint(x: 0 - (self.searchRandomOutlet.frame.width / 2), y: self.searchRandomOutlet.center.y)
        })
        mapView.isUserInteractionEnabled = true
        filterContainerView.isHidden = true
        filterOn = false
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



