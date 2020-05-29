//
//  MainViewModel.swift
//  News App
//
//  Created by Александр Малышев on 13.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import RxSwift

protocol IRecentNewsViewModel: class {
    func getRecentNews() -> Single<Array<NewsProjection.NewsItem>>
}

class RecentNewsViewModel: IRecentNewsViewModel {
    
    private var getRecentNewsUseCase: IGetRecentNewsUseCase
    
    init(getRecentNewsUseCase: IGetRecentNewsUseCase) {
        self.getRecentNewsUseCase = getRecentNewsUseCase
    }
    
    func getRecentNews() -> Single<Array<NewsProjection.NewsItem>> {
        return getRecentNewsUseCase.execute()
            .debug()
            .map{ news -> Array<NewsProjection.NewsItem> in
                news.map { newsItem -> NewsProjection.NewsItem in newsItem.toNewsItemProjection() }
            }
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
    }
    
}
