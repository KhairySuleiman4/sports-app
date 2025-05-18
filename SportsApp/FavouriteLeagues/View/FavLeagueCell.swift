//
//  FavLeagueCell.swift
//  SportsApp
//
//  Created by mac on 16/05/2025.
//

import UIKit

class FavLeagueCell: UITableViewCell {

    @IBOutlet weak var favLeagueImage: UIImageView!
    @IBOutlet weak var favLeagueName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favLeagueImage.layer.cornerRadius = favLeagueImage.frame.height / 2
        favLeagueImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        favLeagueImage.layer.cornerRadius = favLeagueImage.frame.height / 2
    }

}
