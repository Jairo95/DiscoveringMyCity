//
//  PlaceManager.swift
//  DiscoveringMyCity
//
//  Created by JAIRO PROAÑO on 19/7/18.
//  Copyright © 2018 Optativa Profesional. All rights reserved.
//

import Foundation
import RealmSwift

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
        item.latitud = latitud!
        item.longitud = longitud!
        item.categoria = categoria
        item.imagen = imagen
        
        try! realm.write {
            realm.add(item)
        }
    }
    
    func updateArrays(){
        places = Array(realm.objects(Place.self))
    }
}
