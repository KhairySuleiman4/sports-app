import UIKit
import CoreData
import Network

class FavouriteLeaguesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var favTableView: UITableView!
    @IBOutlet weak var favSegment: UISegmentedControl!
    var favoriteLeagues: [NSManagedObject] = []
    
    let presenter = FavouriteLeaguesPresenter()
    
    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "No favorites yet!\nStart exploring to add your favorite leagues"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.delegate = self
        favTableView.dataSource = self
        fetchFavoriteLeagues()
        setupEmptyStateLabel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoriteLeagues()
        favTableView.reloadData()
    }
    
    private func setupEmptyStateLabel() {
        view.addSubview(emptyStateLabel)
        NSLayoutConstraint.activate([
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emptyStateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func updateUI() {
        emptyStateLabel.isHidden = !favoriteLeagues.isEmpty
        favTableView.isHidden = favoriteLeagues.isEmpty
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteLeagues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fav_league_cell", for: indexPath) as! FavLeagueCell
        
        let league = favoriteLeagues[indexPath.row]
        cell.favLeagueName.text = league.value(forKey: "leagueName") as? String
        if let imageData = league.value(forKey: "leagueImage") as? Data {
            cell.favLeagueImage.image = UIImage(data: imageData)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let league = favoriteLeagues[indexPath.row]
        let leagueId = league.value(forKey: "leagueId") as? Int ?? 0
        let sportType = league.value(forKey: "sportType") as? String ?? "football"

        if presenter.isInternetAvailable() {
            if let leaguesDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsCollectionViewController") as? LeagueDetailsCollectionViewController {
                leaguesDetailsViewController.sport = sportType
                leaguesDetailsViewController.leagueId = leagueId
                navigationController?.pushViewController(leaguesDetailsViewController, animated: true)
            }
        } else {
            showNoInternetAlert()
        }
    }


    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let leagueToDelete = favoriteLeagues[indexPath.row]
                let leagueName = leagueToDelete.value(forKey: "leagueName") as? String ?? "this league"

                let alert = UIAlertController(title: "Delete League", message: "Are you sure you want to remove \(leagueName) from your favorites?", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
                    guard let self = self else { return }
                    
                    if self.presenter.deleteLeague(leagueToDelete) {
                        self.favoriteLeagues.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        self.updateUI()
                    }
                })

                present(alert, animated: true)
                favTableView.reloadData()
            }
        }

    @IBAction func segmentChanged(_ sender: Any) {
        fetchFavoriteLeagues()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func fetchFavoriteLeagues() {
        let selectedSport: String
        switch favSegment.selectedSegmentIndex {
        case 0:
            selectedSport = "football"
        case 1:
            selectedSport = "tennis"
        case 2:
            selectedSport = "basketball"
        case 3:
            selectedSport = "cricket"
        default:
            selectedSport = "football"
        }
        
        favoriteLeagues = presenter.fetchLeagues(for: selectedSport)
        updateUI()
        favTableView.reloadData()
    }
    
    private func showNoInternetAlert() {
        let alert = UIAlertController(
            title: "No Internet Connection",
            message: "Please check your internet connection and try again.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
