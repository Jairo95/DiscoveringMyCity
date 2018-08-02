//
//  CategoryController.swift
//  DiscoveringMyCity
//
//  Created by JAIRO PROAÑO on 19/7/18.
//  Copyright © 2018 Optativa Profesional. All rights reserved.
//

import UIKit
import Alamofire

class CategoryController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var places: UITableView!
    
    
    
    var category: Category!
    var nearbyPlaces: [PlaceAPI] = []
    
    var posibleFavouritePlace: Place!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryName.text = category?.name
        searchNearbyPlaces()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nearbyPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        let index: Int = indexPath.row
        cell.textLabel?.text = "\(self.nearbyPlaces[index].name!) - \(self.nearbyPlaces[index].vicinity!)"
        return cell
    }
    
    func searchNearbyPlaces() {
        let latitude = -0.2097509
        let longitude = -78.4951927
        let radius = 1500
        let key = "AIzaSyCgbvoJQ47E9jtWU9et-svG6Z3SwsXZ9ww"
        let searcherPlaces = SearcherPlacesManager(latitude: latitude, longitude: longitude, radius: radius, key: key)
        
        searcherPlaces.findNearbyPlaces(category: category) { (callResponse) in
            print("Resultado: \(callResponse)")
            self.nearbyPlaces = callResponse.results
            self.places.reloadData()
        }
    }
}
