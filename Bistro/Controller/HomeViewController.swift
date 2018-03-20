//
//  ViewController.swift
//  Bistro
//
//  Created by Joshua  Lee on 3/19/18.
//  Copyright © 2018 Joshua  Lee. All rights reserved.
//

import UIKit
import CDYelpFusionKit

class HomeViewController: UIViewController {

    let secret = yelpAPIKey
    var yelpAPIClient: CDYelpAPIClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yelpAPIClient = CDYelpAPIClient(apiKey: secret)
        
    }
    
}

