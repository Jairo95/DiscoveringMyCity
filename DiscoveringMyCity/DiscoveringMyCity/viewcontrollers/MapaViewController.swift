//
//  MapaViewController.swift
//  DiscoveringMyCity
//
//  Created by Christian on 1/8/18.
//  Copyright © 2018 Optativa Profesional. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire

enum Location {
    case startLocation
    case destinationLocation
}

class MapaViewController: UIViewController , GMSMapViewDelegate {
    
    @IBOutlet weak var googleMaps: GMSMapView!
    
    
    var place: Place!
    var myPosition: Place!
    let placeManager = PlaceManager()

    
    override func viewDidLoad() {
  
        super.viewDidLoad()
        
        print("Lugar seleccionado: \(place), Mi posicion: \(myPosition)")
        
        //Your map initiation code
        let camera = GMSCameraPosition.camera(withLatitude: myPosition.latitude, longitude: myPosition.longitude, zoom: 15.0)
        
        self.googleMaps.camera = camera
        self.googleMaps.delegate = self
        self.googleMaps?.isMyLocationEnabled = true
        self.googleMaps.settings.myLocationButton = true
        self.googleMaps.settings.compassButton = true
        self.googleMaps.settings.zoomGestures = true
        
        self.drawPath(startLocation: myPosition, endLocation: place)
        
    }
    
    // MARK: function for create a marker pin on map
    func createMarker(titleMarker: String, iconMarker: UIImage, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.icon = iconMarker
        marker.map = googleMaps
    }
    
    @IBAction func addFavoriteButton(_ sender: Any) {
        /*let imageData:NSData = UIImagePNGRepresentation(imagenView.image!)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        //print(strBase64)
        */
        placeManager.addFavoritePlace(name: place.name, latitud: place.latitude, longitud: place.longitude, categoria: place.category, imagen: "")
    }
    
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("COORDINATE \(coordinate)") // when you tapped coordinate
    }
    

    func drawPath(startLocation: Place, endLocation: Place)
    {
        let origin = "\(myPosition.latitude),\(myPosition.longitude)"
        let destination = "\(place.latitude),\(place.longitude)"
        
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=AIzaSyCgbvoJQ47E9jtWU9et-svG6Z3SwsXZ9ww"
        print("RUTA: \(url)")
        
        Alamofire.request(url).responseJSON { response in
            print("RESPUESTA")
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            
            guard let json =  try?JSON(data: response.data!) else {
                print("Error graficando ruta")
                return
            }
            let routes = json["routes"].arrayValue
            
            // print route using Polyline
            print("Pintando rutas")
            for route in routes
            {
                self.createMarker(titleMarker: "destino", iconMarker: #imageLiteral(resourceName: "mapspin") , latitude: self.place.latitude, longitude: self.place.longitude)
                self.createMarker(titleMarker: "Inicio", iconMarker: #imageLiteral(resourceName: "mapspin") , latitude: self.myPosition.latitude, longitude: self.myPosition.longitude)
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeWidth = 4
                polyline.strokeColor = UIColor.red
                polyline.map = self.googleMaps
            }
            
        }
    }
    
    



    
}


