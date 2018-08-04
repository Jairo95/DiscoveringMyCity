//
//  CategoryController.swift
//  DiscoveringMyCity
//
//  Created by JAIRO PROAÑO on 19/7/18.
//  Copyright © 2018 Optativa Profesional. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMaps

class CategoryController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var places: UITableView!
    
    @IBOutlet weak var radiusLabel: UILabel!
    
    
    
    var category: Category!
    
    var posibleFavouritePlace: Place!
    var myPosition: Place!
    
    private var nearbyPlaces: [PlaceAPI] = []
    private let radius: Int = 500
    var locationManager = CLLocationManager()
    var locationSelected = Location.startLocation
    
    var locationStart = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocation()
        self.categoryName.text = category?.name
        self.radiusLabel.text = "En \(radius) m"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MapaViewController
        destination.place = posibleFavouritePlace
        destination.myPosition = myPosition
    }
    
    func initLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nearbyPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell: UITableViewCell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as! PlaceItemCell
        let index: Int = indexPath.row
        // cell.textLabel?.text = "\(self.nearbyPlaces[index].name!) - \(self.nearbyPlaces[index].vicinity!)"
        cell.titleLabel.text = "\(self.nearbyPlaces[index].name!)"
        cell.direction.text = "\(self.nearbyPlaces[index].vicinity!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let placeSelected = self.nearbyPlaces[indexPath.row]
        
        self.posibleFavouritePlace = Place()
        self.posibleFavouritePlace.name = placeSelected.name
        self.posibleFavouritePlace.latitude = placeSelected.geometry.location.lat
        self.posibleFavouritePlace.longitude = placeSelected.geometry.location.lng
        self.posibleFavouritePlace.category = self.category.name
        self.posibleFavouritePlace.image = placeSelected.icon
        
        performSegue(withIdentifier: "showMap", sender: nil)
        
        return indexPath
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else {
            return
        }
        
        self.myPosition = Place()
        self.myPosition.latitude = location.latitude
        self.myPosition.longitude = location.longitude
        
        print("[MY POSITION]: \(myPosition)")
        
        searchNearbyPlaces()
    }
    
    
    func searchNearbyPlaces() {
        var latitude = 0.0
        var longitude = 0.0
        if self.myPosition != nil {
            latitude = self.myPosition.latitude
            longitude = self.myPosition.longitude
        }
    
        let key = "AIzaSyCgbvoJQ47E9jtWU9et-svG6Z3SwsXZ9ww"
        
        self.myPosition = Place()
        self.myPosition.name = "MyPosition"
        self.myPosition.latitude = latitude
        self.myPosition.longitude = longitude
        let searcherPlaces = SearcherPlacesManager(latitude: latitude, longitude: longitude, radius: radius, key: key)
        
        searcherPlaces.findNearbyPlaces(category: category) { (callResponse) in
            self.nearbyPlaces = callResponse.results
            self.places.reloadData()
        }
    }
    

    

}
