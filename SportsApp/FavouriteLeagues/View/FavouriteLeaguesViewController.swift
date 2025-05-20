import UIKit
import CoreData

class FavouriteLeaguesViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var favTableView: UITableView!
    /*var leagues = [
        "Premier League",
        "La Liga",
        "Serie A",
        "Bundesliga",
        "Ligue 1",
        "Eredivisie",
        "Primeira Liga",
        "MLS",
        "Brasileirão",
        "J1 League",
        "Ligue 1",
        "Eredivisie",
        "Primeira Liga",
        "MLS",
        "Brasileirão",
    ]*/
    @IBOutlet weak var favSegment: UISegmentedControl!
    var favoriteLeagues: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.delegate = self
        favTableView.dataSource = self
        fetchFavoriteLeagues()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoriteLeagues()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteLeagues.count
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
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let leagueToDelete = favoriteLeagues[indexPath.row]
            let leagueName = leagueToDelete.value(forKey: "leagueName") as? String ?? "this league"

            let alert = UIAlertController(title: "Delete League", message: "Are you sure you want to remove \(leagueName) from your favorites?", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
                guard let self = self else { return }
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                let context = appDelegate.persistentContainer.viewContext
                
                context.delete(leagueToDelete)
                
                do {
                    try context.save()
                    self.favoriteLeagues.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    
                  
                } catch {
                    print("Failed to delete: \(error)")
                }
            })

            present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func segmentChanged(_ sender: Any) {
        fetchFavoriteLeagues()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func fetchFavoriteLeagues() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SportsLeagues")

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

        fetchRequest.predicate = NSPredicate(format: "sportType == %@", selectedSport)

        do {
            favoriteLeagues = try context.fetch(fetchRequest)
            favTableView.reloadData()
        } catch{
            print("error \(error)")
        }
    }



    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

