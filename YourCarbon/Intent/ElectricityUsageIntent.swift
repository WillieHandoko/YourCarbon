//
//  ElectricityUsageIntent.swift
//  YourCarbon
//
//  Created by William Handoko on 12/11/24.
//

import AppIntents

struct ElectricityUsageIntent: AppIntent {
    static var title: LocalizedStringResource = "Calculate Electricity Emission"
    static var description: String = "Calculate emissions based on electricity usage."

    @Parameter(title: "Electricity Usage (Wh)")
    var electricityUsage: Double

    @Parameter(title: "Usage Time (hours)")
    var usageTime: Int

    static var openAppWhenRun: Bool = false

    func perform() async throws -> some IntentResult {
        let electricityUsageInKWh = electricityUsage / 1000
        let electricityAmount = electricityUsageInKWh * Double(usageTime)
        
        let co2Footprint = electricityAmount * 0.7771589 // CO2 per kWh
        return .result(dialog: "\(co2Footprint, specifier: "%.2f") kg CO₂")
    }
}
