//
//  Popular.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 03/10/2023.
//

import Foundation

protocol PopularProtocol {
    func getPopularMovies(completion: @escaping (Result<[Movie], APIError>)-> Void)
}

class PopularMovies: PopularProtocol {
    
    func getPopularMovies(completion: @escaping (Result<[Movie], APIError>) -> Void) {
        NetworkManager.shared.request(endPoint: EndPoint.popular, method: .Get, completion: completion)
    }
    
    
}
