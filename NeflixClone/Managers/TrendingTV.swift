//
//  TrendingTV.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 03/10/2023.
//

import Foundation


protocol TrendingTvProtocol {
    func getTrendingTV(completion: @escaping (Result<[TV], APIError>)-> Void)
}

class TrendingTV: TrendingTvProtocol{
    
    func getTrendingTV(completion: @escaping (Result<[TV], APIError>) -> Void) {
        NetworkManager.shared.request(endPoint: EndPoint.trendingTV, method: .Get, completion: completion)
    }
    
    
}
