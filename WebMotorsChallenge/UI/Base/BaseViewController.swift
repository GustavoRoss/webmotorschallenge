//
//  BaseViewController.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 28/06/22.
//

import Foundation
import Combine
import UIKit

class BaseViewController: UIViewController {
    var cancellable = Set<AnyCancellable>()
    
    var baseViewModel: BaseViewModel? {
        return nil
    }
    
    private lazy var activityView = UIActivityIndicatorView(style: .large).apply {
        $0.center = view.center
        $0.color = .white
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "Loading this view controller from a nib is unsupported.")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view controller from a nib is unsupported.")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.96, alpha: 1.00)
        setupViews()
        setupNavigationBar()
        observeLoading()
        observeError()
    }
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(red: 0.78, green: 0.00, blue: 0.22, alpha: 1.00)
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
    }
    
    private func setupViews() {
        view.addSubview(activityView)
    }
    
    private func observeLoading() {
        baseViewModel?
            .isLoading
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] isLoading in
                if(isLoading) {
                    activityView.startAnimating()
                } else {
                    activityView.stopAnimating()
                }
            }).store(in: &cancellable)
    }
    
    private func observeError() {
        baseViewModel?
            .onMessage
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] message in
                showDialogInfo(title: message.title, message: message.description)
            }).store(in: &cancellable)
    }
    
    private func showDialogInfo(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    deinit {
        cancellable.removeAll()
    }
}
