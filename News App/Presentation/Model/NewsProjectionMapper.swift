//
//  NewsPresentationMapper.swift
//  News App
//
//  Created by Александр Малышев on 14.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation


extension News {
    public func toNewsItemProjection() -> NewsProjection.NewsItem {
        return NewsProjection.NewsItem(title: title,
                                       date: date,
                                       description: description,
                                       url: url,
                                       imageUrl: imageUrl,
                                       content: content,
                                       sourceName: source?.name,
                                       author: author,
                                       isBookmarked: isBookmarked
        )
    }
}

extension NewsProjection.NewsItem{
    public func toDomain() -> News {
        return News(title: title,
                    date: date,
                    author: author,
                    description: description,
                    url: url,
                    imageUrl: imageUrl,
                    content: content,
                    source: NewsSource(name: sourceName)
        )
    }
}
