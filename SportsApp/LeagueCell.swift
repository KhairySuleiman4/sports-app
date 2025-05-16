//
//  LeagueCell.swift
//  SportsApp
//
//  Created by Khairy on 16/05/2025.
//

import UIKit

class LeagueCell: UITableViewCell {

    @IBOutlet weak var leagueName: UILabel!
    
    @IBOutlet weak var leagueImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        leagueImage.layer.cornerRadius = leagueImage.frame.height / 2
        leagueImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        leagueImage.layer.cornerRadius = leagueImage.frame.height / 2
    }

}
