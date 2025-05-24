import UIKit

class TeamCell: UICollectionViewCell {
    
    @IBOutlet weak var index: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamPoints: UILabel!
    @IBOutlet weak var teamWins: UILabel!
    @IBOutlet weak var teamPts: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupConstraints()
    }
    
    private func setupConstraints() {
        // Ensure Auto Layout is enabled
        [index, teamName, teamLogo, teamPoints, teamWins, teamPts].forEach {
            $0?.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            // Position index at 5% of cell width
            index.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            index.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            index.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1),
            
            // Logo next to index
            teamLogo.leadingAnchor.constraint(equalTo: index.trailingAnchor, constant: 8),
            teamLogo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            teamLogo.widthAnchor.constraint(equalToConstant: 30),
            teamLogo.heightAnchor.constraint(equalToConstant: 30),
            
            // Team name after logo
            teamName.leadingAnchor.constraint(equalTo: teamLogo.trailingAnchor, constant: 8),
            teamName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            teamName.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            
            // --- Fix for even spacing between last 3 labels ---
            // Make them align to the trailing edge, equally spaced
            teamPts.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            teamPts.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            teamWins.trailingAnchor.constraint(equalTo: teamPts.leadingAnchor, constant: -32), // Increased spacing for clarity
            teamWins.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            teamPoints.trailingAnchor.constraint(equalTo: teamWins.leadingAnchor, constant: -32), // Increased spacing for clarity
            teamPoints.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
