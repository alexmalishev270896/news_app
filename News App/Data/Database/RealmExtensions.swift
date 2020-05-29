//
//  RealmExtension.swift
//  News App
//
//  Created by Александр Малышев on 19.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import RxSwift

extension Reactive where Base == Realm {
    func save<R: Object>(entity: R, update: Base.UpdatePolicy = Base.UpdatePolicy.all) -> Observable<R>  {
        return Observable.create { observer in
            do {
                try self.base.write {
                    self.base.add(entity, update: update)
                }
                observer.onNext(entity)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func save<R: Object>(entities: [R], update: Base.UpdatePolicy = Base.UpdatePolicy.all) -> Observable<[R]>  {
        return Observable.create { observer in
            do {
                try self.base.write {
                    for entity in entities{
                        self.base.add(entity, update: update)
                    }
                }
                observer.onNext(entities)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func delete<R: Object>(entity: R, by primaryKey: Any) -> Observable<R> {
        return Observable.create { observer in
            do {
                guard let object = self.base.object(ofType: R.self, forPrimaryKey: primaryKey) else { fatalError() }
                try self.base.write {
                    self.base.delete(object)
                }
                observer.onNext(entity)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}

