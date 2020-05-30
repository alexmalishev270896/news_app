//
//  MainViewModel.swift
//  News App
//
//  Created by Александр Малышев on 13.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol IRecentNewsViewModel: class {
    var recentNews: Driver<ViewState<[NewsProjection.NewsItem]>> { get }
    func getRecentNews()
}

class RecentNewsViewModel: IRecentNewsViewModel {
    
    var recentNews: Driver<ViewState<[NewsProjection.NewsItem]>>{
        return mRecentNews.asDriver()
    }
    
    private var mRecentNews = BehaviorRelay<ViewState<[NewsProjection.NewsItem]>>(value: .loading)
    private var getRecentNewsUseCase: IGetRecentNewsUseCase
    private let schedulerProvider: ISchedulerProvider
    private let disposeBag = DisposeBag()
    
    init(getRecentNewsUseCase: IGetRecentNewsUseCase,
         schedulerProvider: ISchedulerProvider) {
        self.getRecentNewsUseCase = getRecentNewsUseCase
        self.schedulerProvider = schedulerProvider
    }
    
    func getRecentNews(){
        getRecentNewsUseCase.execute()
            .debug()
            .map{ news -> Array<NewsProjection.NewsItem> in
                news.map { newsItem -> NewsProjection.NewsItem in newsItem.toNewsItemProjection() }
            }
            .subscribeOn(schedulerProvider.io())
            .observeOn(schedulerProvider.ui())
            .subscribe(
                onSuccess: { news in
                    self.mRecentNews.accept(ViewState.success(news))
                },
                onError: { error in
                    self.mRecentNews.accept(ViewState.error)
                })
            .disposed(by: disposeBag)
    }
}
