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
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("ejecutando...........")
        let destination = segue.destination as! CategoryController
        print("para setear")
        destination.category = category
        print("Por dirigir")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showCategoryRestaurant(_ sender: Any) {
        let category = Category(name: "restaurant")
        self.category = category
        self.showCategory(category: category)
    }
    

    func showCategory(category: Category) {
        print("Mostrar categoria")
        performSegue(withIdentifier: "sender", sender: nil)
    }
    
    
    
}

