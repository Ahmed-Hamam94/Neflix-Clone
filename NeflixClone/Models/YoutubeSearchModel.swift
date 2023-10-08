//
//  YoutubeSearchModel.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 06/10/2023.
//

import Foundation

struct YoutubeSearchResults: Codable {
   // let items: [videoElement]
       let kind: String
        let etag: String
        let nextPageToken: String
        let regionCode: String
       // let pageInfo: PageInfo
        let items: [VideoElement]

        private enum CodingKeys: String, CodingKey {
            case kind = "kind"
            case etag = "etag"
            case nextPageToken = "nextPageToken"
            case regionCode = "regionCode"
           // case pageInfo = "pageInfo"
            case items = "items"
        }
}

struct VideoElement: Codable {
  //  let id: IdVideoElement
    
        let id: IdVideoElement

        private enum CodingKeys: String, CodingKey {
         
            case id = "id"
        }
}

struct IdVideoElement: Codable {

    let kind: String
    let videoId: String

    private enum CodingKeys: String, CodingKey {
        case kind = "kind"
        case videoId = "videoId"
    }

}
