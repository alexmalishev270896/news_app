//
//  BookmarksViewModel.swift
//  News App
//
//  Created by Александр Малышев on 20.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol IBookmarksViewModel {
    var bookmarks: Driver<ViewState<[NewsProjection.NewsItem]>> { get }
    func getBookmarks()
}

class BookmarksViewModel: IBookmarksViewModel{
    private let getSavedNewsUseCase: IGetSavedNewsUseCase
    private let mBookmarks = BehaviorRelay<ViewState<[NewsProjection.NewsItem]>>(value: .loading)
    private let schedulerProvider: ISchedulerProvider
    private let disposeBag = DisposeBag()
    
    init(savedNewsUseCase: IGetSavedNewsUseCase, schedulerProvider: ISchedulerProvider) {
        self.getSavedNewsUseCase = savedNewsUseCase
        self.schedulerProvider = schedulerProvider
    }
    
    var bookmarks: Driver<ViewState<[NewsProjection.NewsItem]>> {
        return mBookmarks.asDriver()
    }
    
    func getBookmarks() {
        getSavedNewsUseCase.execute()
            .map{ news in news.map{ newsItem in newsItem.toNewsItemProjection() }.reversed()}
            .subscribeOn(schedulerProvider.io())
            .observeOn(schedulerProvider.ui())
            .subscribe(
                onSuccess: { [weak mBookmarks] news in
                    mBookmarks?.accept(ViewState.success(news))
                },
                onError: { [weak mBookmarks] error in
                    mBookmarks?.accept(ViewState.error)
                }
            )
            .disposed(by: disposeBag)
        
    }
}
