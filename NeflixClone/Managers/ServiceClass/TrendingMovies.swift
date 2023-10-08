//
//  ApiCaller.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 02/10/2023.
//

import Foundation

// let api_access_token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMjdiZTU4YjdmMDRlNzYzNTFjNTcxMGViZTljNGRhZiIsInN1YiI6IjY1MWIyMGQ5ZWE4NGM3MDE0ZWZjYzc5ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Ubi5QwRHDm3uECr8G3-Z3Kj9z8WAidQhQ2ymiAM88pM"


protocol TrendingMoviesProtocol {
    func getTrendingMovies(completion: @escaping (Result<[Movie], APIError>)-> Void)
}


class TrendingMovies: TrendingMoviesProtocol {
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], APIError>)-> Void){
        NetworkManager.shared.request(endPoint: EndPoint.trendingMovie, method: .Get, completion: completion)
    }
}
