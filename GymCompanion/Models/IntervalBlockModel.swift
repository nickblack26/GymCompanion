//
//  IntervalBlockModel.swift
//  GymCompanion
//
//  Created by Nick on 10/19/23.
//

import SwiftData

@Model
class IntervalBlockModel {
	@Relationship var steps: [IntervalStepModel]
	var iterations: Int
	
	init(steps: [IntervalStepModel], iterations: Int) {
		self.steps = steps
		self.iterations = iterations
	}
}
