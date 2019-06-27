//
//  SWCharacter.swift
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

struct SWCharacter: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let birthdate: String
    let profilePicture: String
    let forceSensitive: Bool
    let affiliation: CharacterAffiliation
    
    var profilePictureUrl: URL? { return URL(string: profilePicture) }
    
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

struct SWCharacters: Codable {
    let individuals: [SWCharacter]
}
