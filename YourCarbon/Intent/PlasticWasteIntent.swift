//
//  PlasticWasteIntent.swift
//  YourCarbon
//
//  Created by William Handoko on 12/11/24.
//

import AppIntents
import UserNotifications

struct PlasticWasteIntent: AppIntent {
    static var title: LocalizedStringResource = "Calculate Plastic Waste Emission"
    static var description: String = "Calculate emissions based on plastic waste."

    @Parameter(title: "Plastic Weight (kg)")
    var plasticWeight: Double

    static var openAppWhenRun: Bool = false

    func perform() async throws -> some IntentResult {
        let co2Emission = plasticWeight * 1.5 // Example factor for plastic waste
        sendSuccessNotification(for: "Plastic Waste")
        return .result(dialog: "\(co2Emission, specifier: "%.2f") kg CO₂")
    }
    
    private func sendSuccessNotification(for type: String) {
        let content = UNMutableNotificationContent()
        content.title = "\(type) Data Added"
        content.body = "Your \(type.lowercased()) data has been added successfully!"
        content.sound = .default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
}
