//
//  LeagueDetailsPresenter.swift
//  SportsApp
//
//  Created by Ahmed Fareed on 17/05/2025.
//

import Foundation

protocol LeagueDetailsView: AnyObject {
    func reloadData()
    func showError(message: String)
}

class LeagueDetailsPresenter {
    private weak var view: LeagueDetailsView?
    private let networkManager: NetworkProtocol
    private var teams: [Total] = []
    private var upcomingEvents: [EventModel] = []
    private var latestEvents: [EventModel] = []
    private let sport: String
    private let leagueId: Int
    let currentDate = Date()
    
    init(view: LeagueDetailsView, networkManager: NetworkProtocol = NetworkManager(), sport: String, leagueId: Int) {
        self.view = view
        self.networkManager = networkManager
        self.sport = sport
        self.leagueId = leagueId
    }
    
    func viewDidLoad() {
        fetchTeams()
        fetchUpcomingEvents()
        fetchLatestEvents()
    }
    
    private func fetchTeams() {
        if sport.lowercased() == "tennis"{
            networkManager.fetchLeaguePlayers{ [weak self] result in
                guard let self = self else {
                    return
                }
                
                if let tennisPlayers = result?.result{
                    self.teams = self.convertTennisPlayersToTotals(players: tennisPlayers)
                    self.view?.reloadData()
                } else {
                    self.view?.showError(message: "Failed to load tennis players")
                }
            }
        } else {
            networkManager.fetchLeagueTeams(sport: sport, leagueid: leagueId) { [weak self] result in
                guard let self = self else { return }
                    
                if let standingResponse = result, let teams = standingResponse.result.total {
                    self.teams = teams
                    self.view?.reloadData()
                } else {
                    self.view?.showError(message: "Failed to load teams data")
                }
            }
        }
    }
    
    private func convertTennisPlayersToTotals(players: [TennisPlayer]) -> [Total] {
        return players.enumerated().map { index, player in
            return Total(
                standingPlace: Int(player.place) ?? (index + 1),
                standingPlaceType: "",
                standingTeam: player.player,
                standingP: 0,
                standingW: 0,
                standingD: 0,
                standingL: 0,
                standingF: 0,
                standingA: 0,
                standingGD: 0,
                standingPTS: Int(player.points) ?? 0,
                teamKey: index,
                leagueKey: leagueId,
                leagueSeason: "",
                leagueRound: "",
                standingUpdated: "",
                fkStageKey: 0,
                stageName: "",
                teamLogo: "",
                standingLP: 0,
                standingWP: 0
            )
        }
    }
    
    private func fetchUpcomingEvents() {
        
        let futureDate = Calendar.current.date(byAdding: .day, value: 3, to: currentDate)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let from = dateFormatter.string(from: currentDate)
        let to = dateFormatter.string(from: futureDate)
        
        let completion: (EventResponse?) -> Void = { [weak self] result in
            guard let self = self else { return }
            
            if let eventsResponse = result {
                let allEvents = eventsResponse.result ?? []
                
                self.upcomingEvents = allEvents.filter { $0.eventFinalResult == "-" }
                
                let completedEvents = allEvents.filter { $0.eventFinalResult != "-" }
                self.latestEvents.append(contentsOf: completedEvents)
                
                self.latestEvents.sort {
                    ($0.eventDate ?? "") > ($1.eventDate ?? "")
                }
                
                for event in self.upcomingEvents {
                    print("Upcoming Event: \(event.eventHomeTeam ?? "Unknown") vs \(event.eventAwayTeam ?? "Unknown")\n")
                    print("Score: \(event.eventFinalResult ?? "Unknown")\n")
                }
                self.view?.reloadData()
            } else {
                self.view?.showError(message: "Failed to load upcoming events")
            }
        }
        
        networkManager.fetchLeagueFixtures(sport: sport, leagueid: leagueId, from: from, to: to, completionHandler: completion)
    }
        
    private func fetchLatestEvents() {
        
        let pastDate = Calendar.current.date(byAdding: .day, value: -3, to: currentDate)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let from = dateFormatter.string(from: pastDate)
        let to = dateFormatter.string(from: currentDate)
        
        let completion: (EventResponse?) -> Void = { [weak self] result in
            guard let self = self else { return }
            
            if let eventsResponse = result {
                let allEvents = eventsResponse.result ?? []

                let completedEvents = allEvents.filter { $0.eventFinalResult != "-" }
                
                self.latestEvents.append(contentsOf: completedEvents)
                for event in self.latestEvents {
                    print("latest Event: \(event.eventHomeTeam ?? "Unknown") vs \(event.eventAwayTeam ?? "Unknown")\n")
                    print("Score: \(event.eventFinalResult ?? "Unknown")\n")
                }
                self.view?.reloadData()
            } else {
                self.view?.showError(message: "Failed to load latest events")
            }
        }
        
        networkManager.fetchLeagueFixtures(sport: sport, leagueid: leagueId, from: from, to: to, completionHandler: completion)
    }
    
    func getTeamsCount() -> Int {
        return teams.count
    }
    
    func getTeam(at index: Int) -> Total? {
        guard index < teams.count else { return nil }
        return teams[index]
    }
    
    func getUpcomingEventsCount() -> Int {
            return upcomingEvents.count
        }
        
    func getLatestEventsCount() -> Int {
        return latestEvents.count
    }
    
    func getUpcomingEvent(at index: Int) -> EventModel? {
        guard index < upcomingEvents.count else { return nil }
        return upcomingEvents[index]
    }
    
    func getLatestEvent(at index: Int) -> EventModel? {
        guard index < latestEvents.count else { return nil }
        return latestEvents[index]
    }
}
