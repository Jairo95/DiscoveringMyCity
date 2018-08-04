//
//  Place.swift
//  DiscoveringMyCity
//
//  Created by JAIRO PROAÑO on 19/7/18.
//  Copyright © 2018 Optativa Profesional. All rights reserved.
//

import Foundation
import RealmSwift

class Place: Object {
    @objc dynamic var placeId: String?
    @objc dynamic var name: String?
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var category: String?
    @objc dynamic var image: String?
    
    override static func primaryKey() -> String? {
        return "placeId"
    }
}

struct CallResponseAPI: Decodable {
    let results: [PlaceAPI]!
}

struct PlaceAPI: Decodable {
    
    let name: String!
    let icon: String!
    let vicinity: String!
    let geometry: GeometryAPI!
    
}

struct GeometryAPI: Decodable {
    let location: LocationAPI!
}

struct LocationAPI: Decodable {
    let lat: Double!
    let lng: Double!
}


