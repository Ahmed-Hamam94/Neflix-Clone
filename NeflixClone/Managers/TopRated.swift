//
//  TopRated.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 04/10/2023.
//

import Foundation

protocol TopRatedProtocol {
    func getTopRated(completion: @escaping (Result<[Movie], APIError>)-> Void)
}

class TopRated: TopRatedProtocol {
    
    func getTopRated(completion: @escaping (Result<[Movie], APIError>) -> Void) {
        NetworkManager.shared.request(endPoint: EndPoint.topRated, method: .Get, completion: completion)
    }
    
    
    
}
