//
//  SportLeaguesViewController.swift
//  SportsApp
//
//  Created by Khairy on 16/05/2025.
//

import UIKit

class SportLeaguesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var leaguesTable: UITableView!
    
    let leagues = [
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
    
    var sportName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel?.text = "\(sportName!) Leagues"
        leaguesTable.delegate = self
        leaguesTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCell
        
        let league = leagues[indexPath.row]
    

        cell.leagueName.text = league
        cell.leagueImage.image = UIImage(named: "square")

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}
