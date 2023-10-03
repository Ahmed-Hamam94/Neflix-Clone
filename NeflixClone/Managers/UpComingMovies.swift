//
//  UpComingMovies.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 03/10/2023.
//

import Foundation

protocol upComingProtocol{
    func getUpComingMovies(completion: @escaping (Result<[ComingMovies], APIError>)->Void)
}

class upComingMovies: upComingProtocol {
    
    func getUpComingMovies(completion: @escaping (Result<[ComingMovies], APIError>) -> Void) {
        NetworkManager.shared.request(endPoint: EndPoint.upComing, method: .Get, completion: completion)
    }
 

}
