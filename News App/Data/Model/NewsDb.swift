//
//  NewsDb.swift
//  News App
//
//  Created by Александр Малышев on 19.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import RealmSwift

class NewsEntity: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var date: Date? = nil
    @objc dynamic var author: String = ""
    @objc dynamic var annotation: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var imageUrl: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var sourceName: String = ""
    
    override class func primaryKey() -> String? {
        return "url"
    }
}
