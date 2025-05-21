//
//  TeamDetailsPresenter.swift
//  SportsApp
//
//  Created by Khairy on 21/05/2025.
//

protocol TeamDetailsView: AnyObject {
    func showTeamDetails(teamDetails: TeamDetails)
}

import Foundation

class TeamDetailsPresenter{
    private weak var view: TeamDetailsView?
    private let networkManager: NetworkProtocol
    private let sport: String
    private let teamId: Int
    
    init(view: TeamDetailsView, networkManager: NetworkProtocol, sport: String, teamId: Int) {
        self.view = view
        self.networkManager = networkManager
        self.sport = sport
        self.teamId = teamId
    }
    
    func getTeamDetails(){
        networkManager.fetchTeamDetails(sport: sport, teamId: teamId) { [weak self] response in
            guard let team = response?.result.first else {
                print("Team details not found.")
                return
            }
            self?.view?.showTeamDetails(teamDetails: team)
        }
    }
}
