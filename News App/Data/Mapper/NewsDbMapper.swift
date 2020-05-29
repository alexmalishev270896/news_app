//
//  NewsDbMapper.swift
//  News App
//
//  Created by Александр Малышев on 19.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation


extension NewsEntity{
    func toDomain() -> News{
        return News(title: title,
                    date: date,
                    author: author,
                    description: annotation,
                    url: url,
                    imageUrl: imageUrl,
                    content: content,
                    source: NewsSource(name: sourceName)
        )
    }
}

extension News{
    func toDbEntity() -> NewsEntity {
        let entity = NewsEntity()
        entity.title = title
        entity.date = date
        entity.author = author
        entity.annotation = description
        entity.url = url
        entity.imageUrl = imageUrl
        entity.content = content
        entity.sourceName = source?.name ?? ""
        return entity
    }
}
