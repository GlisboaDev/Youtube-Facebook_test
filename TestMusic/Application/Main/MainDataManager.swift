//
//  LoginDataManager.swift
//  TestMusic
//
//  Created by Guilherme Lisboa on 09/04/17.
//  Copyright © 2017 LDevelopment. All rights reserved.
//

import Foundation
import FacebookLogin
import FacebookCore
import RxSwift

protocol MainScreenManager {
    var playlists: Observable<[YouTubePlaylist]> { get }
    func loadUserPlaylists()
}

class MainScreenDataManager: MainScreenManager {
    
    private let youtubeAPI: YoutubeApi
    private var userMusic = [UserMusic]()
    private var loadedPlaylists = [YouTubePlaylist]()
    private let disposeBag = DisposeBag()
    private let _playLists = PublishSubject<[YouTubePlaylist]>()
    var playlists: Observable<[YouTubePlaylist]> {
        return _playLists.asObservable()
    }
    
    init(youtubeAPI: YoutubeApi = YoutubeNetworkAPI()) {
        self.youtubeAPI = youtubeAPI
        loadUserFbLikes().do(onNext: { (_) in
            self.loadUserPlaylists()
        }).subscribe().addDisposableTo(disposeBag)
    }
    
    func loadPlaylistsWithLimit(value: Int, playlists: [YouTubePlaylist]) -> Observable<[YouTubePlaylist]> {
        guard userMusic.count > 0 && playlists.count < value else {
            loadedPlaylists.append(contentsOf: playlists)
            _playLists.onNext(loadedPlaylists)
            return Observable.just(loadedPlaylists)
        }
        let music = userMusic.remove(at: 0)
        return youtubeAPI.searchPlaylist(name: music.name)
            .flatMap { self.loadPlaylistsWithLimit(value: value, playlists: playlists + $0) }
    }
    
    func loadUserPlaylists(){
        
        loadPlaylistsWithLimit(value: 50, playlists: []).subscribe().addDisposableTo(disposeBag)
    }
    
    private func loadUserFbLikes() -> Observable<[UserMusic]>{

        return Observable.create({ (observer) -> Disposable in
            
            let connection = GraphRequestConnection()
            connection.add(GraphRequest(graphPath: "/me/music")) { httpResponse, result in
                switch result {
                case .success(let response):
                    
                    let music = self.parseMusicDictionary(dictionary: response.dictionaryValue ?? [:])

                    self.userMusic = music
                    
                    observer.onNext(music)
                case .failed(_):
                    observer.onError(AppError.fetchFailed)
                }
            }
            connection.start()
            
            return Disposables.create()
        })
    }
    
    //This should be moved to a real parser and deal in a safer way.
    private func parseMusicDictionary(dictionary: Dictionary<String, Any>) -> [UserMusic] {
        if let musics = dictionary.first?.value as? Array<Dictionary<String,Any>> {
            return musics.map({ (musicDict) -> UserMusic in
                let id = musicDict["id"] as? String ?? ""
                let name = musicDict["name"] as? String ?? ""
                
                
                return UserMusic(name: name, id: id)
            })
        }
        return []
    }
}
