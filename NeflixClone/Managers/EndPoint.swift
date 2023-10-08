//
//  EndPoint.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 02/10/2023.
//

import Foundation

enum EndPoint {
    
    static let base_url = "https://api.themoviedb.org/3/"
    static let youtubeBase_Url = "https://youtube.googleapis.com/youtube/v3/"
    static let api_Key = "e27be58b7f04e76351c5710ebe9c4daf"
    static let youtubeApi_Key = "AIzaSyA8CRyDWcd4qcfSKagCNlcYsVg3k1dEtoA"
    
   // https://youtube.googleapis.com/youtube/v3/search?q=harry&key=[YOUR_API_KEY]
    
    case trendingMovie
    case trendingTV
    case upComing
    case popular
    case topRated
    case discoverMovie
    case search(String)
    case youtube_Search(String)
    

    //"https://youtube.googleapis.com/youtube/v3/search?q=harry&key=[YOUR_API_KEY]

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
            return "discover/movie?api_key=\(EndPoint.api_Key)"
        case .search(let query):
            return "search/movie?api_key=\(EndPoint.api_Key)&query=\(query)"
        case .youtube_Search(let query):
            return "search?q=\(query)&key=\(EndPoint.youtubeApi_Key)"
    
        }


    }
}


//"https://api.themoviedb.org/3/discover/movie?api_key=e27be58b7f04e76351c5710ebe9c4daf?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc"
