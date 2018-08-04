//
//  PlaceManager.swift
//  DiscoveringMyCity
//
//  Created by JAIRO PROAÑO on 19/7/18.
//  Copyright © 2018 Optativa Profesional. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
import AlamofireImage

class PlaceManager {
    var places:[Place] = []
    
    var realm:Realm
    
    init(){
        realm = try! Realm()
        print(realm.configuration.fileURL)
    }
    
    func addFavoritePlace(name: String?, latitud: Double?, longitud: Double?, categoria: String?, imagen: String?){
        
        print(name)
        
        let item = Place()
        item.placeId = "\(UUID())"
        item.name = name
        item.latitude = latitud!
        item.longitude = longitud!
        item.category = categoria
        item.image = imagen
        
        try! realm.write {
            realm.add(item)
        }
    }
    
    func updateArrays(){
        places = Array(realm.objects(Place.self))
    }
}


class SearcherPlacesManager {
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var radius: Int = 0
    var key: String = ""
    
    init(latitude: Double, longitude: Double, radius: Int, key: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.radius = radius
        self.key = key
    }
    
    
    func findNearbyPlaces(category: Category, completion: @escaping (CallResponseAPI)->()) {
        let urlApi = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=\(radius)&type=\(category.type)&keyword=\(category.keyWord)&key=\(key)"
        
        print("API: \(urlApi)")
        
        Alamofire.request(urlApi).responseJSON { (response) in
            guard let json = response.data else {
                print("Error response")
                return
            }
            
            guard let resultResponse = try? JSONDecoder().decode(CallResponseAPI.self, from: json) else {
                print("Error decoding")
                return
            }
        
            completion(resultResponse)
        }
    }
    
    
    func downloadImage(imageUrl: String, completion: @escaping (UIImage) -> ()) {
        Alamofire.request(imageUrl).responseImage { (response) in
            if let image: UIImage = response.result.value {
                completion(image)
            }
        }
    }
    
}
