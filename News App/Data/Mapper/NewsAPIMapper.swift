//
//  NewsMapper.swift
//  News App
//
//  Created by Александр Малышев on 13.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation

extension NewsAPI.NewsSourceResponse{
    public func toDomain() -> NewsSource{
        return NewsSource(id: id ?? "",
                          name: name ?? "",
                          description: description ?? "",
                          url: url ?? "",
                          category: category ?? "",
                          language: language ?? "",
                          country: country ?? "")
    }
}

extension NewsAPI.NewsResponse{
    public func toDomain() -> News{
        return News(title: title,
                    date: publishedAt,
                    author: author ?? "",
                    description: description ?? "",
                    url: url ?? "" ,
                    imageUrl: urlToImage ?? "" ,
                    content: content ?? "",
                    source: source?.toDomain()
        )
    }
}

extension NewsAPI.NewsListResponse {
    public func toDomainArray() -> Array<News>{
        return articles?.map { newsResponse -> News in
            newsResponse.toDomain()
        } ?? []
    }
}
