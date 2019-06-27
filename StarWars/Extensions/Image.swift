//
//  Image.swift
//  StarWars
//
//  Created by Jason Barker on 6/18/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func symbol(for affiliation: String) -> UIImage? {
        switch affiliation {
        case "First Order":
            return UIImage(named: "first_order_symbol")
        case "Jedi":
            return UIImage(named: "jedi_symbol")
        case "Resistance":
            return UIImage(named: "resistance_symbol")
        case "Sith":
            return UIImage(named: "sith_symbol")
        default:
            return nil
        }
    }
}
