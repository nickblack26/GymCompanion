//
//  GymWatchCompanionApp.swift
//  GymWatchCompanion Watch App
//
//  Created by Nick on 10/19/23.
//

import SwiftUI

@main
struct GymWatchCompanion_Watch_AppApp: App {
	@State private var motionManager = MotionManager()
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environment(motionManager)
        }
    }
}
