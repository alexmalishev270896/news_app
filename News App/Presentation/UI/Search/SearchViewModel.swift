//
//  SearchViewModel.swift
//  News App
//
//  Created by Александр Малышев on 18.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ISearchViewModel{
    var searchResult: Driver<ViewState<[NewsProjection.NewsItem]>> { get }
    func search(by query: String)
}

class SearchViewModel: ISearchViewModel{
    
    var searchResult: Driver<ViewState<[NewsProjection.NewsItem]>>{
        return mSearchResult.asDriver()
    }
    
    private let searchNewsUseCase: ISearchNewsUseCase
    private var searchDisposable: Disposable?
    private var mSearchResult = BehaviorRelay<ViewState<[NewsProjection.NewsItem]>>(value: .loading)
    private var schedulerProvider: ISchedulerProvider
    
    init(searchUseCase: ISearchNewsUseCase, schedulerProvider: ISchedulerProvider) {
        self.searchNewsUseCase = searchUseCase
        self.schedulerProvider = schedulerProvider
    }
    
    func search(by query: String) {
        searchDisposable?.dispose()
        if (query.count < 3) {
            mSearchResult.accept(.success([]))
            return
        }
        searchDisposable = searchNewsUseCase.execute(query)
            .map{ news -> [NewsProjection.NewsItem] in
                news.map{ newsItem -> NewsProjection.NewsItem in
                    newsItem.toNewsItemProjection()
                }
            }
            .subscribeOn(schedulerProvider.io())
            .observeOn(schedulerProvider.ui())
            .do(onSubscribe: { [weak mSearchResult] in mSearchResult?.accept(.loading) })
            .subscribe(
                    onSuccess: { [weak mSearchResult] news in
                        mSearchResult?.accept(.success(news))
                    },
                    onError: { [weak mSearchResult] error in
                        mSearchResult?.accept(.error)
                    })
    }
}
