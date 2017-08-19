//
//  YoutubeAPI.swift
//  TestMusic
//
//  Created by Guilherme Lisboa on 09/04/17.
//  Copyright © 2017 LDevelopment. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Moya_ObjectMapper

protocol YoutubeApi {
    func searchPlaylist(name: String) -> Observable<[YouTubePlaylist]>
}

struct YoutubeNetworkAPI: YoutubeApi {
    
    private let provider = RxMoyaProvider<YouTubeTarget>()
    private let disposeBag = DisposeBag()
    
    func searchPlaylist(name: String) -> Observable<[YouTubePlaylist]>{
        return provider.request(.search(text: name))
            .mapObject(YoutubeSearchData.self)
            .map { $0.items }
    }
}
