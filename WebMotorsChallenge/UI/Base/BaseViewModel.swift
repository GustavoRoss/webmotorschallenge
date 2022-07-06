//
//  BaseViewModel.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 28/06/22.
//

import Foundation

import Combine

class BaseViewModel {
    
    internal var cancellable = Set<AnyCancellable>()
    
    private(set) var onMessage = PassthroughSubject<AlertInfo, Never>()
    private(set) var isLoading = PassthroughSubject<Bool, Never>()

    func handleError(error: Error) {
        onMessage.send(AlertInfo(title: "Error", description: error.localizedDescription))
    }
    
    func setMessage(title: String, message: String) {
        onMessage.send(AlertInfo(title: title, description: message))
    }
    
    func handleLoading(loading: Bool) {
        isLoading.send(loading)
    }
    
    deinit {
        cancellable.removeAll()
    }
}
