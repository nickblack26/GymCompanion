//
//  MotionManager.swift
//  GymCompanion
//
//  Created by Nick on 10/19/23.
//

import Foundation
import CoreMotion
import Observation

@Observable
class MotionManager {
	// MARK: Constants
	let motion = CMMotionManager()
	let samplingRate = 30.0  // Number of samples per second (e.g., 30 samples in 1 second)
	let timeInterval = 1.0  // Time interval for data collection in seconds
	
	// MARK: State Variables
	var isCollectingMotion: Bool = false
	var collectedData = [CMAcceleration]()
	
	// lifting of the weight
	var concentricMovementDetected: Bool = false
	
	// lowering of the weight
	var eccentricMovementDetected: Bool = false
	
	var repDetected: Bool = false
	
	private func processCollectedData(data: [CMAcceleration], thresholdUp: Double, thresholdDown: Double, minimumThreshold: Double) {
		// Calculate the average magnitude of acceleration for the collected data
		let magnitudeSum = data.reduce(0.0) { $0 + $1.x * $1.x + $1.y * $1.y + $1.z * $1.z }
		let averageMagnitude = magnitudeSum / Double(data.count)
		
		if averageMagnitude >= thresholdUp {
			repDetected = false
			concentricMovementDetected = true
			print("Concentric Detected")
		} else if (averageMagnitude <= thresholdDown && averageMagnitude >= minimumThreshold) {
			repDetected = false
			eccentricMovementDetected = true
			print("Eccentric Detected")
		}
		
		if(eccentricMovementDetected && concentricMovementDetected) {
			repDetected = true
			eccentricMovementDetected = false
			concentricMovementDetected = false
		}
	}
		
	func startCollectingMotionData() {
		if motion.isDeviceMotionAvailable {
			isCollectingMotion = false
			self.motion.deviceMotionUpdateInterval = 1.0 / 30.0
			self.motion.showsDeviceMovementDisplay = true
			self.motion.startDeviceMotionUpdates(to: .main) { (motion, error) in
				guard let motionData = motion?.userAcceleration else {
					print("Error: Unable to get motion data")
					return
				}
				
				self.collectedData.append(motionData)
				
				if self.collectedData.count >= Int((self.samplingRate * self.timeInterval) / 2) {
					self.processCollectedData(data: self.collectedData, thresholdUp: 0.4, thresholdDown: 1.5, minimumThreshold: 0.2)
				}
				if self.collectedData.count >= Int(self.samplingRate * self.timeInterval) {
					self.collectedData.removeAll()
				}
			}
		}
	}
	
	func stopCollectingMotionData() {
		isCollectingMotion = false
		self.motion.stopDeviceMotionUpdates()
	}
}
