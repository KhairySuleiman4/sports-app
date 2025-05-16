//
//  FavouriteLeaguesViewController.swift
//  SportsApp
//
//  Created by mac on 16/05/2025.
//

import UIKit

class FavouriteLeaguesViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var favTableView: UITableView!
    var leagues = [
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
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.delegate = self
        favTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leagues.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fav_league_cell", for: indexPath) as! FavLeagueCell
        
        let league = leagues[indexPath.row]
        cell.favLeagueName.text = league
        cell.favLeagueImage.image = UIImage(named: "square")

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // navigate to league detail on online mode , alert to user in offline mode
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // will use this to delete item by core data
        if editingStyle == .delete {
            leagues.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
