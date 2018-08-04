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

class MapaViewController: UIViewController , GMSMapViewDelegate ,  CLLocationManagerDelegate {
    
    @IBOutlet weak var googleMaps: GMSMapView!
    @IBOutlet weak var startLocation: UITextField!
    @IBOutlet weak var destinationLocation: UITextField!
    
    
    var place: Place!
    var myPosition: Place!
    
    
    
    var locationManager = CLLocationManager()
    var locationSelected = Location.startLocation
    
    var locationStart = CLLocation()
    var locationEnd = CLLocation()
    
    var location2 = CLLocation()
    //var locationDestino = CLLocation(latitude:-0.20707, longitude: -78.4891955)
    
    var locationDestino = CLLocation(latitude:-0.207306, longitude: -78.4937445)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Lugar seleccionado: \(place), Mi posicion: \(myPosition)")
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        /*
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        */
        
        //Your map initiation code
        let camera = GMSCameraPosition.camera(withLatitude: -0.1862505, longitude: -78.4886912, zoom: 15.0)
        print("camara")
        
        //let camera = GMSCameraPosition.camera(self)
        
        self.googleMaps.camera = camera
        self.googleMaps.delegate = self
        self.googleMaps?.isMyLocationEnabled = true
        self.googleMaps.settings.myLocationButton = true
        self.googleMaps.settings.compassButton = true
        self.googleMaps.settings.zoomGestures = true
        print("Activando google maps")
        
        
    }
    
    // MARK: function for create a marker pin on map
    func createMarker(titleMarker: String, iconMarker: UIImage, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.icon = iconMarker
        marker.map = googleMaps
    }
    
    //MARK: - Location Manager delegates
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error to get location : \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        //        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        //        let locationTujuan = CLLocation(latitude: 37.784023631590777, longitude: -122.40486681461333)
        
        location2 = CLLocation(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        
        createMarker(titleMarker: "destino", iconMarker: #imageLiteral(resourceName: "mapspin") , latitude: locationDestino.coordinate.latitude, longitude: locationDestino.coordinate.longitude)
        
        createMarker(titleMarker: "inicio", iconMarker: #imageLiteral(resourceName: "mapspin") , latitude: (location2.coordinate.latitude), longitude: (location2.coordinate.longitude))
        
        //Grafica sin precionar
        
        //drawPath(startLocation: location2, endLocation: locationDestino)
        
        
        
        //        self.googleMaps?.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
        
    }
    
    // MARK: - GMSMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        googleMaps.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        googleMaps.isMyLocationEnabled = true
        
        if (gesture) {
            mapView.selectedMarker = nil
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        googleMaps.isMyLocationEnabled = true
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("COORDINATE \(coordinate)") // when you tapped coordinate
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        googleMaps.isMyLocationEnabled = true
        googleMaps.selectedMarker = nil
        return false
    }
    
    
    
    //MARK: - this is function for create direction path, from start location to desination location
    
    func drawPath(startLocation: CLLocation, endLocation: CLLocation)
    {
        let origin = "\(location2.coordinate.latitude),\(location2.coordinate.longitude)"
        let destination = "\(locationDestino.coordinate.latitude),\(locationDestino.coordinate.longitude)"
        
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        
        Alamofire.request(url).responseJSON { response in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            
            guard let json =  try?JSON(data: response.data!) else {return}
            let routes = json["routes"].arrayValue
            
            // print route using Polyline
            for route in routes
            {
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
     // MARK: when start location tap, this will open the search location
     @IBAction func openStartLocation(_ sender: UIButton) {
     
     let autoCompleteController = GMSAutocompleteViewController()
     autoCompleteController.delegate = self
     
     // selected location
     locationSelected = .startLocation
     
     // Change text color
     UISearchBar.appearance().setTextColor(color: UIColor.black)
     self.locationManager.stopUpdatingLocation()
     
     self.present(autoCompleteController, animated: true, completion: nil)
     }
     
     // MARK: when destination location tap, this will open the search location
     @IBAction func openDestinationLocation(_ sender: UIButton) {
     
     let autoCompleteController = GMSAutocompleteViewController()
     autoCompleteController.delegate = self
     
     // selected location
     locationSelected = .destinationLocation
     
     // Change text color
     UISearchBar.appearance().setTextColor(color: UIColor.black)
     self.locationManager.stopUpdatingLocation()
     
     self.present(autoCompleteController, animated: true, completion: nil)
     } */
    
    
    // MARK: SHOW DIRECTION WITH BUTTON
    @IBAction func showDirection(_ sender: UIButton) {
        // when button direction tapped, must call drawpath func
        
        
        //let x2 = Double(inicioX.text!)
        //let y2 = Double(inicioY.text!)
        
        //let locationDest = CLLocation(latitude: x2!, longitude:y2!)
        //let locationDestino = CLLocation(latitude: x1!, longitude: y1!)
        self.drawPath(startLocation: location2, endLocation: locationDestino)
        print("Coordenadas DESTINO")
        
    }
    
}

// MARK: - GMS Auto Complete Delegate, for autocomplete search location
extension MapaViewController: GMSAutocompleteViewControllerDelegate {
    
    
    
    /*
     var locationManager = CLLocationManager()
     var locationSelected = Location.startLocation
     
     var locationStart = CLLocation()
     var locationEnd = CLLocation()
     
     */
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error \(error)")
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        // Change map location
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16.0
        )
        
        // set coordinate to text
        /*if locationSelected == .startLocation {
         
         location2 = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
         createMarker(titleMarker: "Location Start", iconMarker: #imageLiteral(resourceName: "mapspin"), latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
         } else {
         
         locationDestino = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
         createMarker(titleMarker: "Location End", iconMarker: #imageLiteral(resourceName: "mapspin"), latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
         }
         */
        
        self.googleMaps.camera = camera
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

public extension UISearchBar {
    
    public func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
    
}


