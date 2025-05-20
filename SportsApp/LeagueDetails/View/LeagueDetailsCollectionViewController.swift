

import UIKit


class LeagueDetailsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, LeagueDetailsView {
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private var presenter: LeagueDetailsPresenter!
    private let teamIdentifier = "TeamCell"
    private let eventIdentifier = "EventCell"
    private let eventHeaderIdentifier = "EventsHeader"
    private let teamsHeaderIdentifier = "TeamsHeader"
    var sport : String = ""
    var leagueId : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: teamIdentifier, bundle: nil),
                              forCellWithReuseIdentifier: teamIdentifier)
        collectionView.register(UINib(nibName: eventIdentifier, bundle: nil),
                                forCellWithReuseIdentifier: eventIdentifier)
        collectionView.register(UINib(nibName: eventHeaderIdentifier, bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: eventHeaderIdentifier)
        
        collectionView.register(UINib(nibName: teamsHeaderIdentifier, bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: teamsHeaderIdentifier)
        
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
        configure(sport: sport, leagueId: leagueId)
        presenter.viewDidLoad()

    }
    
    func configure(sport: String, leagueId: Int) {
            presenter = LeagueDetailsPresenter(view: self, sport: sport, leagueId: leagueId)
    }

    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil ?? NSCollectionLayoutSection(group: NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)), subitems: [])) }
            
            let section: NSCollectionLayoutSection
            switch sectionIndex {
            case 0:
                section = self.drawUpcomingMatchesSection()
            case 1:
                section = self.drawLatestMatchesSection()
            case 2:
                section = self.drawTeamsSection()
            default:
                section = self.drawTeamsSection()
            }
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            section.boundarySupplementaryItems = [header]
            return section
        }
    }
    
    private func headerTitle(for section: Int) -> String {
            switch section {
            case 0:
                return "Upcoming Events"
            case 1:
                return "Latest Events"
            default:
                return ""
            }
        }
    
    
    override func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section < 2 {
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: eventHeaderIdentifier,
                    for: indexPath) as! EventsHeader
                
                headerView.EventsHeaderLable.text = headerTitle(for: indexPath.section)
                headerView.EventsHeaderLable.font = .systemFont(ofSize: 18, weight: .bold)
                headerView.EventsHeaderLable.textColor = .black
                headerView.EventsHeaderLable.frame = CGRect(x: 16, y: 0, width: headerView.bounds.width - 32, height: headerView.bounds.height)
                
                return headerView
            } else {
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: teamsHeaderIdentifier,
                    for: indexPath) as! TeamsHeader
                
                return headerView
            }
        }
        return UICollectionReusableView()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return presenter.getUpcomingEventsCount()}
        if section == 1 { return presenter.getLatestEventsCount()}
        return presenter.getTeamsCount()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventIdentifier, for: indexPath) as! EventCell
                if let event = presenter.getUpcomingEvent(at: indexPath.row) {
                    if sport.lowercased() == "tennis" {
                        cell.firstTeamName.text = event.firstPlayer
                        cell.secondTeamName.text = event.secondPlayer
                    }else{
                        cell.firstTeamName.text = event.eventHomeTeam
                        cell.secondTeamName.text = event.eventAwayTeam
                    }

                    cell.firstTeamImg.sd_setImage(with: URL(string: event.homeTeamLogo ?? ""), placeholderImage: UIImage(named: "placeholder"))
                    cell.secondTeamImg.sd_setImage(with: URL(string: event.awayTeamLogo ?? ""), placeholderImage: UIImage(named: "placeholder"))
                }
                return cell
                
            } else if indexPath.section == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventIdentifier, for: indexPath) as! EventCell
                if let event = presenter.getLatestEvent(at: indexPath.row) {
                    
                    if sport.lowercased() == "tennis" {
                        cell.firstTeamName.text = event.firstPlayer
                        cell.secondTeamName.text = event.secondPlayer
                    }else{
                        cell.firstTeamName.text = event.eventHomeTeam
                        cell.secondTeamName.text = event.eventAwayTeam
                    }
                    cell.firstTeamImg.sd_setImage(with: URL(string: event.homeTeamLogo ?? ""), placeholderImage: UIImage(named: "placeholder"))
                    cell.secondTeamImg.sd_setImage(with: URL(string: event.awayTeamLogo ?? ""), placeholderImage: UIImage(named: "placeholder"))
                }
                return cell
            }
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamIdentifier, for: indexPath) as! TeamCell
        
            if let team = presenter.getTeam(at: indexPath.row) {
                cell.teamName.text = team.standingTeam
                cell.index.text = "\(team.standingPlace ?? 0)"
                cell.teamPoints.text = "\(team.standingPTS ?? 0)"
                cell.teamWins.text = "\(team.standingW ?? 0)"
                cell.teamPts.text = "\(team.standingPTS ?? 0)"
                let url = URL(string: team.teamLogo ?? "")
                cell.teamLogo?.sd_setImage(with: url, placeholderImage: UIImage(named: "Football"))
        }
            
            return cell
    }
    
    private func drawTeamsSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        return section
    }
    
    private func drawUpcomingMatchesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        return section

    }
    
    private func drawLatestMatchesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        return section

    }

    
    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
