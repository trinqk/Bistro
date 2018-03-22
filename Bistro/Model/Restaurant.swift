//
//  restaurantModel.swift
//  Bistro
//
//  Created by Joshua  Lee on 3/21/18.
//  Copyright © 2018 Joshua  Lee. All rights reserved.
//
import CDYelpFusionKit

class Restaurant {
    
    var id : String?
    var name : String?
    var imageUrl : URL?
    var price : String?
    var phone : String?
    var displayPhone: String?
    var photos : [String]?
    var hours: [CDYelpHour]?
    var rating : Double?
    var reviewCount : Int?
    var categories : [CDYelpCategory]?
    var distance : Double?
    var location : CDYelpLocation?
    
}
