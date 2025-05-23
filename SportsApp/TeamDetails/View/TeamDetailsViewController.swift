//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by mac on 18/05/2025.
//

import UIKit
import SDWebImage

class TeamDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TeamDetailsView{

    @IBOutlet weak var teamDetailTableView: UITableView!
    
    @IBOutlet weak var coachName: UILabel!
    
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var teamLogo: UIImageView!
    
    var playersList: [Player]?
    var coachesList: [Coach]?
    var teamId: Int?
    var sport: String?
    
    private var presenter: TeamDetailsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = TeamDetailsPresenter(view: self, networkManager: NetworkManager(), sport: sport!, teamId: teamId!)

        teamDetailTableView.delegate = self
        teamDetailTableView.dataSource = self
        
        presenter.getTeamDetails()
    }
    
    func showTeamDetails(teamDetails: TeamDetails){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.teamName.text = teamDetails.teamName
            if let logoUrlString = teamDetails.teamLogo, !logoUrlString.isEmpty, let logoUrl = URL(string: logoUrlString) {
                self.teamLogo.sd_setImage(with: logoUrl, placeholderImage: UIImage(named: "football"))
            } else {
                self.teamLogo.image = UIImage(named: "football")
            }
//            self.coachName.text = teamDetails.coaches[0].coachName
            self.playersList = teamDetails.players
            self.coachesList = teamDetails.coaches
            self.teamDetailTableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 0 {
                return coachesList?.count ?? 0
            }
            return playersList?.count ?? 0
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "team_details", for: indexPath) as! TeamDetailsTableViewCell
            
            if indexPath.section == 0 {
                guard let coach = coachesList?[indexPath.row] else { return UITableViewCell() }
                cell.playerName.text = coach.coachName
                cell.playerImage.image = UIImage(named: "avatar.jpg")
                cell.playerNumber.text = ""
                cell.playerPosition.text = ""
                cell.playerRating.text = ""
                return cell
            } else {
                guard let player = playersList?[indexPath.row] else { return UITableViewCell() }
                
                cell.playerName.text = player.playerName
                if let imageUrlString = player.playerImage, !imageUrlString.isEmpty, let imageUrl = URL(string: imageUrlString) {
                    cell.playerImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "avatar.jpg"))
                } else {
                    cell.playerImage.image = UIImage(named: "avatar.jpg")
                }
                
                cell.playerNumber.text = player.playerNumber
                cell.playerPosition.text = player.playerType
                cell.playerRating.text = player.playerRating
                
                return cell
            }
        }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        ["Coaches", "Players"][section]
    }
    
}
