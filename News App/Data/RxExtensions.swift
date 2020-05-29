//
//  RxExtensions.swift
//  News App
//
//  Created by Александр Малышев on 13.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import ObjectMapper

extension ObservableType{
    public func mapObject<T: BaseMappable>(type: T.Type) -> Observable<T> {
        return flatMap { (data) -> Observable<T> in
            guard
                let json = (data as? DataResponse<Any>)?.result.value,
                let object = Mapper<T>().map(JSONObject: json) else {
                throw NSError(
                    domain: "",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
                )
            }

            return Observable.just(object)
        }
    }

    public func mapArray<T: BaseMappable>(type: T.Type) -> Observable<[T]> {
        return flatMap { data -> Observable<[T]> in
            guard
                let json = (data as? DataResponse<Any>)?.result.value,
                let objects = Mapper<T>().mapArray(JSONObject: json) else {
                throw NSError(
                    domain: "",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
                )
            }

            return Observable.just(objects)
        }
    }
}
