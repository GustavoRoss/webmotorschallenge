//
//  Combine+Extensions.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 28/06/22.
//

import Foundation
import Combine

extension Publisher {
    func loading(_ isLoading: PassthroughSubject<Bool, Never>) -> Publishers.HandleEvents<Self> {
        return self.handleEvents(receiveSubscription: { _ in
            isLoading.send(true)
        }, receiveOutput: { _ in
            
        }, receiveCompletion: { _ in
            isLoading.send(false)
        }, receiveCancel: {
            
        }, receiveRequest: { _ in
            
        })
    }
    
    func sink(onSuccess: @escaping (Self.Output) -> Void, onFailure: @escaping (Error) -> Void) -> AnyCancellable {
           return self.sink { completion in
               guard case let .failure(error) = completion else { return }
               onFailure(error)
           } receiveValue: { output in
               onSuccess(output)
           }
       }

}
