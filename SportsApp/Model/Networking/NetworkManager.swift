//
//  NetworkManager.swift
//  SportsApp
//
//  Created by mac on 16/05/2025.
//

import Foundation
import Alamofire

protocol NetworkProtocol: AnyObject {
    func fetchLeagues(sport: String, completionHandler: @escaping (SportResult?) -> Void)
    func fetchLeagueTeams(sport : String, leagueid: Int, completionHandler: @escaping (StandingResponse?) -> Void)
    func fetchLeagueFixtures(sport: String, leagueid: Int, from: String, to: String, completionHandler: @escaping (EventResponse?) -> Void)
}

class NetworkManager: NetworkProtocol {
    
    func fetchLeagueFixtures(sport: String, leagueid: Int, from: String, to: String, completionHandler: @escaping (EventResponse?) -> Void) {
        let urlString = "\(ApiStrings.baseURL)\(sport.lowercased())/?met=\(ApiStrings.fixture)&APIkey=\(ApiStrings.apiKey)&from=\(from)&to=\(to)&leagueId=\(leagueid)"
        
        AF.request(urlString).responseDecodable(of: EventResponse.self) { response in
            switch response.result {
            case .success(let eventResult):
                completionHandler(eventResult)
                print("Alamofire Success for \(sport) fixtures:", eventResult)
            case .failure(let error):
                print("Alamofire Error for \(sport) fixtures:", error.localizedDescription)
                completionHandler(nil)
            }
        }
    }
    
    
    func fetchLeagueTeams(sport: String, leagueid: Int, completionHandler: @escaping (StandingResponse?) -> Void) {
        let urlString = "\(ApiStrings.baseURL)\(sport.lowercased())/?met=\(ApiStrings.standing)&APIkey=\(ApiStrings.apiKey)&leagueId=\(leagueid)"
        
        AF.request(urlString).responseDecodable(of: StandingResponse.self) { response in
            switch response.result {
            case .success(let standingsResult):
                completionHandler(standingsResult)
                print("Alamofire Success for \(sport):", standingsResult)
            case .failure(let error):
                print("Alamofire Error for \(sport):", error.localizedDescription)
                completionHandler(nil)
            }
        }
    }
    
    func fetchLeagues(sport: String, completionHandler: @escaping (SportResult?) -> Void) {
        let urlString = "\(ApiStrings.baseURL)\(sport.lowercased())/?met=\(ApiStrings.leagues)&APIkey=\(ApiStrings.apiKey)"
        
        AF.request(urlString).responseDecodable(of: SportResult.self) { response in
            switch response.result {
            case .success(let sportResult):
                completionHandler(sportResult)
            case .failure(let error):
                print("Alamofire Error for \(sport):", error.localizedDescription)
                completionHandler(nil)
            }
        }
    }
    
}

class ApiStrings{
    static let baseURL = "https://apiv2.allsportsapi.com/"
    static let apiKey = "e190ccd24249ea8aef7d8f5dc27dcbe838fe013d45fdec54999cf53ca951b55a"
    static let leagues = "Leagues"
    static let standing = "Standings"
    static let fixture = "Fixtures"
}
