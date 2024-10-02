//
//  ElectricityUsageViewModel.swift
//  YourCarbon
//
//  Created by William Handoko on 02/10/24.
//

import SwiftUI

class ElectricityUsageViewModel: ObservableObject {
    @Published var electricityUsage: String = ""
    @Published var usageTime: String = ""

    func calculateFootprint() {
        guard let electricityUsage = Double(electricityUsage),
              let usageTime = Int(usageTime) else { return }

        let co2Footprint = electricityUsage * 0.475 // Approx CO2 per kWh
        CoreDataManager.shared.saveElectricityUsage(electricityAmount: electricityUsage, usageTime: usageTime, footprint: co2Footprint)
    }
}
