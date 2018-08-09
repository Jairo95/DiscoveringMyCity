//
//  MapaFavoritoViewController.swift
//  DiscoveringMyCity
//
//  Created by Christian on 9/8/18.
//  Copyright © 2018 Optativa Profesional. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire


class mapa2ViewController: UIViewController, GMSMapViewDelegate {
    
    
    
    @IBOutlet weak var googleMaps: GMSMapView!
    
    var place: Place!
    var myPosition: Place!
    let placeManager = PlaceManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createMarker(titleMarker: String, iconMarker: UIImage, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.icon = iconMarker
        marker.map = googleMaps
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
    
    
    
    
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

