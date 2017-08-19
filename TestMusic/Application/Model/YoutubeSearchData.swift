//
//  YoutubeSearchData.swift
//  TestMusic
//
//  Created by Guilherme Lisboa on 09/04/17.
//  Copyright © 2017 LDevelopment. All rights reserved.
//

import Foundation
import ObjectMapper

struct YoutubeSearchData: Mappable {
    
    var items = [YouTubePlaylist]()
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        items <- map["items"]
    }
}
