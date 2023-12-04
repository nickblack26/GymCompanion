//
//  IntervalStepModel.swift
//  GymCompanion
//
//  Created by Nick on 10/19/23.
//

import SwiftData
import WorkoutKit

@Model
class IntervalStepModel {
	enum Purpose {
		case work
		case recovery
	}
	var purpose: Purpose
	@Relationship var step: WorkoutStepModel?
	var goal: WorkoutGoalModel?
	
	init(_ purpose: Purpose, step: WorkoutStepModel) {
		self.purpose = purpose
		self.step = step
	}
	
	init(_ purpose: Purpose, goal: WorkoutGoalModel? = nil) {
		self.purpose = purpose
		self.step = step
	}
}
