// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
class StandingResponse: Codable {
    let success: Int?
    let result: Result

    init(success: Int?, result : Result) {
        self.success = success
        self.result = result
    }
}

class Result : Codable{
    let total: [Total]?
    init(total: [Total]?) {
        self.total = total
    }
}

// MARK: - Total
class Total: Codable {
    let standingPlace: Int?
    let standingPlaceType, standingTeam: String?
    let standingP, standingW, standingD, standingL: Int?
    let standingF, standingA, standingGD, standingPTS: Int?
    let teamKey, leagueKey: Int?
    let leagueSeason, leagueRound, standingUpdated: String?
    let fkStageKey: Int?
    let stageName: String?
    let teamLogo: String?
    let standingLP, standingWP: Int?

    enum CodingKeys: String, CodingKey {
        case standingPlace = "standing_place"
        case standingPlaceType = "standing_place_type"
        case standingTeam = "standing_team"
        case standingP = "standing_P"
        case standingW = "standing_W"
        case standingD = "standing_D"
        case standingL = "standing_L"
        case standingF = "standing_F"
        case standingA = "standing_A"
        case standingGD = "standing_GD"
        case standingPTS = "standing_PTS"
        case teamKey = "team_key"
        case leagueKey = "league_key"
        case leagueSeason = "league_season"
        case leagueRound = "league_round"
        case standingUpdated = "standing_updated"
        case fkStageKey = "fk_stage_key"
        case stageName = "stage_name"
        case teamLogo = "team_logo"
        case standingLP = "standing_LP"
        case standingWP = "standing_WP"
    }

    init(standingPlace: Int?, standingPlaceType: String?, standingTeam: String?, standingP: Int?, standingW: Int?, standingD: Int?, standingL: Int?, standingF: Int?, standingA: Int?, standingGD: Int?, standingPTS: Int?, teamKey: Int?, leagueKey: Int?, leagueSeason: String?, leagueRound: String?, standingUpdated: String?, fkStageKey: Int?, stageName: String?, teamLogo: String?, standingLP: Int?, standingWP: Int?) {
        self.standingPlace = standingPlace
        self.standingPlaceType = standingPlaceType
        self.standingTeam = standingTeam
        self.standingP = standingP
        self.standingW = standingW
        self.standingD = standingD
        self.standingL = standingL
        self.standingF = standingF
        self.standingA = standingA
        self.standingGD = standingGD
        self.standingPTS = standingPTS
        self.teamKey = teamKey
        self.leagueKey = leagueKey
        self.leagueSeason = leagueSeason
        self.leagueRound = leagueRound
        self.standingUpdated = standingUpdated
        self.fkStageKey = fkStageKey
        self.stageName = stageName
        self.teamLogo = teamLogo
        self.standingLP = standingLP
        self.standingWP = standingWP
    }
}
