//
//  ApiManager.swift
//  News App
//
//  Created by Александр Малышев on 13.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire

class ApiManager{
    static let API_URL = "http://newsapi.org/v2/"
    static let API_KEY = "cb2ed900351d4bf9ac59509b448cc82d"
    static var shared: ApiManager = {
        return ApiManager()
    }()
    var sessionManager: SessionManager
    private init(){
        sessionManager = SessionManager.default
        sessionManager.adapter = AuthorizationAdapter()
    }
}

class AuthorizationAdapter : RequestAdapter {
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue(ApiManager.API_KEY, forHTTPHeaderField: "X-Api-Key")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        return urlRequest
    }
}

public func url(to endpoint: String) -> String {
    return "\(ApiManager.API_URL)\(endpoint)"
}



