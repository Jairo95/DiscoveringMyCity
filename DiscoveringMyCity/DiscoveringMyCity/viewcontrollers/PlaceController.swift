//
//  PlaceController.swift
//  DiscoveringMyCity
//
//  Created by JAIRO PROAÑO on 19/7/18.
//  Copyright © 2018 Optativa Profesional. All rights reserved.
//

import Foundation


struct CallResponseApli: Decodable {
    
    let results: [Place]!
    
}


struct Place: Decodable {
    
    let name: String!
    
}

