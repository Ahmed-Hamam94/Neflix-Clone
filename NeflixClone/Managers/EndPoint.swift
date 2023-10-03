//
//  EndPoint.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 02/10/2023.
//

import Foundation

enum EndPoint {
    
    static let base_url = "https://api.themoviedb.org/3/"
    static let api_Key = "e27be58b7f04e76351c5710ebe9c4daf"
    
   // trending/all/day?api_key=\(EndPoint.api_Key)
    
    case trendingMovie
    case trendingTV
    case upComing
    case popular
    case topRated
    case discoverMovie
    case search(String)
    

    //"https://api.themoviedb.org/3/movie/upcoming?api_key=e27be58b7f04e76351c5710ebe9c4daf&?language=en-US&page=1"
    var path: String{
        switch self{
        case .trendingMovie:
            return "trending/movie/day?api_key=\(EndPoint.api_Key)"
        case .trendingTV:
            return "trending/tv/day?api_key=\(EndPoint.api_Key)"
        case .upComing:
            return "movie/upcoming?api_key=\(EndPoint.api_Key)"
        case .popular:
            return "movie/popular?api_key=\(EndPoint.api_Key)"
        case .topRated:
            return "movie/top_rated/?api_key=\(EndPoint.api_Key)"
        case .discoverMovie:
            return "discover/movie/day?api_key=\(EndPoint.api_Key)"
        case .search(let query):
            return "search/movie/day?api_key=\(EndPoint.api_Key)&query=\(query)"
        }


    }
}

//https://api.themoviedb.org/3/movie/top_rated?api_key=e27be58b7f04e76351c5710ebe9c4daf
