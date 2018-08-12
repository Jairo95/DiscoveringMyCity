//
//  ProfileController.swift
//  DiscoveringMyCity
//
//  Created by JAIRO PROAÑO on 19/7/18.
//  Copyright © 2018 Optativa Profesional. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMaps

class ProfileController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var favoritesTableView: UITableView!
    var placeManager = PlaceManager()
    var locationManager = CLLocationManager()
    
    var category: Category!
    
    var posibleFavouritePlace: Place!
    var myPosition: Place!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocation()
        placeManager.updateArrays()
        favoritesTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeManager.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritescell") as! FavoritesTableViewCell
        
        
        cell.nameLabel?.text = placeManager.places[indexPath.row].name
        
        cell.categoryLabel?.text = placeManager.places[indexPath.row].category
        print("Hope")
        /*let cell = UITableViewCell()
        cell.textLabel?.text = placeManager.places[indexPath.row].name
        */
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! mapa2ViewController
        destination.place = posibleFavouritePlace
        destination.myPosition = myPosition
    }
    
    
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let placeSelected = placeManager.places[indexPath.row]
        
        self.posibleFavouritePlace = Place()
        self.posibleFavouritePlace.name = placeSelected.name
        self.posibleFavouritePlace.latitude = placeSelected.latitude
        self.posibleFavouritePlace.longitude = placeSelected.longitude
        self.posibleFavouritePlace.category = placeSelected.category
        self.posibleFavouritePlace.image = placeSelected.image
        
        performSegue(withIdentifier: "MapaFavorito", sender: nil)
        
        return indexPath
    }
    
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        placeManager.updateArrays()
        favoritesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else {
            return
        }
        
        self.myPosition = Place()
        self.myPosition.latitude = location.latitude
        self.myPosition.longitude = location.longitude
        
        print("[MY POSITION]: \(myPosition)")

    }
    
    
    func initLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    
    
    
    
    
    
    
    
    
}
