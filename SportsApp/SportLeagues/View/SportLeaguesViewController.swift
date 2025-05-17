//
//  SportLeaguesViewController.swift
//  SportsApp
//
//  Created by Khairy on 16/05/2025.
//

import UIKit
import SDWebImage

class SportLeaguesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var leaguesTable: UITableView!
    
    var sport : [Sport] = []
    
    var sportPresenter : SportsLeaguesPresenter?
    var networkingManager : NetworkProtocol?
    
    
    var sportName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkingManager = NetworkManager()
        sportPresenter = SportsLeaguesPresenter(networkManager: networkingManager!,sportLeaguesViewController: self)
        headerLabel?.text = "\(sportName!) Leagues"
        leaguesTable.delegate = self
        leaguesTable.dataSource = self
        sportPresenter?.fetchSportLeagues()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sport.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCell
            let sportItem = sport[indexPath.row]
            
            cell.leagueName.text = sportItem.leagueName
            
           
            if sportName?.lowercased() == "football", let logoString = sportItem.leagueLogo, let url = URL(string: logoString) {
                cell.leagueImage?.sd_setImage(with: url, placeholderImage: UIImage(named: "Football"))
            } else {
                let placeholderImageName: String
                switch sportName?.lowercased() {
                case "tennis":
                    placeholderImageName = "Tennis"
                case "cricket":
                    placeholderImageName = "Cricket"
                case "basketball":
                    placeholderImageName = "Basketball"
                default:
                    placeholderImageName = "Football"
                }
                cell.leagueImage?.image = UIImage(named: placeholderImageName)
            }
            
            return cell
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 55
        }
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            10
        }
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 10
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let leaguesDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsCollectionViewController") as! LeagueDetailsCollectionViewController
        //        sportLeaguesViewController.sportName = sports[indexPath.row]
            leaguesDetailsViewController.sport = sportName!
            leaguesDetailsViewController.leagueId = sport[indexPath.row].leagueKey
            self.navigationController?.pushViewController(leaguesDetailsViewController, animated: true)
        }
        
    }

