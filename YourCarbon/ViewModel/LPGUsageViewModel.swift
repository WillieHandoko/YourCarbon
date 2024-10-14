//
//  LPGUsageViewModel.swift
//  YourCarbon
//
//  Created by William Handoko on 02/10/24.
//

import SwiftUI

class LPGUsageViewModel: ObservableObject {
    @Published var lpgAmount: String = ""
    @Published var usageTime: String = ""

    // Function to calculate footprint and save data
    func calculateFootprint() {
        // Convert input strings to appropriate data types
        guard let lpgAmount = Double(lpgAmount),
              let usageTime = Int(usageTime) else {
            print("Invalid input")
            return
        }

        // LPG produces approximately 3 kg of CO₂ per kg of LPG used
        let co2Footprint = lpgAmount * 2.9925

        // Save to Core Data using CoreDataManager
        CoreDataManager.shared.saveLPGUsage(lpgAmount: lpgAmount, usageTime: usageTime, footprint: co2Footprint)
    }
}
