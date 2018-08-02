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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryName.text = category?.name
        
        self.places.reloadData()
        searchNearbyPlaces()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        cell.textLabel?.text = "hi"
        return cell
    }
    
    
    func searchNearbyPlaces() {
        let latitude = "-0.2097509"
        let longitude = "-78.4951927"
        let keyWord = "university"
        let type = "university"
        let radius = "1500"
        let key = "AIzaSyCgbvoJQ47E9jtWU9et-svG6Z3SwsXZ9ww"
        let urlApi = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=\(radius)&type=\(type)&keyword=\(keyWord)&key=\(key)"
        
        Alamofire.request(urlApi).responseJSON { (response) in
            guard let json = response.data else {
                return
            }
            
            guard let resultResponse = try? JSONDecoder().decode(CallResponseAPI.self, from: json) else {
                return
            }
            print("\(resultResponse)")
        }
        
    }
    
    
}
