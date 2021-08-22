//
//  Service.swift
//  LoodosCase
//
//  Created by Oguz Demırhan on 22.08.2021.
//

import Foundation
import Alamofire

class Service {
    
    static let shared = Service()
    
    func searchMovies(with query: String,completionHandler: @escaping (SearchModel) -> ()){
        AF.request(Constants.baseURL + "?apikey=" + Constants.apiKey + "&s=\(query)").responseDecodable(of:SearchModel.self) { response in
            
            switch response.result {
            case .success(let model):
                completionHandler(model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
