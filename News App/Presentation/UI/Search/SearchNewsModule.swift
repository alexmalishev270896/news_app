//
//  SearchNewsModule.swift
//  News App
//
//  Created by Александр Малышев on 18.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation

class SearchNewsConfigurator: BaseConfigurator<SearchViewController>{
    
    override func configure(with viewController: SearchViewController) {
        let newsDao = NewsDao()
        let newsLocalSource = NewsLocalSource(newsDao: newsDao)
        let newsRemoteSource = NewsRemoteSource()
        let newsRepository = NewsRepository(remoteSource: newsRemoteSource, newsLocalSource: newsLocalSource)
        let useCase = SearchNewsUseCase(repository: newsRepository)
        viewController.viewModel = SearchViewModel(searchUseCase: useCase)
    }
}
