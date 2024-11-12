//
//  YourCarbonApp.swift
//  YourCarbon
//
//  Created by William Handoko on 02/10/24.
//

import SwiftUI

@main
struct YourCarbonApp: App {
    init() {
        // Request notification authorization when the app launches
        NotificationManager.shared.requestAuthorization()
        NotificationManager.shared.scheduleDailyReminders()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
