//
//  CategoryController.swift
//  DiscoveringMyCity
//
//  Created by JAIRO PROAÑO on 19/7/18.
//  Copyright © 2018 Optativa Profesional. All rights reserved.
//

import UIKit

class CategoryController: UIViewController {
    
    @IBOutlet weak var categoryName: UILabel!
    
    
    var category: Category!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryName.text = category?.name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
