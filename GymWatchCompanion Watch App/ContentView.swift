//
//  ContentView.swift
//  GymWatchCompanion Watch App
//
//  Created by Nick on 10/19/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
	@Environment(MotionManager.self) private var motionManager
	
    var body: some View {
        VStack {
			Button {
				if motionManager.isCollectingMotion {
					motionManager.stopCollectingMotionData()
				} else {
					motionManager.startCollectingMotionData()
				}
			} label: {
				Text(motionManager.repDetected ? "Detected" : "Waiting")
					.foregroundStyle(motionManager.repDetected ? .green : .yellow)
					.font(.title)
					.fontWeight(.bold)
					.sensoryFeedback(.success, trigger: motionManager.repDetected)
			}
			.buttonStyle(.plain)
			.sensoryFeedback(.selection, trigger: motionManager.isCollectingMotion)
        }
		.onAppear {
			motionManager.startCollectingMotionData()
		}
		.onDisappear {
			motionManager.stopCollectingMotionData()
		}
	}
}

#Preview {
	let motionManager = MotionManager()
    return ContentView()
		.environment(motionManager)
}
