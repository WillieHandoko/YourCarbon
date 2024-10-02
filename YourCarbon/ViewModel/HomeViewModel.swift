//
//  HomeViewModel.swift
//  YourCarbon
//
//  Created by William Handoko on 02/10/24.
//

import SwiftUI
import CoreData

struct EmissionsData: Identifiable {
    var id = UUID()
    var category: String
    var co2Emission: Double
}

class HomeViewModel: ObservableObject {
    @Published var username: String?
    @Published var userTarget: Double?
    @Published var totalFootprint: Double = 0.0
    @Published var showTargetSetting = false
    @Published var todayEmissionData: [EmissionsData] = []

    init() {
        fetchUserDetails()
        calculateTotalFootprint()
    }

    func fetchUserDetails() {
        if let user = CoreDataManager.shared.fetchUser() {
            username = user.username
            if let target = user.target {
                userTarget = target.targetReduction
            }
        } else {
            let user = CoreDataManager.shared.createUser(username: "User")
            username = user.username
        }
    }

    func setUserTarget(_ target: Double) {
        if let user = CoreDataManager.shared.fetchUser() {
            CoreDataManager.shared.updateUserTarget(user: user, targetReduction: target)
            userTarget = target
        }
    }

    func calculateTotalFootprint() {
        let fuelFootprint = CoreDataManager.shared.fetchFuelUsage().reduce(0) { $0 + $1.co2Footprint }
        let electricityFootprint = CoreDataManager.shared.fetchElectricityUsage().reduce(0) { $0 + $1.co2Footprint }
        let lpgFootprint = CoreDataManager.shared.fetchLPGUsage().reduce(0) { $0 + $1.co2Footprint }
        let foodWasteFootprint = CoreDataManager.shared.fetchFoodWaste().reduce(0) { $0 + $1.co2Footprint }
        totalFootprint = fuelFootprint + electricityFootprint + lpgFootprint + foodWasteFootprint
    }

    // Fetch emissions for today and prepare for chart
    func fetchTodayEmissions() {
        let today = Calendar.current.startOfDay(for: Date())

        // Fetch daily data for fuel usage
        let fuelData = CoreDataManager.shared.fetchFuelUsage().filter {
            Calendar.current.isDate($0.date ?? Date(), inSameDayAs: today)
        }
        let fuelEmissions = fuelData.reduce(0) { $0 + $1.co2Footprint }

        // Fetch daily data for electricity usage
        let electricityData = CoreDataManager.shared.fetchElectricityUsage().filter {
            Calendar.current.isDate($0.date ?? Date(), inSameDayAs: today)
        }
        let electricityEmissions = electricityData.reduce(0) { $0 + $1.co2Footprint }

        // Fetch daily data for LPG usage
        let lpgData = CoreDataManager.shared.fetchLPGUsage().filter {
            Calendar.current.isDate($0.date ?? Date(), inSameDayAs: today)
        }
        let lpgEmissions = lpgData.reduce(0) { $0 + $1.co2Footprint }

        // Fetch daily data for food waste
        let foodWasteData = CoreDataManager.shared.fetchFoodWaste().filter {
            Calendar.current.isDate($0.date ?? Date(), inSameDayAs: today)
        }
        let foodWasteEmissions = foodWasteData.reduce(0) { $0 + $1.co2Footprint }

        // Prepare today's emission data for the chart
        todayEmissionData = [
            EmissionsData(category: "Fuel", co2Emission: fuelEmissions),
            EmissionsData(category: "Electricity", co2Emission: electricityEmissions),
            EmissionsData(category: "LPG", co2Emission: lpgEmissions),
            EmissionsData(category: "Food Waste", co2Emission: foodWasteEmissions)
        ]
    }

    var isOverTarget: Bool {
        if let target = userTarget {
            return totalFootprint > target
        }
        return false
    }
}
