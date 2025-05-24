//
//  SportLeaguesViewController.swift
//  SportsApp
//
//  Created by Khairy on 16/05/2025.
//


import UIKit
import SDWebImage
import CoreData

protocol SportLeaguesViewProtocol: AnyObject {
    func updateLeagues(_ leagues: [Sport])
    func showError(title: String, message: String)
}

class SportLeaguesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SportLeaguesViewProtocol, LeagueCellDelegate  {
    @IBOutlet weak var leaguesTable: UITableView!
    
    private var leagues: [Sport] = [] {
        didSet {
            leaguesTable.reloadData()
        }
    }
    
    private var presenter: SportsLeaguesPresenterProtocol!
    var sportName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        leaguesTable.reloadData()
    }
    
    private func setupPresenter() {
        let networkManager = NetworkManager()
        presenter = SportsLeaguesPresenter(networkManager: networkManager, view: self)
        presenter.fetchSportLeagues(for: sportName)
    }
    
    private func setupUI() {
        leaguesTable.delegate = self
        leaguesTable.dataSource = self
    }
    
    private func navigateToLeagueDetails(with league: Sport) {
        guard let detailsVC = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsCollectionViewController") as? LeagueDetailsCollectionViewController else { return }
        detailsVC.sport = sportName!
        detailsVC.leagueId = league.leagueKey
        detailsVC.title = "League Details"
        navigationController?.pushViewController(detailsVC, animated: true)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCell
        let league = leagues[indexPath.row]
        presenter.configureCell(cell, with: league)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToLeagueDetails(with: leagues[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    func didTapFavoriteButton(in cell: LeagueCell) {
        guard let indexPath = leaguesTable.indexPath(for: cell) else { return }
        let league = leagues[indexPath.row]
        
        if presenter.isLeagueFavorite(id: league.leagueKey) {
            presenter.handleFavoriteRemoval(for: league, cell: cell)
        } else {
            presenter.handleFavoriteAddition(for: league, cell: cell)
        }
    }
    
    
    func updateLeagues(_ leagues: [Sport]) {
        self.leagues = leagues
    }
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}
