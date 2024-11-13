//
//  FuelUsageIntent.swift
//  YourCarbon
//
//  Created by William Handoko on 12/11/24.
//

import AppIntents

struct FuelUsageIntent: AppIntent {
    static var title: LocalizedStringResource = "Calculate Fuel Usage Emission"
    static var description: String = "Calculate emission based on fuel usage."

    @Parameter(title: "Vehicle Type")
    var vehicleType: String

    @Parameter(title: "Fuel Type", default: "Gasoline")
    var fuelType: String

    @Parameter(title: "Fuel Consumption (km/liters)", default: 0.0)
    var fuelConsumption: Double

    @Parameter(title: "Vehicle Range (km)", default: 0.0)
    var vehicleRange: Double

    static var openAppWhenRun: Bool = false

    func perform() async throws -> some IntentResult {
        // Calculate CO2 footprint based on fuel type
        let co2Footprint: Double
        if fuelType.lowercased() == "gasoline" {
            co2Footprint = ((0.7890 / (fuelConsumption * 1000 * 1000)) * 69300 * 41.868) * vehicleRange
        } else {
            co2Footprint = ((0.8677 / (fuelConsumption * 1000 * 1000)) * 74100 * 41.868) * vehicleRange
        }

        return .result(dialog: "\(co2Footprint, specifier: "%.2f") kg CO₂ emitted.")
    }
}
