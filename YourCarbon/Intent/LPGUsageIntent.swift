//
//  LPGUsageIntent.swift
//  YourCarbon
//
//  Created by William Handoko on 12/11/24.
//

import AppIntents
import UserNotifications

struct LPGUsageIntent: AppIntent {
    static var title: LocalizedStringResource = "Calculate LPG Emission"
    static var description: String = "Calculate emissions based on LPG usage."

    @Parameter(title: "LPG Consumption (kg)")
    var lpgConsumption: Double

    static var openAppWhenRun: Bool = false

    func perform() async throws -> some IntentResult {
        let co2Emission = lpgConsumption * 2.9 // Example factor for LPG
        sendSuccessNotification(for: "LPG Usage")
        return .result(dialog: "\(co2Emission, specifier: "%.2f") kg CO₂")
    }
    
    private func sendSuccessNotification(for type: String) {
        let content = UNMutableNotificationContent()
        content.title = "\(type) Data Added"
        content.body = "Your \(type.lowercased()) usage data has been added successfully!"
        content.sound = .default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
}
