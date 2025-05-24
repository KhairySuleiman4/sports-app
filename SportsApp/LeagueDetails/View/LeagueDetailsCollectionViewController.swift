

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
    let blueColor = UIColor(red: 32/255, green: 72/255, blue: 209/255, alpha: 0.1)
    
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
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsSelection = true
        
        
        configure(sport: sport, leagueId: leagueId)
        presenter.viewDidLoad()

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.collectionView.setCollectionViewLayout(self?.createLayout() ?? UICollectionViewLayout(), animated: true)
            self?.collectionView.collectionViewLayout.invalidateLayout()
        })
    }
    
    func configure(sport: String, leagueId: Int) {
            presenter = LeagueDetailsPresenter(view: self, sport: sport, leagueId: leagueId)
    }

    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil ?? NSCollectionLayoutSection(group: NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)), subitems: [])) }
            
            let availableSections = self.getAvailableSections()
            let sectionType = availableSections[sectionIndex]
            
            let section: NSCollectionLayoutSection
            switch sectionType {
            case .upcoming:
                section = self.drawUpEventSection()
            case .latest:
                section = self.drawUpEventSection()
            case .teams:
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
        let availableSections = getAvailableSections()
        guard section < availableSections.count else { return "" }
        
        switch availableSections[section] {
        case .upcoming:
            return "Upcoming Events"
        case .latest:
            return "Latest Events"
        case .teams:
            return "Teams"
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let availableSections = getAvailableSections()
        let sectionType = availableSections[indexPath.section]
        
        switch sectionType {
        case .upcoming, .latest:
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: eventHeaderIdentifier,
                for: indexPath) as! EventsHeader
            
            headerView.EventsHeaderLable.text = headerTitle(for: indexPath.section)
            headerView.EventsHeaderLable.font = .systemFont(ofSize: 18, weight: .bold)
            headerView.EventsHeaderLable.textColor = .black
            headerView.EventsHeaderLable.frame = CGRect(x: 16, y: 0, width: headerView.bounds.width - 32, height: headerView.bounds.height)
            
            return headerView
            
        case .teams:
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: teamsHeaderIdentifier,
                for: indexPath) as! TeamsHeader
            
            let fontSize: CGFloat = 16
            [headerView.TeamLable, headerView.PosLable, headerView.PointsLable,
             headerView.PtsLable, headerView.WinsLable].forEach {
                $0?.font = .systemFont(ofSize: fontSize, weight: .medium)
                $0?.translatesAutoresizingMaskIntoConstraints = false
            }
            
            let teamsCount = presenter.getTeamsCount()
            for i in 0..<teamsCount {
                if let teamCell = collectionView.cellForItem(at: IndexPath(item: i, section: indexPath.section)) as? TeamCell {
                    teamCell.index.center.x = headerView.PosLable.center.x
                }
                
                if let teamCell = collectionView.cellForItem(at: IndexPath(item: i, section: indexPath.section)) as? TeamCell {
                    headerView.TeamLable.center.x = teamCell.teamName.center.x
                }
            
                
                if let teamCell = collectionView.cellForItem(at: IndexPath(item: i, section: indexPath.section)) as? TeamCell {
                    headerView.PointsLable.center.x = teamCell.teamPoints.center.x
                }
                
                if let teamCell = collectionView.cellForItem(at: IndexPath(item: i, section: indexPath.section)) as? TeamCell {
                    headerView.WinsLable.center.x = teamCell.teamWins.center.x
                }
                
                if let teamCell = collectionView.cellForItem(at: IndexPath(item: i, section: indexPath.section)) as? TeamCell {
                    headerView.PtsLable.center.x = teamCell.teamPts.center.x
                }
                
            }
            
            // Add bottom border
            let bottomBorder = CALayer()
            bottomBorder.frame = CGRect(x: 0, y: headerView.frame.size.height - 1,
                                      width: headerView.frame.size.width, height: 1.0)
            bottomBorder.backgroundColor = blueColor.cgColor
            headerView.layer.addSublayer(bottomBorder)
            
            return headerView
        }
    }
    
    private func configureTeamsHeader(_ headerView: TeamsHeader) {
        // Setup fonts
        
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
        var sectionCount = 0
        
        if presenter.getUpcomingEventsCount() > 0 { sectionCount += 1 }
        if presenter.getLatestEventsCount() > 0 { sectionCount += 1 }
        if presenter.getTeamsCount() > 0 { sectionCount += 1 }
        
        return sectionCount
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let availableSections = getAvailableSections()
        let sectionType = availableSections[section]
        
        switch sectionType {
        case .upcoming:
            return presenter.getUpcomingEventsCount()
        case .latest:
            return presenter.getLatestEventsCount()
        case .teams:
            return presenter.getTeamsCount()
        }
    }
    
    private enum SectionType {
        case upcoming
        case latest
        case teams
    }

    private func getAvailableSections() -> [SectionType] {
        var sections: [SectionType] = []
        
        if presenter.getUpcomingEventsCount() > 0 { sections.append(.upcoming) }
        if presenter.getLatestEventsCount() > 0 { sections.append(.latest) }
        if presenter.getTeamsCount() > 0 { sections.append(.teams) }
        
        return sections
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = getAvailableSections()[indexPath.section]
        
        switch sectionType {
        case .upcoming:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventIdentifier, for: indexPath) as! EventCell
            if let event = presenter.getUpcomingEvent(at: indexPath.row) {
                configureEventCell(cell: cell, with: event)
            }
            return cell
            
        case .latest:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventIdentifier, for: indexPath) as! EventCell
            if let event = presenter.getLatestEvent(at: indexPath.row) {
                configureEventCell(cell: cell, with: event)
            }
            return cell
            
        case .teams:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamIdentifier, for: indexPath) as! TeamCell
            if let team = presenter.getTeam(at: indexPath.row) {
                // Calculate spacing and columnWidth as in the header
                let spacing: CGFloat = isLandscape() ? 8 : 20
                let containerWidth = cell.bounds.width - (2 * spacing)
                let columnWidth = containerWidth / 5
                configureTeamCell(cell: cell, with: team, spacing: spacing, columnWidth: columnWidth)
            }
            return cell
        }
    }
    
    private func isLandscape() -> Bool {
        return UIScreen.main.bounds.width > UIScreen.main.bounds.height
    }
    
    private func configureEventCell(cell: EventCell, with event: EventModel) {
        setupEventNames(cell: cell, event: event)
        setupTeamImages(cell: cell, event: event)
        applyEventCellStyle(cell: cell)
    }

    private func setupEventNames(cell: EventCell, event: EventModel) {
        switch sport.lowercased() {
        case "tennis":
            cell.firstTeamName.text = event.firstPlayer
            cell.secondTeamName.text = event.secondPlayer
        default:
            cell.firstTeamName.text = event.eventHomeTeam
            cell.secondTeamName.text = event.eventAwayTeam
        }
        cell.matchScore.text = event.eventFinalResult
    }

    private func setupTeamImages(cell: EventCell, event: EventModel) {
        switch sport.lowercased() {
        case "tennis":
            configureImageView(cell.firstTeamImg, defaultImage: "avatar")
            configureImageView(cell.secondTeamImg, defaultImage: "avatar")
        case "cricket":
            configureImageView(cell.firstTeamImg, imageURL: event.eventHomeTeamLogo)
            configureImageView(cell.secondTeamImg, imageURL: event.eventAwayTeamLogo)
        default:
            configureImageView(cell.firstTeamImg, imageURL: event.homeTeamLogo)
            configureImageView(cell.secondTeamImg, imageURL: event.awayTeamLogo)
        }
    }

    private func configureImageView(_ imageView: UIImageView, imageURL: String? = nil, defaultImage: String = "avatar") {
        if let url = imageURL, !url.isEmpty {
            imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: defaultImage))
        } else {
            imageView.image = UIImage(named: defaultImage)
        }
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = blueColor.cgColor
        imageView.clipsToBounds = true
    }

    private func applyEventCellStyle(cell: EventCell) {
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.systemGray5.cgColor
        cell.backgroundColor = blueColor
        cell.layer.cornerRadius = 8.0
        cell.clipsToBounds = false
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 4
        cell.layer.shadowOpacity = 0.2
    }

    private func configureTeamCell(cell: TeamCell, with team: Total, spacing: CGFloat, columnWidth: CGFloat) {
        cell.teamName.text = team.standingTeam
        cell.index.text = "\(team.standingPlace ?? 0)"
        
        // Configure stats
        cell.teamPoints.text = team.standingP == nil ? "-" : "\(team.standingP!)"
        cell.teamWins.text = team.standingW == nil ? "-" : "\(team.standingW!)"
        cell.teamPts.text = team.standingPTS == nil ? "-" : "\(team.standingPTS!)"
        
        // Configure team logoviewForSupplementaryElementOfKind
        if let logoUrlString = team.teamLogo,
           !logoUrlString.isEmpty,
           let logoUrl = URL(string: logoUrlString) {
            cell.teamLogo?.sd_setImage(with: logoUrl, placeholderImage: UIImage(named: "avatar"))
        } else {
            cell.teamLogo?.image = UIImage(named: "avatar")
        }
    }

    
    private func drawTeamsSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(75))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.interGroupSpacing = 0
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
        
        return section
    }
    
    private func drawUpEventSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let isLandscape = UIScreen.main.bounds.width > UIScreen.main.bounds.height
        let groupWidth: CGFloat = isLandscape ? 0.85 : 0.9
        let groupHeight: CGFloat = isLandscape ? 0.6 : 0.2
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupWidth),
            heightDimension: .fractionalHeight(groupHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        return section
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = getAvailableSections()[indexPath.section]
        var sportLowercased = sport.lowercased()
        switch sectionType {
        case .teams:
            if (sportLowercased == "tennis" || sportLowercased == "basketball") {
                if let player = presenter.getTeam(at: indexPath.row) {
                    showAlert(
                        title: "\(sportLowercased.capitalized) Player Info",
                        message: "Detailed statistics for \(player.standingTeam ?? "this player") are not available."
                    )
                } else {
                    showAlert(
                        message: "Detailed statistics for \(sportLowercased) players are not available."
                    )
                }
                return
            }
            
            if let team = presenter.getTeam(at: indexPath.row) {
                navigateToTeamDetails(with: team)
                
            }
        default:
            break
        }
    }

    private func navigateToTeamDetails(with team: Total) {
        
        if let teamDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as? TeamDetailsViewController {
            teamDetailsVC.teamId = team.teamKey
            teamDetailsVC.sport = self.sport
            self.navigationController?.pushViewController(teamDetailsVC, animated: true)
            teamDetailsVC.title = "Team Details"
        }
    }
    
    private func showAlert(title: String? = nil, message: String) {
        let alertController = UIAlertController(
            title: title ?? "Information",
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }
    
}
