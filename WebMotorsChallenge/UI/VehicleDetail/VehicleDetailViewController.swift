//
//  VehicleDetailViewController.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 06/07/22.
//

import Foundation
import UIKit
import SnapKit

class VehicleDetailViewController: BaseViewController {
    
    private lazy var image = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private lazy var priceLabel = UILabel().apply {
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private lazy var nameLabel = UILabel().apply {
        $0.textColor = .black
        $0.sizeToFit()
        $0.numberOfLines = 0
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    private lazy var yearModelFab = UILabel().apply {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    private lazy var km = UILabel().apply {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    private lazy var color = UILabel().apply {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    
    private lazy var mainStack = UIStackView(arrangedSubviews: [
        image, nameLabel, vehicleInfoStack
    ]).apply {
        $0.axis = .vertical
        $0.spacing = 32
    }
    
    private lazy var vehicleInfoStack = UIStackView(arrangedSubviews: [
        yearModelFab, km, color
    ]).apply {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    
    private lazy var priceLayer = PriceLayer(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
    private var vehicle: Vehicle!
    
    init(vehicle: Vehicle) {
        self.vehicle = vehicle
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "vehicleDetail".localized
        setupConstraints()
        setupView()
    }
    
    func setupConstraints() {
        view.addSubview(view: mainStack, onViewAdded: {make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        })
        
        image.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(250)
        }
        
        view.addSubview(view: priceLayer, onViewAdded: { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().inset(310)
            make.height.equalTo(50)
            make.width.equalTo(200)
        })
       
        priceLayer.addSubview(view: priceLabel, onViewAdded: { make in
            make.left.equalToSuperview().inset(32)
            make.top.bottom.equalToSuperview()
        })
        
        nameLabel.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(16)
        }
        
    }
    
    func setupView() {
        image.load(from: vehicle.image)
        priceLabel.text = vehicle.priceFormatted
        km.text = String(vehicle.km)
        color.text = vehicle.color
        yearModelFab.text = "\(vehicle.yearFab)/\(vehicle.yearModel)"
        nameLabel.text = "\(vehicle.model) \(vehicle.version)"
    }
}
