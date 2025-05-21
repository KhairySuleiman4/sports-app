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

    init() {
        setupNetworkMonitoring()
    }

    func fetchLeagues(for sportType: String) -> [NSManagedObject] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SportsLeagues")
        fetchRequest.predicate = NSPredicate(format: "sportType == %@", sportType)

        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            print("Fetch error: \(error)")
            return []
        }
    }

    func deleteLeague(_ league: NSManagedObject) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let context = appDelegate.persistentContainer.viewContext

        context.delete(league)

        do {
            try context.save()
            return true
        } catch {
            print("Delete error: \(error)")
            return false
        }
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

