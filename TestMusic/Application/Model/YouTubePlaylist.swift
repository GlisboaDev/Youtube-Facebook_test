//
//  YouTubePlaylist.swift
//  TestMusic
//
//  Created by Guilherme Lisboa on 09/04/17.
//  Copyright © 2017 LDevelopment. All rights reserved.
//

import Foundation
import ObjectMapper

struct YouTubePlaylist: Mappable {
    
    var title: String = ""
    var imageUrl: String = ""
    
    init(title: String, imageUrl: String) {
        self.title = title
        self.imageUrl = imageUrl
    }
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        title <- map["snippet.title"]
        imageUrl <- map["snippet.thumbnails.default.url"]
    }
}
