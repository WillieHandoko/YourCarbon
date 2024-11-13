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
    
    func scheduleDailySummaryNotification(totalEmissions: Double, emissionLimit: Double) {
        let content = UNMutableNotificationContent()
        content.title = "Daily Emission Summary"
        content.body = "Your total emission for today is \(String(format: "%.2f", totalEmissions)) kg CO₂e."
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = 22 // 10 PM

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "dailySummary", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling daily summary notification: \(error)")
            }
        }
    }
    
    func scheduleExceededEmissionNotification(totalEmissions: Double, emissionLimit: Double, emissionDifference: Double) {
        if totalEmissions > emissionLimit {
            let content = UNMutableNotificationContent()
            content.title = "Daily Emission More Than Yesterday"
            content.body = "Your daily emission is \(String(format: "%.2f", emissionDifference)) kg CO₂e more than yesterday."
            content.sound = .default

            
            let notificationTimes = [8, 12, 16, 20]
            
            for hour in notificationTimes {
                var dateComponents = DateComponents()
                dateComponents.hour = hour
                
                let trigger_1 = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let trigger_2 = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                //Request 8,12,16,20
                let request_1 = UNNotificationRequest(identifier: "exceededLimit", content: content, trigger: trigger_1)
                UNUserNotificationCenter.current().add(request_1) { error in
                    if let error = error {
                        print("Error scheduling exceeded emission notification: \(error)")
                    }
                }
                //Request when open the app
                let request_2 = UNNotificationRequest(identifier: "exceededLimit", content: content, trigger: trigger_2)
                UNUserNotificationCenter.current().add(request_2) { error in
                    if let error = error {
                        print("Error scheduling exceeded emission notification: \(error)")
                    }
                }
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
        
        let totalEmissionContent = UNMutableNotificationContent()
        totalEmissionContent.title = "Good Evening!"
        totalEmissionContent.body = "Have you recorded your carbon footprint today?"
        totalEmissionContent.sound = .default

        // Schedule for 8 am
        var dateComponents = DateComponents()
        dateComponents.hour = 7
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