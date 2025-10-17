//
//  CounterViewModel.swift
//  ConflictFreeReplicatedDataType
//
//  Created by Angelos Staboulis on 17/10/25.
//

import Foundation
import Combine

class CounterViewModel: ObservableObject {
    @Published private(set) var counter: GCounter
    private var timer: AnyCancellable?
    
    init(localId: String) {
        self.counter = GCounter(localId: localId)
        simulateRemoteSync()
    }
    
    var value: Int {
        counter.value
    }
    
    func increment() {
        counter.increment()
        objectWillChange.send()
    }
    
    /// Simulate syncing with a remote device
    func simulateRemoteSync() {
        timer = Timer.publish(every: 5, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                let fakeRemote = self.generateFakeRemoteCounter()
                self.counter.merge(with: fakeRemote)
                self.objectWillChange.send()
            }
    }
    
    private func generateFakeRemoteCounter() -> GCounter {
        var remote = GCounter(localId: "remoteDevice")
        remote.increment()
        return remote
    }
}
