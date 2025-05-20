import CoreData
import UIKit

class SportsLeaguesPresenter {
    var sports: [Sport] = []
    var networkManager: NetworkProtocol
    weak var viewController: SportLeaguesViewController?

    init(networkManager: NetworkProtocol, sportLeaguesViewController: SportLeaguesViewController) {
        self.networkManager = networkManager
        self.viewController = sportLeaguesViewController
    }

    func fetchSportLeagues() {
        guard let sportName = viewController?.sportName?.lowercased() else { return }
        
        networkManager.fetchLeagues(sport: sportName) { [weak self] res in
            guard let self = self else { return }
            self.sports = res?.result ?? []
            DispatchQueue.main.async {
                self.viewController?.sport = self.sports
                self.viewController?.leaguesTable.reloadData()
            }
        }
    }

    func saveLeagueToFavorites(id: Int, name: String, imageData: Data, sportType: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SportsLeagues")
        fetchRequest.predicate = NSPredicate(format: "leagueId == %d", id)

        do {
            let results = try context.fetch(fetchRequest)
            if !results.isEmpty {
                return false
            } else {
                let entity = NSEntityDescription.entity(forEntityName: "SportsLeagues", in: context)!
                let league = NSManagedObject(entity: entity, insertInto: context)
                league.setValue(id, forKey: "leagueId")
                league.setValue(name, forKey: "leagueName")
                league.setValue(imageData, forKey: "leagueImage")
                league.setValue(sportType, forKey: "sportType")
                try context.save()
                return true
            }
        } catch {
            print("Failed to save or fetch: \(error)")
            return false
        }
    }
}

