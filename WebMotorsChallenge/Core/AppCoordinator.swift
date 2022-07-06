//
//  AppCoordinator.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 28/06/22.
//

import Foundation
import UIKit

class AppCoordinator {
    
    let window: UIWindow
    private lazy var vehiclesServiceContract = VehicleService()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let controller = makeVehiclesListViewController()
        let navigation = UINavigationController(rootViewController: controller)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
    
    func makeVehiclesListViewController() -> VehiclesViewController {
        .init(viewModel: .init(vehiclesServiceContract))
    }
    
    func makeVehicleDetailViewController(vehicle: Vehicle) -> VehicleDetailViewController {
        .init(vehicle: vehicle)
    }
}
