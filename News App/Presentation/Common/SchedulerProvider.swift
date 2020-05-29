//
//  SchedulerProvider.swift
//  News App
//
//  Created by Александр Малышев on 20.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import RxSwift

protocol ISchedulerProvider {
    func io() -> SchedulerType
    func ui() -> SchedulerType
    func trampoline() -> ImmediateSchedulerType
}

class SchedulerProvider: ISchedulerProvider{
    func io() -> SchedulerType {
        return ConcurrentDispatchQueueScheduler(qos: .background)
    }
    
    func ui() -> SchedulerType {
        return MainScheduler.instance
    }
    
    func trampoline() -> ImmediateSchedulerType {
        return CurrentThreadScheduler.instance
    }
}
