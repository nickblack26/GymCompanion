//
//  WorkoutStepModel.swift
//  GymCompanion
//
//  Created by Nick on 10/19/23.
//

import SwiftData

@Model
class WorkoutStepModel {
	var goal: WorkoutGoalModel
	var alert: Bool
	
	init(goal: WorkoutGoalModel = .repition(8), alert: Bool = false) {
		self.goal = goal
		self.alert = alert
	}
}
