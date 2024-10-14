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
    @Published var totalFootprints: Double = 0.0
    @Published var totalFootprint: Double = 0.0
    @Published var showTargetSetting = false
    @Published var todayEmissionData: [EmissionsData] = []
    @Published var selectedCategory: String = "Fuel Usage"

    init() {
        fetchUserDetails()
        calculateTotalFootprint()
        fetchTodayEmissions()
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

    func fetchTodayEmissions() {
        let today = Calendar.current.startOfDay(for: Date())
        
        // Fetch daily data for each category
        let fuelData = CoreDataManager.shared.fetchFuelUsage().filter {
            Calendar.current.isDate($0.currentDate ?? Date(), inSameDayAs: today)
        }
        let fuelEmissions = fuelData.reduce(0) { $0 + $1.co2Footprint }
        
        let electricityData = CoreDataManager.shared.fetchElectricityUsage().filter {
            Calendar.current.isDate($0.currentDate ?? Date(), inSameDayAs: today)
        }
        let electricityEmissions = electricityData.reduce(0) { $0 + $1.co2Footprint }

        let lpgData = CoreDataManager.shared.fetchLPGUsage().filter {
            Calendar.current.isDate($0.currentDate ?? Date(), inSameDayAs: today)
        }
        let lpgEmissions = lpgData.reduce(0) { $0 + $1.co2Footprint }

        let foodWasteData = CoreDataManager.shared.fetchFoodWaste().filter {
            Calendar.current.isDate($0.currentDate ?? Date(), inSameDayAs: today)
        }
        let foodWasteEmissions = foodWasteData.reduce(0) { $0 + $1.co2Footprint }

        // Calculate today's total footprint
        totalFootprint = fuelEmissions + electricityEmissions + lpgEmissions + foodWasteEmissions

        // Prepare today's emission data for the chart
        todayEmissionData = [
            EmissionsData(category: "Fuel", co2Emission: fuelEmissions),
            EmissionsData(category: "Electricity", co2Emission: electricityEmissions),
            EmissionsData(category: "LPG", co2Emission: lpgEmissions),
            EmissionsData(category: "Food Waste", co2Emission: foodWasteEmissions)
        ]
    }
    
    
    func fetchEmissions() {
        // Get the current month start and end dates
        let calendar = Calendar.current
        let currentDate = Date()

        // Get the first and last date of the current month
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: 0), to: startOfMonth)!
        
        // Fetch daily data for each category
        let fuelData = CoreDataManager.shared.fetchFuelUsage().filter { data in
            return data.currentDate ?? Date() >= startOfMonth && data.currentDate ?? Date() <= endOfMonth
        }
        
        
        let fuelEmissions = fuelData.reduce(0) { $0 + $1.co2Footprint }
        
        let electricityData = CoreDataManager.shared.fetchElectricityUsage().filter { data in
            return data.currentDate ?? Date() >= startOfMonth && data.currentDate ?? Date() <= endOfMonth
        }
        
        let electricityEmissions = electricityData.reduce(0) { $0 + $1.co2Footprint }

        let lpgData = CoreDataManager.shared.fetchLPGUsage().filter { data in
            return data.currentDate ?? Date() >= startOfMonth && data.currentDate ?? Date() <= endOfMonth
        }
        
        let lpgEmissions = lpgData.reduce(0) { $0 + $1.co2Footprint }

        let foodWasteData = CoreDataManager.shared.fetchFoodWaste().filter { data in
            return data.currentDate ?? Date() >= startOfMonth && data.currentDate ?? Date() <= endOfMonth
        }
        
        let foodWasteEmissions = foodWasteData.reduce(0) { $0 + $1.co2Footprint }

        // Calculate today's total footprint
        totalFootprints = fuelEmissions + electricityEmissions + lpgEmissions + foodWasteEmissions
        
    }

    var isOverTarget: Bool {
        if let target = userTarget {
            return totalFootprints > target
        }
        return false
    }
}
