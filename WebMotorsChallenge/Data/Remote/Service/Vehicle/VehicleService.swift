//
//  VehicleService.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 28/06/22.
//

import Foundation
import Combine
import Moya

protocol VehicleServiceContract {
    func vehicles(page: Int) -> AnyPublisher<[Vehicle], MoyaError>
}

class VehicleService: VehicleServiceContract {
    private let api = ApiService<VehicleApi>()
    
    func vehicles(page: Int) -> AnyPublisher<[Vehicle], MoyaError> {
        return api.requestPublisher(.vehicles(page: page)).map([Vehicle].self)
    }
}
