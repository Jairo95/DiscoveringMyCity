//
//  ViewController.swift
//  DiscoveringMyCity
//
//  Created by Jossue on 19/6/18.
//  Copyright © 2018 Optativa Profesional. All rights reserved.
//

import UIKit


class HomeController: UIViewController {
    
    
    var category: Category!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CategoryController
        destination.category = category
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func shiwCategoryHealth(_ sender: Any) {
        let category = Category(name: "Salud", keyWord: "health", type: "health")
        self.category = category
        self.showCategory(category: category)
    }
    
    @IBAction func showCategoryRestaurant(_ sender: Any) {
        let category = Category(name: "Restaurantes", keyWord: "restaurant", type: "restaurant")
        self.category = category
        self.showCategory(category: category)
    }
    
    @IBAction func showHotelCategory(_ sender: Any) {
        let category = Category(name: "Hoteles", keyWord: "hotel", type: "hotel")
        self.category = category
        self.showCategory(category: category)
    }
    
    @IBAction func showBar(_ sender: Any) {
        let category = Category(name: "Bares", keyWord: "bar", type: "bar")
        self.category = category
        self.showCategory(category: category)
    }
    
    @IBAction func showCinemas(_ sender: Any) {
        let category = Category(name: "Cines", keyWord: "cinema", type: "cinema")
        self.category = category
        self.showCategory(category: category)
    }
    
    @IBAction func showGasStations(_ sender: Any) {
        let category = Category(name: "Gasolineras", keyWord: "gasstation", type: "gasstation")
        self.category = category
        self.showCategory(category: category)
    }
    
    @IBAction func showSupermarkers(_ sender: Any) {
        let category = Category(name: "Supermercados", keyWord: "supermarket", type: "supermarket")
        self.category = category
        self.showCategory(category: category)
    }
    
    @IBAction func showBanks(_ sender: Any) {
        let category = Category(name: "Bancos", keyWord: "bank", type: "bank")
        self.category = category
        self.showCategory(category: category)
    }

    func showCategory(category: Category) {
        performSegue(withIdentifier: "sender", sender: nil)
    }
    
    
    
}

