//
//  YouTubeTarget.swift
//  TestMusic
//
//  Created by Guilherme Lisboa on 09/04/17.
//  Copyright © 2017 LDevelopment. All rights reserved.
//

import Foundation
import Moya

enum YouTubeTarget: TargetType {

    case search(text: String)
    
    var baseURL: URL {
        return URL(string: "https://www.googleapis.com/youtube/v3")!
    }
    var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .request
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .search(let text):
            return ["part": "snippet",
                    "q": text,
                    "type":"playlist",
                    "key": "AIzaSyD3_ArBKBJLTmHpvPQEB62IvQGlEnHn1As",
                    "maxResults": 50
            ]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}
