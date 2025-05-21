//
//  TennisPlayersResponse.swift
//  SportsApp
//
//  Created by Khairy on 21/05/2025.
//

import Foundation

struct TennisPlayersResponse: Codable{
    let result: [TennisPlayer]
}

struct TennisPlayer: Codable{
    let place: String
    let player: String
    let country: String
    let points: String
    
    enum CodingKeys: String, CodingKey{
        case place
        case player
        case country
        case points
    }
}
