//
//  PlasticWasteIntent.swift
//  YourCarbon
//
//  Created by William Handoko on 12/11/24.
//

import AppIntents

struct PlasticWasteIntent: AppIntent {
    static var title: LocalizedStringResource = "Calculate Plastic Waste Emission"
    static var description: String = "Calculate emissions based on plastic waste."

    @Parameter(title: "Plastic Type (e.g., bottles)")
    var plasticType: String

    @Parameter(title: "Weight (kg)")
    var weight: Double

    static var openAppWhenRun: Bool = false

    func perform() async throws -> some IntentResult {
        let co2Footprint = weight * 6 // CO2 per kg of plastic waste
        return .result(dialog: "\(co2Footprint, specifier: "%.2f") kg CO₂")
    }
}
