//
//  VehiclesViewController.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 28/06/22.
//

import Foundation
import UIKit

class VehiclesViewController: BaseViewController {
    
    private lazy var loadingFooter = LoadingFooter()
    
    private lazy var vehiclesList = UITableView().apply {
        $0.dataSource = self
        $0.delegate = self
        $0.separatorStyle = .none
        $0.register(cellClass: VehicleCell.self)
        $0.tableFooterView = loadingFooter
    }
    
    override var baseViewModel: BaseViewModel? { viewModel }
    private let viewModel: VehiclesViewModel
    
    init(viewModel: VehiclesViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "vehicles".localized
        setupConstraints()
        viewModel.loadMore()
        observeEvents()
    }
    
    func observeEvents() {
        viewModel
            .pagingLoading
            .receive(on: DispatchQueue.main)
            .assign(to: \.isHidden, on: loadingFooter)
            .store(in: &cancellable)
        
        viewModel
            .refresh
            .receive(on: DispatchQueue.main)
            .sink(onSuccess: { [unowned self] _ in
                self.vehiclesList.reloadData()
            }, onFailure: { error in  })
            .store(in: &cancellable)
    }
    
    func setupConstraints() {
        view.addSubview(view: vehiclesList) { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension VehiclesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.vehicles[indexPath.row]
        let viewController = coordinator.makeVehicleDetailViewController(vehicle: item)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(with: VehicleCell.self, for: indexPath).apply {
            $0.bind(vehicle: viewModel.vehicles[indexPath.row])
        }
    }
}

extension VehiclesViewController: UITableViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y + scrollView.frame.size.height
        let contentSizeHeight = scrollView.contentSize.height - 200
        if (offsetY > contentSizeHeight) {
            viewModel.loadMore()
        }
    }
}
