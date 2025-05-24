//
//  Sport.swift
//  SportsApp
//
//  Created by mac on 16/05/2025.
//

import Foundation
struct Sport: Codable {
    let leagueKey: Int
    let leagueName: String?
   // let countryKey: Int
    let countryName: String?
    let leagueLogo: String?
    var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
       // case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
    }
}
