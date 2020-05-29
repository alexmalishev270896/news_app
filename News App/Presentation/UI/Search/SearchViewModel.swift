//
//  SearchViewModel.swift
//  News App
//
//  Created by Александр Малышев on 18.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import RxSwift

protocol ISearchViewModel{
    func search(by query: String) -> Single<[NewsProjection.NewsItem]>
}

class SearchViewModel: ISearchViewModel{
    
    private let searchNewsUseCase: ISearchNewsUseCase
    
    init(searchUseCase: ISearchNewsUseCase) {
        self.searchNewsUseCase = searchUseCase
    }
    
    func search(by query: String) -> Single<[NewsProjection.NewsItem]> {
        return searchNewsUseCase.execute(query)
            .map{ news -> [NewsProjection.NewsItem] in
                news.map{ newsItem -> NewsProjection.NewsItem in
                    newsItem.toNewsItemProjection()
                }
            }
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
    }
}
