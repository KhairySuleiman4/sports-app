//
//  NetworkManager.swift
//  SportsApp
//
//  Created by mac on 16/05/2025.
//

//
//  NetworkManager.swift
//  Product_App
//
//  Created by mac on 14/05/2025.
//

import Foundation
import Alamofire



protocol NetworkProtocol: AnyObject {
    func fetchDataFromJSON(sport: String, completionHandler: @escaping (SportResult?) -> Void)
}

class NetworkManager: NetworkProtocol {
    func fetchDataFromJSON(sport: String, completionHandler: @escaping (SportResult?) -> Void) {
        let baseURL = "https://apiv2.allsportsapi.com/"
        let apiKey = "e190ccd24249ea8aef7d8f5dc27dcbe838fe013d45fdec54999cf53ca951b55a"
        let urlString = "\(baseURL)\(sport.lowercased())/?met=Leagues&APIkey=\(apiKey)"
        
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
