//
//  StarWarsCharacter.swift
//  StarWars
//
//  Created by Jason Barker on 6/17/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import Foundation

enum CharacterAffiliation: String, Codable {
    case FIRST_ORDER
    case JEDI
    case RESISTANCE
    case SITH
}

struct StarWarsCharacter: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let birthdate: String
    let profilePicture: String
    let forceSensitive: Bool
    let affiliation: CharacterAffiliation
    
    var fullName: String { return "\(firstName) \(lastName)" }
    var profilePictureUrl: URL? { return URL(string: profilePicture) }

    var ageDescription: String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: birthdate) {
            let years = Calendar.current.dateComponents([.year], from: date, to: Date()).year
            return "\(years ?? 0) years old"
        }
        return nil
    }
    
    var affiliationDescription: String {
        switch affiliation {
        case .FIRST_ORDER:
            return "First Order"
        case .JEDI:
            return "Jedi"
        case .RESISTANCE:
            return "Resistance"
        case .SITH:
            return "Sith"
        }
    }
}

struct StarWarsCharacters: Codable {
    let individuals: [StarWarsCharacter]
}
