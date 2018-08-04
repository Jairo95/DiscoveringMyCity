//
//  PlaceItemCellController.swift
//  DiscoveringMyCity
//
//  Created by JAIRO PROAÑO on 4/8/18.
//  Copyright © 2018 Optativa Profesional. All rights reserved.
//

import UIKit

class PlaceItemCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var direction: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
