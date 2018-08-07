//
//  ProfileController.swift
//  DiscoveringMyCity
//
//  Created by JAIRO PROAÑO on 19/7/18.
//  Copyright © 2018 Optativa Profesional. All rights reserved.
//

import UIKit

class ProfileController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var favoritesTableView: UITableView!
    var placeManager = PlaceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritecell") as! FavoritesTableViewCell
        
        /*cell.cityLabel.text = itemManager.item[indexPath.row].cityName
        cell.descriptionLabel.text = itemManager.item[indexPath.row].itemDescription
        */
        
        return cell
    }
    
    
}
