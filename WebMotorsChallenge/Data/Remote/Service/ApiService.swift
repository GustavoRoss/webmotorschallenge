//
//  ApiService.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 28/06/22.
//

import Foundation
import Moya

class ApiService<T: TargetType>: MoyaProvider<T>  {
    
    init() {
        let config = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let plugin = NetworkLoggerPlugin(configuration: config)
        super.init(plugins: [plugin])
    }
}
