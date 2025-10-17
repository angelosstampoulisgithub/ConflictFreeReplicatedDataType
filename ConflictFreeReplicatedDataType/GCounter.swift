//
//  GCounter.swift
//  ConflictFreeReplicatedDataType
//
//  Created by Angelos Staboulis on 17/10/25.
//

import Foundation
struct GCounter {
    var localId: String
    private var counts: [String: Int] = [:]
    
    init(localId: String) {
        self.localId = localId
        self.counts[localId] = 0
    }
    
    var value: Int {
        counts.values.reduce(0, +)
    }
    
    mutating func increment() {
        counts[localId, default: 0] += 1
    }
    
    mutating func merge(with other: GCounter) {
        for (id, otherValue) in other.counts {
            let currentValue = counts[id, default: 0]
            counts[id] = max(currentValue, otherValue)
        }
    }
    
    func toDictionary() -> [String: Int] {
        counts
    }
    
    static func fromDictionary(_ dict: [String: Int], localId: String) -> GCounter {
        var counter = GCounter(localId: localId)
        counter.counts = dict
        return counter
    }
}

