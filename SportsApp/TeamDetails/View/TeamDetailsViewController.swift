//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by mac on 18/05/2025.
//

import UIKit

class TeamDetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var teamDetailTableView: UITableView!
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var teamName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        teamDetailTableView.delegate = self
        teamDetailTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "team_details", for: indexPath) as! TeamDetailsTableViewCell
        
        cell.playerName.text = "Messi"
        cell.playerImage.image = UIImage(named: "messi")
        cell.playNumber.text = "10"
        cell.playerPosition.text = "Play Maker"
        cell.playerRating.text = "10.0"

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Players"
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
