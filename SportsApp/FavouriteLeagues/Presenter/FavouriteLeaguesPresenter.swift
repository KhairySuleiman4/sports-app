//
//  Presenter.swift
//  SportsApp
//
//  Created by mac on 21/05/2025.
//
import UIKit
import CoreData
import Network

class FavouriteLeaguesPresenter {
    
    private let networkMonitor = NWPathMonitor()
    private var isConnected = false
    let coreDataHelper : CoreDataManager

    init() {
        self.coreDataHelper = CoreDataManager.shared
        setupNetworkMonitoring()
        
    }

    func fetchLeagues(for sportType: String) -> [NSManagedObject] {
        coreDataHelper.fetchFavoriteLeagues(sport: sportType)
    }

    func deleteLeague(_ league: NSManagedObject) -> Bool {
        return coreDataHelper.deleteLeagueFromFavorites(id: league.value(forKey: "leagueId") as! Int)
    }

    private func setupNetworkMonitoring() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = (path.status == .satisfied)
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        networkMonitor.start(queue: queue)
    }

    func isInternetAvailable() -> Bool {
        return isConnected
    }
}

