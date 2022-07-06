//
//  VehicleCell.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 29/06/22.
//

import Foundation
import UIKit

class VehicleCell: UITableViewCell {
    
    private lazy var card = UIView().apply {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
    }
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        contentView.addSubview(view: card, onViewAdded: { make in
            make.edges.equalToSuperview().inset(16)
        })
        
        card.addSubview(view: mainStack, onViewAdded: {make in
            make.edges.equalToSuperview()
        })
        
        image.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(250)
        }
        
        card.addSubview(view: priceLayer, onViewAdded: { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().inset(220)
            make.height.equalTo(50)
            make.width.equalTo(200)
        })
       
        priceLayer.addSubview(view: priceLabel, onViewAdded: { make in
            make.left.equalToSuperview().inset(32)
            make.top.bottom.equalToSuperview()
        })
        
    }
    
    func bind(vehicle: Vehicle) {
        image.load(from: vehicle.image)
        priceLabel.text = vehicle.priceFormatted
        km.text = String(vehicle.km)
        color.text = vehicle.color
        yearModelFab.text = "\(vehicle.yearFab)/\(vehicle.yearModel)"
        nameLabel.text = "\(vehicle.model) \(vehicle.version)"
    }
}
