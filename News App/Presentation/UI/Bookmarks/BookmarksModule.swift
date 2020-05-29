//
//  BookmarksModule.swift
//  News App
//
//  Created by Александр Малышев on 20.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation

class BookmarksConfigurator: BaseConfigurator<BookmarksViewController>{
    
    override func configure(with viewController: BookmarksViewController) {
        let newsDao = NewsDao()
        let newsRemoteSource = NewsRemoteSource()
        let newsLocalSource = NewsLocalSource(newsDao: newsDao)
        let newsRepository = NewsRepository(remoteSource: newsRemoteSource, newsLocalSource: newsLocalSource)
        let savedNews = GetSavedNewsUseCase(repository: newsRepository)
        viewController.viewModel = BookmarksViewModel(savedNewsUseCase: savedNews, schedulerProvider: SchedulerProvider())
    }
}
