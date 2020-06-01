//
//  NewsDetailViewModel.swift
//  News App
//
//  Created by Александр Малышев on 18.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol INewsDetailViewModel {
    var newsDetail: Driver<ViewState<NewsProjection.NewsItem>> { get }
    func saveNews(news: NewsProjection.NewsItem)
    func deleteNews(news: NewsProjection.NewsItem)
    func checkExists(news: NewsProjection.NewsItem)
}

class NewsDetailViewModel : INewsDetailViewModel{
    private let checkNewsExistsUseCase: ICheckNewsExistsUseCase
    private let saveNewsUseCase: ISaveNewsUseCase
    private let deleteNewsUseCase: IDeleteNewsUseCase
    private let schedulerProvider: ISchedulerProvider
    private let disposeBag = DisposeBag()
    
    private let mNewsDetails = BehaviorRelay<ViewState<NewsProjection.NewsItem>>(value: ViewState.loading)
    
    init(checkNews: ICheckNewsExistsUseCase,
         saveNews: ISaveNewsUseCase,
         deleteNews: IDeleteNewsUseCase,
         provider: ISchedulerProvider) {
        self.checkNewsExistsUseCase = checkNews
        self.saveNewsUseCase = saveNews
        self.deleteNewsUseCase = deleteNews
        self.schedulerProvider = provider
    }
    
    var newsDetail: Driver<ViewState<NewsProjection.NewsItem>> {
        return mNewsDetails.asDriver()
    }
    
    func saveNews(news: NewsProjection.NewsItem) {
        Single.just(news)
            .map{ news in news.toDomain() }
            .flatMap{ news -> Single<News> in self.saveNewsUseCase.execute(news: news) }
            .map{ news in news.toNewsItemProjection() }
            .subscribeOn(schedulerProvider.io())
            .observeOn(schedulerProvider.ui())
            .subscribe(
                onSuccess: { [weak mNewsDetails] news in
                    mNewsDetails?.accept(ViewState.success(news))
                },
                onError: { [weak mNewsDetails] error in
                    mNewsDetails?.accept(ViewState.error)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func deleteNews(news: NewsProjection.NewsItem) {
        Single.just(news)
            .map{ news in news.toDomain() }
            .flatMap{ news -> Single<News> in self.deleteNewsUseCase.execute(news: news) }
            .map{ news in news.toNewsItemProjection() }
            .subscribeOn(schedulerProvider.io())
            .observeOn(schedulerProvider.ui())
            .subscribe(
                onSuccess: { [weak mNewsDetails] news in
                    mNewsDetails?.accept(ViewState.success(news))
                },
                onError: { [weak mNewsDetails] error in
                    mNewsDetails?.accept(ViewState.error)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func checkExists(news: NewsProjection.NewsItem) {
        Single.just(news)
            .map{ news in news.toDomain() }
            .flatMap{ news -> Single<News> in self.checkNewsExistsUseCase.execute(news: news) }
            .map{ news in news.toNewsItemProjection() }
            .subscribeOn(schedulerProvider.io())
            .observeOn(schedulerProvider.ui())
            .subscribe(
                onSuccess: { [weak mNewsDetails] news in
                    mNewsDetails?.accept(ViewState.success(news))
                },
                onError: { [weak mNewsDetails] error in
                    mNewsDetails?.accept(ViewState.error)
                }
            )
            .disposed(by: disposeBag)
    }
}
