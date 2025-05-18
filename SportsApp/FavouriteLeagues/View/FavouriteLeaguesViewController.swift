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
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            context.delete(leagueToDelete)
            
            do {
                try context.save()
                favoriteLeagues.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print("Failed to delete: \(error)")
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func fetchFavoriteLeagues() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SportsLeagues")
        
        do {
            favoriteLeagues = try context.fetch(fetchRequest)
            favTableView.reloadData()
        } catch {
            print("Failed to fetch: \(error)")
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
