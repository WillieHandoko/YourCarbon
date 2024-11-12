//
//  NotificationManager.swift
//  YourCarbon
//
//  Created by William Handoko on 12/11/24.
//

import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    private init() {} // Singleton

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Authorization error: \(error.localizedDescription)")
            }
        }
    }

    func scheduleDailyReminders() {
        let morningContent = UNMutableNotificationContent()
        morningContent.title = "Good Morning!"
        morningContent.body = "Don't forget to record your carbon footprint."
        morningContent.sound = .default

        let eveningContent = UNMutableNotificationContent()
        eveningContent.title = "Good Evening!"
        eveningContent.body = "Have you recorded your carbon footprint today?"
        eveningContent.sound = .default

        // Schedule for 8 am
        var dateComponents = DateComponents()
        dateComponents.hour = 8
        let morningTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let morningRequest = UNNotificationRequest(identifier: "morningReminder", content: morningContent, trigger: morningTrigger)
        UNUserNotificationCenter.current().add(morningRequest)

        // Schedule for 9 pm
        dateComponents.hour = 21
        let eveningTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let eveningRequest = UNNotificationRequest(identifier: "eveningReminder", content: eveningContent, trigger: eveningTrigger)
        UNUserNotificationCenter.current().add(eveningRequest)
    }
}
