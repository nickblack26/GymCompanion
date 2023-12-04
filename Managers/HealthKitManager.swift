//
//  HealthKitManager.swift
//  GymCompanion
//
//  Created by Nick on 10/19/23.
//

import Foundation
import HealthKit
import WorkoutKit
import SwiftUI
import Observation

@Observable
class HealthKitManager: NSObject {
	// MARK: - Workout Metrics
	var averageHeartRate: Double = 0
	var heartRate: Double = 0
	var activeEnergy: Double = 0
	var distance: Double = 0
	var workout: HKWorkout?
	
	// The workout session state.
	var running = false
	
	var selectedWorkout: HKWorkoutActivityType? {
		didSet {
			guard let selectedWorkout = selectedWorkout else { return }
			startWorkout(workoutType: selectedWorkout)
		}
	}
	
	var showingSummaryView: Bool = false {
		didSet {
			if showingSummaryView == false {
				self.resetWorkout()
			}
		}
	}
	
	let healthStore = HKHealthStore()
	var session: HKWorkoutSession?
	
	// Start workout based on Activity Type
	func startWorkout(workoutType: HKWorkoutActivityType) {
		let configuration = HKWorkoutConfiguration()
		configuration.activityType = workoutType
		configuration.locationType = .outdoor
		
		// Start the workout session and begin data collection.
		let startDate = Date()
		session?.startActivity(with: startDate)
	}
	
	// Request authorization to access HealthKit.
	func requestAuthorization() {
		// The quantity type to write to the health store.
		let typesToShare: Set = [
			HKQuantityType.workoutType()
		]
		
		// The quantity types to read from the health store.
		let typesToRead: Set = [
			HKQuantityType.quantityType(forIdentifier: .heartRate)!,
			HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
			HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
			HKQuantityType.quantityType(forIdentifier: .distanceCycling)!,
			HKObjectType.activitySummaryType()
		]
		
		// Request authorization for those quantity types.
		healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
			// Handle error.
		}
	}
	
	// MARK: - State Control
	
	func pause() {
		session?.pause()
	}
	
	func resume() {
		session?.resume()
	}
	
	func togglePause() {
		if running == true {
			pause()
		} else {
			resume()
		}
	}
	
	func endWorkout() {
		session?.end()
		showingSummaryView = true
	}
	
	func resetWorkout() {
		selectedWorkout = nil
		//		builder = nil
		session = nil
		workout = nil
		activeEnergy = 0
		averageHeartRate = 0
		heartRate = 0
		distance = 0
	}
}

let workoutTypes: [HKWorkoutActivityType] = [.cycling, .running, .walking, .crossTraining, .traditionalStrengthTraining, .functionalStrengthTraining, .highIntensityIntervalTraining, .coreTraining, .stepTraining]
