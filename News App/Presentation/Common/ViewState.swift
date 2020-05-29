//
//  ViewState.swift
//  News App
//
//  Created by Александр Малышев on 20.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation


enum ViewState<T> {
    case loading
    case success(T)
    case error
}
