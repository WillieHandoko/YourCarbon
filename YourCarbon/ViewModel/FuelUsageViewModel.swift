//
//  FuelUsageViewModel.swift
//  YourCarbon
//
//  Created by William Handoko on 02/10/24.
//

import SwiftUI

class FuelUsageViewModel: ObservableObject {
    @Published var vehicleType: String = ""
    @Published var fuelType: String = ""
    @Published var fuelConsumption: String = ""
    @Published var vehicleRange: String = ""

    func calculateFootprint() {
        guard let fuelConsumption = Double(fuelConsumption),
              let vehicleRange = Double(vehicleRange) else { return }

        let co2Footprint = (fuelConsumption / vehicleRange) * 2.31 // Approx CO2 per liter of fuel
        CoreDataManager.shared.saveFuelUsage(vehicleType: vehicleType, fuelType: fuelType, fuelConsumption: fuelConsumption, vehicleRange: vehicleRange, footprint: co2Footprint)
    }
}
