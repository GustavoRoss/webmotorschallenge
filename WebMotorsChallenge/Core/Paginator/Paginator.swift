//
//  Paginator.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 28/06/22.
//

import Foundation
import Combine
import Moya

protocol Paginator {
    func loadNextItems()
    func reset()
}

class DefaultPaginator<Key, Item>: Paginator {
    
    private var initialKey: Key
    private var onLoadUpdated: ((Bool) -> Void)
    private var onRequest: ((Key) -> AnyPublisher<[Item], MoyaError>)
    private var getNextKey: (() -> Key)
    private var onError:  ((Error?) -> Void)
    private var onSuccess: ((_ items: [Item], _ newKey: Key) -> Void)
    private var cancellable = Set<AnyCancellable>()
    private lazy var currentKey: Key = self.initialKey
    private var isMakingRequest = false
    private var stopRequest = false
    
    init(
        initialKey: Key,
        onLoadUpdated: @escaping ((Bool) -> Void),
        onRequest: @escaping ((Key) -> AnyPublisher<[Item], MoyaError>),
        getNextKey: @escaping (() -> Key),
        onError:  @escaping ((Error?) -> Void),
        onSuccess: @escaping ((_ items: [Item], _ newKey: Key) -> Void),
        cancellableBag: Set<AnyCancellable>
    ) {
        self.initialKey = initialKey
        self.onLoadUpdated = onLoadUpdated
        self.onRequest = onRequest
        self.getNextKey = getNextKey
        self.onError = onError
        self.onSuccess = onSuccess
        self.cancellable = cancellableBag
    }
    
    func loadNextItems() {
        if isMakingRequest || stopRequest {
            return
        }
        
        onRequest(currentKey)
            .handleEvents(receiveSubscription: { [unowned self] _ in
                isMakingRequest = true
                onLoadUpdated(true)
            }, receiveCompletion: { [unowned self] _ in
                isMakingRequest = false
                onLoadUpdated(false)
            }, receiveCancel: { [unowned self] in
                isMakingRequest = false
            }).sink(onSuccess: { [unowned self] items in
                if items.isEmpty {
                    stopRequest = true
                    onSuccess(items, currentKey)
                } else {
                    currentKey = getNextKey()
                    onSuccess(items, currentKey)
                }
            }, onFailure: { [unowned self] error in
                onError(error)
            }).store(in: &cancellable)
        
    }
    
    func reset() {
        stopRequest = false
        currentKey = initialKey
    }
    
}
