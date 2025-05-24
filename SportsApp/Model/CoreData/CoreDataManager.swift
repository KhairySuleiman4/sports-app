//
//  CoreDataManager.swift
//  SportsApp
//
//  Created by Macos on 23/05/2025.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    private let context: NSManagedObjectContext
    
    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate not found")
        }
        context = appDelegate.persistentContainer.viewContext
    }
    
    func addLeagueToFavorites(id: Int, name: String, imageData: Data, sportType: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SportsLeagues")
        fetchRequest.predicate = NSPredicate(format: "leagueId == %d", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            if !results.isEmpty {
                return false
            }
            
            let entity = NSEntityDescription.entity(forEntityName: "SportsLeagues", in: context)!
            let league = NSManagedObject(entity: entity, insertInto: context)
            league.setValue(id, forKey: "leagueId")
            league.setValue(name, forKey: "leagueName")
            league.setValue(imageData, forKey: "leagueImage")
            league.setValue(sportType, forKey: "sportType")
            try context.save()
            return true
        } catch {
            print("Failed to save: \(error)")
            return false
        }
    }
    
    func deleteLeagueFromFavorites(id: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SportsLeagues")
        fetchRequest.predicate = NSPredicate(format: "leagueId == %d", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let league = results.first {
                context.delete(league)
                try context.save()
                return true
            }
            return false
        } catch {
            print("Failed to delete: \(error)")
            return false
        }
    }
    
    func fetchFavoriteLeagues(sport: String) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SportsLeagues")
        fetchRequest.predicate = NSPredicate(format: "sportType == %@", sport)
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch: \(error)")
            return []
        }
    }
    
    func isLeagueFavorite(id: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SportsLeagues")
        fetchRequest.predicate = NSPredicate(format: "leagueId == %d", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty
        } catch {
            print("Failed to fetch: \(error)")
            return false
        }
    }
}
