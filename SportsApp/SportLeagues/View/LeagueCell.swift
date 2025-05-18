//
//  LeagueCell.swift
//  SportsApp
//
//  Created by Khairy on 16/05/2025.
//

import UIKit
protocol LeagueCellDelegate: AnyObject {
    func didTapFavoriteButton(in cell: LeagueCell)
}

class LeagueCell: UITableViewCell {

    @IBOutlet weak var leagueName: UILabel!
    
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var leagueImage: UIImageView!
    
    weak var delegate: LeagueCellDelegate?
            
            var isFavorited: Bool = false {
                didSet {
                    updateFavoriteButton()
                }
            }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            
            leagueImage.layer.cornerRadius = leagueImage.frame.height / 2
            leagueImage.layer.masksToBounds = true
        }
        private func updateFavoriteButton() {
                let imageName = isFavorited ? "heart.fill" : "heart"
                favouriteButton.setImage(UIImage(systemName: imageName), for: .normal)
            }

    @IBAction func favButton(_ sender: Any) {
                        isFavorited.toggle()
                        updateFavoriteButton()
                        delegate?.didTapFavoriteButton(in: self)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            leagueImage.layer.cornerRadius = leagueImage.frame.height / 2
        }

    }
