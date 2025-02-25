//
//  MotionManager.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 25/02/25.
//

import CoreMotion

class MotionManager: ObservableObject {
    private var motionManager: CMMotionManager
    @Published var pitch: Double = 0.0
    @Published var roll: Double = 0.0
    
    init() {
        motionManager = CMMotionManager()
        
        guard motionManager.isDeviceMotionAvailable else { return }
        
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
            guard let data else { return }
            DispatchQueue.main.async {
                self?.pitch = data.attitude.pitch
                self?.roll = data.attitude.roll
            }
        }
    }
    
    deinit {
        motionManager.stopDeviceMotionUpdates()
    }
}
