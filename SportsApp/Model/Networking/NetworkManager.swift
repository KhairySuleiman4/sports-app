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
    func fetchLeagueTeams(sport: String, leagueid: Int, completionHandler: @escaping (StandingResponse?) -> Void)
    func fetchLeagueFixtures(sport: String, leagueid: Int, from: String, to: String, completionHandler: @escaping (EventResponse?) -> Void)
}

class NetworkManager: NetworkProtocol {
    private func fetch<T: Decodable>(urlString: String, completionHandler: @escaping (T?) -> Void) {
        AF.request(urlString).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let result):
                completionHandler(result)
            case .failure(let error):
                print("Network Error:", error.localizedDescription)
                completionHandler(nil)
            }
        }
    }
    
    func fetchLeagues(sport: String, completionHandler: @escaping (SportResult?) -> Void) {
        let urlString = URLBuilder.buildURL(sport: sport, endpoint: ApiStrings.leagues)
        fetch(urlString: urlString, completionHandler: completionHandler)
    }
    
    func fetchLeagueTeams(sport: String, leagueid: Int, completionHandler: @escaping (StandingResponse?) -> Void) {
        let urlString = URLBuilder.buildURL(sport: sport, endpoint: ApiStrings.standing,
                                          queryParams: ["leagueId": String(leagueid)])
        fetch(urlString: urlString, completionHandler: completionHandler)
    }
    
    func fetchLeagueFixtures(sport: String, leagueid: Int, from: String, to: String, completionHandler: @escaping (EventResponse?) -> Void) {
        var params = ["from": from, "to": to]
        let idKey = sport.lowercased() == "tennis" ? "league_key" : "leagueId"
        params[idKey] = String(leagueid)
        
        let urlString = URLBuilder.buildURL(sport: sport, endpoint: ApiStrings.fixture, queryParams: params)
        fetch(urlString: urlString, completionHandler: completionHandler)
    }
}

class URLBuilder {
    static func buildURL(sport: String, endpoint: String, queryParams: [String: String] = [:]) -> String {
        var urlString = "\(ApiStrings.baseURL)\(sport.lowercased())/?met=\(endpoint)&APIkey=\(ApiStrings.apiKey)"
        for (key, value) in queryParams {
            urlString += "&\(key)=\(value)"
        }
        return urlString
    }
} 

class ApiStrings {
    static let baseURL = "https://apiv2.allsportsapi.com/"
    static let apiKey = "e190ccd24249ea8aef7d8f5dc27dcbe838fe013d45fdec54999cf53ca951b55a"
    static let leagues = "Leagues"
    static let standing = "Standings"
    static let fixture = "Fixtures"
}
