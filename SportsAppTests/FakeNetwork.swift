//
//  FakeNetwork.swift
//  SportsAppTests
//
//  Created by mac on 21/05/2025.
//


import Foundation
@testable import SportsApp

class FakeNetwork: NetworkProtocol {
    var shouldReturnError: Bool
    
    let mockLeaguesResponse: SportResult = SportResult(result: [
        Sport(leagueKey: 1, leagueName: "Premier League", countryName: "England", leagueLogo: "https://example.com/premier_league_logo.png", isFavorite: false)
    ])
    
    let mockTeamsResponse: StandingResponse = StandingResponse(success: 1, result: Result(total: [
        Total(
            standingPlace: 1,
            standingPlaceType: "Leader",
            standingTeam: "Manchester United",
            standingP: 38,
            standingW: 20,
            standingD: 10,
            standingL: 8,
            standingF: 60,
            standingA: 30,
            standingGD: 30,
            standingPTS: 70,
            teamKey: 101,
            leagueKey: 1,
            leagueSeason: "2024/2025",
            leagueRound: "Round 1",
            standingUpdated: "2025-05-16",
            fkStageKey: 1,
            stageName: "Regular Season",
            teamLogo: "https://example.com/man_utd_logo.png",
            standingLP: 0,
            standingWP: 0
        )
    ]))
    
    let mockFixturesResponse: EventResponse = EventResponse(success: 1, result: [
        EventModel(
            eventKey: 1001,
            eventDate: "2025-05-16",
            eventTime: "15:00",
            eventHomeTeam: "Manchester United",
            homeTeamKey: 101,
            eventAwayTeam: "Liverpool",
            awayTeamKey: 102,
            eventHalftimeResult: "0-0",
            eventFinalResult: "2-1",
            eventFtResult: "2-1",
            eventPenaltyResult: nil,
            eventStatus: "Finished",
            countryName: "England",
            leagueName: "Premier League",
            leagueKey: 1,
            leagueRound: "Round 1",
            leagueSeason: "2024/2025",
            eventLive: "0",
            eventStadium: "Old Trafford",
            eventReferee: "John Doe",
            homeTeamLogo: "https://example.com/man_utd_logo.png",
            awayTeamLogo: "https://example.com/liverpool_logo.png",
            eventCountryKey: 44,
            leagueLogo: "https://example.com/premier_league_logo.png",
            countryLogo: "https://example.com/england_logo.png",
            eventHomeFormation: "4-3-3",
            eventAwayFormation: "4-2-3-1",
            fkStageKey: 1,
            stageName: "Regular Season",
            firstPlayer: nil,
            secondPlayer: nil
        )
    ])
    
    enum ResponseError: Error {
        case apiError
    }
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    func fetchLeagues(sport: String, completionHandler: @escaping (SportResult?) -> Void) {
        if shouldReturnError {
            completionHandler(nil)
        } else {
            completionHandler(mockLeaguesResponse)
        }
    }
    
    func fetchLeagueTeams(sport: String, leagueid: Int, completionHandler: @escaping (StandingResponse?) -> Void) {
        if shouldReturnError {
            completionHandler(nil)
        } else {
            completionHandler(mockTeamsResponse)
        }
    }
    
    func fetchLeagueFixtures(sport: String, leagueid: Int, from: String, to: String, completionHandler: @escaping (EventResponse?) -> Void) {
        if shouldReturnError {
            completionHandler(nil)
        } else {
            completionHandler(mockFixturesResponse)
        }
    }
}
