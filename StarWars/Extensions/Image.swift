//
//  Image.swift
//  StarWars
//
//  Created by Jason Barker on 6/18/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func symbol(for affiliation: CharacterAffiliation) -> UIImage? {
        switch affiliation {
        case .FIRST_ORDER:
            return UIImage(named: "first_order_symbol")
        case .JEDI:
            return UIImage(named: "jedi_symbol")
        case .RESISTANCE:
            return UIImage(named: "resistance_symbol")
        case .SITH:
            return UIImage(named: "sith_symbol")
        }
    }
}
