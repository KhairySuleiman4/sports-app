//
//  TeamDetailsResponse.swift
//  SportsApp
//
//  Created by Khairy on 21/05/2025.
//

import Foundation

struct TeamDetailsResponse: Codable {
    let result: [TeamDetails]
}

struct TeamDetails: Codable {
    let teamName: String
    let teamLogo: String?
    let players: [Player]
    let coaches: [Coach]

    enum CodingKeys: String, CodingKey {
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players
        case coaches
    }
}

struct Coach: Codable {
    let coachName: String?

    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
    }
}

struct Player: Codable {
    let playerImage: String?
    let playerName: String
    let playerNumber: String?
    let playerType: String?
    let playerRating: String?

    enum CodingKeys: String, CodingKey {
        case playerImage = "player_image"
        case playerName = "player_name"
        case playerNumber = "player_number"
        case playerType = "player_type"
        case playerRating = "player_rating"
    }
}

