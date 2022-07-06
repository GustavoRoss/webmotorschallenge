//
//  VehiclesViewModel.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 28/06/22.
//

import Foundation
import Combine

class VehiclesViewModel: BaseViewModel {
    
    private(set) var vehicles: [Vehicle] = []
    private var vehicleServiceContract: VehicleServiceContract
    private var initialPaginationKey = 1
    
    private (set) lazy var refresh = PassthroughSubject<Bool, Never>()
    private (set) lazy var pagingLoading = PassthroughSubject<Bool, Never>()
    
    private lazy var vehiclesPaginator: DefaultPaginator<Int, Vehicle> = DefaultPaginator<Int, Vehicle>(
        initialKey: initialPaginationKey,
        onLoadUpdated: { [unowned self] loading in
            pagingLoading.send(!loading)
        },
        onRequest: { [unowned self] nextKey in
            vehicleServiceContract.vehicles(page: nextKey)
        },
        getNextKey: { [unowned self] in initialPaginationKey + 1 },
        onError: { [unowned self] error in
            if let error = error {
                handleError(error: error)
            }
        },
        onSuccess: { [unowned self] vehicles, newKey in
            initialPaginationKey = newKey
            self.vehicles.append(contentsOf: vehicles)
            refresh.send(true)
        },
        cancellableBag: cancellable
    )
    
    init(_ vehicleServiceContract: VehicleServiceContract) {
        self.vehicleServiceContract = vehicleServiceContract
    }
    
    func loadMore() {
        vehiclesPaginator.loadNextItems()
    }
}
