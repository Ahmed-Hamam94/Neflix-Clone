//
//  SearchMovies.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 05/10/2023.
//

import Foundation

protocol SearchProtocol{
    func getSearchMovies(completion: @escaping ((Result<[Movie], APIError>)->Void))
    
    func getSearchResult(with query: String, completion: @escaping ((Result<[Movie], APIError>)->Void))
}

class SearchMovies: SearchProtocol{
    
    func getSearchMovies(completion: @escaping ((Result<[Movie], APIError>) -> Void)) {
        NetworkManager.shared.request(endPoint: EndPoint.discoverMovie, method: .Get, completion: completion)
    }
    
    func getSearchResult(with query: String, completion: @escaping ((Result<[Movie], APIError>)->Void)){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return} // take resposibility for replacing the white space with the %20 
        NetworkManager.shared.request(endPoint: EndPoint.search(query), method: .Get, completion: completion)
    }
}
