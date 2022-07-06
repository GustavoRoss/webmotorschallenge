//
//  Environment.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 28/06/22.
//

import Foundation

internal enum Environment: String {
    case debug
    case release
}

internal extension Environment {
    
    static let baseUrl: URL = infoForKey("BASE_URL").url
    
    static var current: Environment {
        #if DEBUG
            return .debug
        #endif
        #if RELEASE
            return .release
        #endif
    }

    static func infoForKey(_ key: String) -> String {
        return Bundle.main.infoDictionary?[key] as? String ?? ""
    }
}
