//
//  AsyncSemaphore.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 27/02/25.
//

import Foundation

actor AsyncSemaphore {
    private var permits: Int
    private var waitQueue: [CheckedContinuation<Void, Never>] = []
    
    init(permits: Int) {
        self.permits = permits
    }
    
    func wait() async {
        if permits > 0 {
            permits -= 1
        } else {
            await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
                waitQueue.append(continuation)
            }
        }
    }
    
    func signal() {
        if !waitQueue.isEmpty {
            let continuation = waitQueue.removeFirst()
            continuation.resume()
        } else {
            permits += 1
        }
    }
}
