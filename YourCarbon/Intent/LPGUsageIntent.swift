//
//  LPGUsageIntent.swift
//  YourCarbon
//
//  Created by William Handoko on 12/11/24.
//

import AppIntents

struct LPGUsageIntent: AppIntent {
    static var title: LocalizedStringResource = "Calculate LPG Emission"
    static var description: String = "Calculate emissions based on LPG usage."

    @Parameter(title: "LPG Amount (kg)")
    var lpgAmount: Double

    @Parameter(title: "Usage Time (hours)")
    var usageTime: Int

    static var openAppWhenRun: Bool = false

    func perform() async throws -> some IntentResult {
        let co2Footprint = lpgAmount * 2.9925 // CO2 per kg of LPG
        return .result(dialog: "\(co2Footprint, specifier: "%.2f") kg CO₂")
    }
}
