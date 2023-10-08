//
//  YoutubeSearch.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 06/10/2023.
//

import Foundation

protocol YoutubeSearchProtocol {
    func get_YoutubeSearch(query: String, completion: @escaping (Result<YoutubeSearchResults, APIError>) -> Void)
}

class YoutubeSearch {
    
    static func get_YoutubeSearch(query: String, completion: @escaping (Result<VideoElement, APIError>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return} // take resposibility for replacing the white space with the %20
        
        
        
        guard let url = "https://youtube.googleapis.com/youtube/v3/search?q=\(query)&key=AIzaSyA8CRyDWcd4qcfSKagCNlcYsVg3k1dEtoA".asUrl else {
            completion(.failure(.urlBadFormmated))
            return}
        let request = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                print("Error")
                completion(.failure(.internalError))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                completion(.failure(.serverError))
                           return
                           }
           // print(response)
                           print("Response status code: \(response.statusCode)")
            
                           guard let data = data else {
                               print("no data")
                    completion(.failure(.unknownError))
                    return
                }
                           
                           do {
                    let decoder = JSONDecoder()
                               let response = try decoder.decode(YoutubeSearchResults.self, from: data)
                               let result = response.items[0]
                              
                    completion(.success(result))
                    
                }catch{
                    completion(.failure(.parsingError))
                }
                           
                           }
                           task.resume()
                           
                           
                           }
                           
                           
                           }
