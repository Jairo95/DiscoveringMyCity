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
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritescell") as! FavoritesTableViewCell
        
        
        cell.nameLabel?.text = placeManager.places[indexPath.row].name
        
        cell.categoryLabel?.text = placeManager.places[indexPath.row].category
        print("Hope")
        /*let cell = UITableViewCell()
        cell.textLabel?.text = placeManager.places[indexPath.row].name
        */
        return cell
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
    
    
}
