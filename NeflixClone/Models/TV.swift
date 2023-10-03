//
//  TV.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 03/10/2023.
//

import Foundation

struct Trending_TV: Codable {

    let page: Int?
    let results: [TV]?
    let totalPages: Int?
    let totalResults: Int?

    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

}

struct TV: Codable {

    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let name: String?
    let originalLanguage: String?
    let originalName: String?
    let overview: String?
    let posterPath: String?
    let mediaType: String?
    let genreIds: [Int]?
    let popularity: Double?
    let firstAirDate: String?
    let voteAverage: Double?
    let voteCount: Int?
    let originCountry: [String]?

    private enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case id = "id"
        case name = "name"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview = "overview"
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIds = "genre_ids"
        case popularity = "popularity"
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originCountry = "origin_country"
    }

}
