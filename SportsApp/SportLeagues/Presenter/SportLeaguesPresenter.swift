//
//  SportLeaguePresenter.swift
//  SportsApp
//
//  Created by mac on 16/05/2025.
//

import Foundation

class SportsLeaguesPresenter {
    var sports: [Sport] = []
    var networkManager: NetworkProtocol
    var sportLeaguesViewController: SportLeaguesViewController
    
    init(networkManager: NetworkProtocol, sportLeaguesViewController: SportLeaguesViewController) {
        self.networkManager = networkManager
        self.sportLeaguesViewController = sportLeaguesViewController
    }
    
    func fetchSportLeagues() {
        guard let sportName = sportLeaguesViewController.sportName?.lowercased() else {
            print("Sport name is nil")
            return
        }
        networkManager.fetchDataFromJSON(sport: sportName) { [weak self] res in
            guard let self = self else { return }
            self.sports = res?.result ?? []
            DispatchQueue.main.async {
                self.sportLeaguesViewController.sport = self.sports
                self.sportLeaguesViewController.leaguesTable.reloadData()
            }
        }
    }
}
