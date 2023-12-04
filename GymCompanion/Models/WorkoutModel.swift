//
//  WorkoutModel.swift
//  GymCompanion
//
//  Created by Nick on 10/19/23.
//

import HealthKit
import SwiftData

@Model
final class WorkoutModel {
	var activity: HKWorkoutActivityType
	var location: HKWorkoutSessionLocationType
	var displayName: String?
	@Relationship var warmup: WorkoutStepModel?
	@Relationship var blocks: [IntervalBlockModel]
	@Relationship var cooldown: WorkoutStepModel?
	
	init(activity: HKWorkoutActivityType = .traditionalStrengthTraining, location: HKWorkoutSessionLocationType = .indoor, displayName: String? = nil, warmup: WorkoutStepModel? = nil, blocks: [IntervalBlockModel], cooldown: WorkoutStepModel? = nil) {
		self.activity = activity
		self.location = location
		self.displayName = displayName
		self.warmup = warmup
		self.blocks = blocks
		self.cooldown = cooldown
	}
}
