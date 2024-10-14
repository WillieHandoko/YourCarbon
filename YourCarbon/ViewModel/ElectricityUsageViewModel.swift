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
        let electricityUsageInKWh = electricityUsage / 1000
        let electricityAmount = electricityUsageInKWh * Double(usageTime)
        
        let co2Footprint = electricityAmount * 0.7771589 // Approx CO2 per kWh
        CoreDataManager.shared.saveElectricityUsage(electricityAmount: electricityUsageInKWh, usageTime: usageTime, footprint: co2Footprint)
    }
}
