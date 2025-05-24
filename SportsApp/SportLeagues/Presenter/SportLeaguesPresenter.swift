import UIKit

protocol SportsLeaguesPresenterProtocol {
    func fetchSportLeagues(for sport: String?)
    func configureCell(_ cell: LeagueCell, with league: Sport)
    func isLeagueFavorite(id: Int) -> Bool
    func handleFavoriteAddition(for league: Sport, cell: LeagueCell)
    func handleFavoriteRemoval(for league: Sport, cell: LeagueCell)
}

class SportsLeaguesPresenter: SportsLeaguesPresenterProtocol {
    private let networkManager: NetworkProtocol
    private weak var view: SportLeaguesViewProtocol?
    private let coreDataHelper: CoreDataManager
    private var currentSport: String?
    
    init(networkManager: NetworkProtocol, view: SportLeaguesViewProtocol) {
        self.networkManager = networkManager
        self.view = view
        self.coreDataHelper = CoreDataManager.shared
    }
    
    func fetchSportLeagues(for sport: String?) {
        guard let sportName = sport?.lowercased() else { return }
        self.currentSport = sportName
        
        networkManager.fetchLeagues(sport: sportName) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.updateLeagues(result?.result ?? [])
            }
        }
    }
    
    func configureCell(_ cell: LeagueCell, with league: Sport) {
        cell.leagueName.text = league.leagueName
        cell.isFavorited = isLeagueFavorite(id: league.leagueKey)
        configureCellImage(cell, with: league)
    }
    
    private func configureCellImage(_ cell: LeagueCell, with league: Sport) {
        if let logoString = league.leagueLogo,
           let url = URL(string: logoString) {
            cell.leagueImage?.sd_setImage(with: url, placeholderImage: UIImage(named: getPlaceholderImage(for: currentSport)))
        } else {
            cell.leagueImage?.image = UIImage(named: getPlaceholderImage(for: currentSport))
        }
    }
    
    private func getPlaceholderImage(for sport: String?) -> String {
        switch sport?.lowercased() {
        case "tennis": return "Tennis"
        case "cricket": return "Cricket"
        case "basketball": return "Basketball"
        default: return "Football"
        }
    }
    
    func isLeagueFavorite(id: Int) -> Bool {
        return coreDataHelper.fetchFavoriteLeagues(sport: currentSport ?? "").contains { $0.value(forKey: "leagueId") as? Int == id }
    }
    
    func handleFavoriteAddition(for league: Sport, cell: LeagueCell) {
        guard let image = cell.leagueImage.image,
              let imageData = image.pngData() else {
            view?.showError(title: "Error", message: "Could not process league image")
            return
        }
        
        if coreDataHelper.addLeagueToFavorites(
            id: league.leagueKey,
            name: league.leagueName ?? "",
            imageData: imageData,
            sportType: currentSport ?? ""
        ) {
            cell.isFavorited = true
        } else {
            view?.showError(title: "Error", message: "Could not save to favorites")
        }
    }
    
    func handleFavoriteRemoval(for league: Sport, cell: LeagueCell) {
        let alert = UIAlertController(
            title: "Remove from Favorites",
            message: "Are you sure you want to remove this league from favorites?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel){ _ in
            cell.isFavorited = true
        })
        alert.addAction(UIAlertAction(title: "Remove", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            
            if self.coreDataHelper.deleteLeagueFromFavorites(id: league.leagueKey) {
                cell.isFavorited = false
            } else {
                self.view?.showError(title: "Error", message: "Could not remove from favorites")
            }
        })
        
        if let viewController = view as? UIViewController {
            viewController.present(alert, animated: true)
        }
    }
}
