//
//  TabBarViewControllerJ.swift
//  DiscoveringMyCity
//
//  Created by Jossué Dután on 25/7/18.
//  Copyright © 2018 Optativa Profesional. All rights reserved.
//

import UIKit

class TabBarViewControllerJ: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) { //Did appear sobreescribe lo cargado en la vista
        configTabBar()
    }
    
    func configTabBar(){
        let items = tabBar.items
        items?[1].title = "Favoritos"
        items?[2].title = "Añadir"
        items?[1].image = #imageLiteral(resourceName: "heart")
        items?[2].image = #imageLiteral(resourceName: "plus")
        
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
