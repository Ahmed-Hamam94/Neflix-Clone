//
//  ApiResponse.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 03/10/2023.
//

import Foundation

struct ApiResponse<T: Codable>: Codable {
    let dates: [String:String]? 
    let page: Int?
    let results: T?  
    let totalPages: Int?
    let totalResults: Int?
    
}
