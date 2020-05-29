//
//  NewsRemoteSource.swift
//  News App
//
//  Created by Александр Малышев on 13.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire

protocol INewsRemoteSource {
    func getRecentNews() -> Single<NewsAPI.NewsListResponse>
    func everithing(_ query: String) -> Single<NewsAPI.NewsListResponse>
}

class NewsRemoteSource : INewsRemoteSource{
    
    private let session = ApiManager.shared.sessionManager
    
    func getRecentNews() -> Single<NewsAPI.NewsListResponse> {
        return session.rx.request(.get, url(to: "top-headlines?country=us"))
            .responseJSON()
            .debug()
            .mapObject(type: NewsAPI.NewsListResponse.self)
            .asSingle()
    }
    
    func everithing(_ query: String) -> Single<NewsAPI.NewsListResponse> {
        return session.rx.request(.get, url(to: "everything?q=\(query)"))
            .responseJSON()
            .debug()
            .mapObject(type: NewsAPI.NewsListResponse.self)
            .asSingle()
    }
}
