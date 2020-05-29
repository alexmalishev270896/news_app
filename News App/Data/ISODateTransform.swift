//
//  ISODateTransform.swift
//  News App
//
//  Created by Александр Малышев on 15.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import ObjectMapper

open class ISODateTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String

    public init() {}

    public func transformFromJSON(_ value: Any?) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let strValue = value as? String else { return nil }
        return formatter.date(from: strValue)
    }

    public func transformToJSON(_ value: Date?) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        guard value != nil else { return nil }
        return formatter.string(from: value!)
    }
    
}
