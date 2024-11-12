//
//  FuelUsageIntent.swift
//  YourCarbon
//
//  Created by William Handoko on 12/11/24.
//

import AppIntents

struct FuelUsageIntent: AppIntent {
    static var title: LocalizedStringResource = "Calculate Fuel Emission"
    static var description: String = "Calculate fuel emissions based on user input data."

    @Parameter(title: "Vehicle Type", default: "Car")
    var vehicleType: String

    @Parameter(title: "Fuel Type", default: "Gasoline")
    var fuelType: String

    @Parameter(title: "Fuel Consumption (L)", default: 0.0)
    var fuelConsumption: Double

    @Parameter(title: "Vehicle Range (km)", default: 0.0)
    var vehicleRange: Double

    static var openAppWhenRun: Bool = false

    func perform() async throws -> some IntentResult {
        let co2Emission = calculateFuelEmissions(
            vehicleType: vehicleType,
            fuelType: fuelType,
            fuelConsumption: fuelConsumption,
            vehicleRange: vehicleRange
        )
        
        return .result(
            dialog: "\(co2Emission, specifier: "%.2f") kg CO₂"
        )
    }

    private func calculateFuelEmissions(
        vehicleType: String,
        fuelType: String,
        fuelConsumption: Double,
        vehicleRange: Double
    ) -> Double {
        let emissionFactor = fuelType == "Gasoline" ? 2.31 : 2.68 // Example factors
        return (fuelConsumption / vehicleRange) * emissionFactor
    }
    
    
}
