//
//  VehicleApi.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 28/06/22.
//

import Foundation
import Moya

enum VehicleApi {
    case vehicles(page: Int)
}

extension VehicleApi: TargetType {
    var baseURL: URL {
        return Environment.baseUrl
    }
    
    var path: String {
        switch self {
        case .vehicles:
            return "Vehicles"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .vehicles:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .vehicles(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    
}

