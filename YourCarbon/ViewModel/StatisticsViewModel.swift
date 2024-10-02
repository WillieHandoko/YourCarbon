//
//  StatisticsViewModel.swift
//  YourCarbon
//
//  Created by William Handoko on 02/10/24.
//

import SwiftUI
import CoreData

struct EmissionData: Identifiable {
    var id = UUID()
    var day: String
    var co2Emission: Double
    var isToday: Bool // To mark if it's the current day
}

class StatisticsViewModel: ObservableObject {
    @Published var totalEmissions: Double = 0.0
    @Published var fuelEmissions: Double = 0.0
    @Published var electricityEmissions: Double = 0.0
    @Published var lpgEmissions: Double = 0.0
    @Published var foodWasteEmissions: Double = 0.0
    @Published var weeklyEmissionsData: [EmissionData] = []

    let calendar = Calendar.current

    // Fetches daily emission data for a specific date
    func fetchDailyData(for date: Date) {
        let today = calendar.startOfDay(for: date)

        // Fetch daily data for fuel usage
        let fuelData = CoreDataManager.shared.fetchFuelUsage().filter {
            calendar.isDate($0.date ?? Date(), inSameDayAs: today)
        }
        fuelEmissions = fuelData.reduce(0) { $0 + $1.co2Footprint }

        // Fetch daily data for electricity usage
        let electricityData = CoreDataManager.shared.fetchElectricityUsage().filter {
            calendar.isDate($0.date ?? Date(), inSameDayAs: today)
        }
        electricityEmissions = electricityData.reduce(0) { $0 + $1.co2Footprint }

        // Fetch daily data for LPG usage
        let lpgData = CoreDataManager.shared.fetchLPGUsage().filter {
            calendar.isDate($0.date ?? Date(), inSameDayAs: today)
        }
        lpgEmissions = lpgData.reduce(0) { $0 + $1.co2Footprint }

        // Fetch daily data for food waste
        let foodWasteData = CoreDataManager.shared.fetchFoodWaste().filter {
            calendar.isDate($0.date ?? Date(), inSameDayAs: today)
        }
        foodWasteEmissions = foodWasteData.reduce(0) { $0 + $1.co2Footprint }

        // Calculate total emissions
        totalEmissions = fuelEmissions + electricityEmissions + lpgEmissions + foodWasteEmissions

        // Prepare chart data for the current week
        prepareWeeklyEmissionData(for: date)
    }

    // Function to prepare emission data for the current week (Monday to Sunday)
    private func prepareWeeklyEmissionData(for date: Date) {
        let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"] // Days of the week
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!

        weeklyEmissionsData.removeAll()

        for i in 0..<7 {
            if let weekDay = calendar.date(byAdding: .day, value: i, to: startOfWeek) {
                let isToday = calendar.isDate(weekDay, inSameDayAs: date)
                
                // Sum of emissions for that specific day
                let dayEmissions = calculateDailyEmissions(for: weekDay)
                
                weeklyEmissionsData.append(EmissionData(
                    day: days[i],
                    co2Emission: dayEmissions,
                    isToday: isToday // Highlight today's day
                ))
            }
        }
    }

    // Helper function to calculate emissions for a given day
    private func calculateDailyEmissions(for date: Date) -> Double {
        let fuelData = CoreDataManager.shared.fetchFuelUsage().filter {
            calendar.isDate($0.date ?? Date(), inSameDayAs: date)
        }
        let fuelEmission = fuelData.reduce(0) { $0 + $1.co2Footprint }

        let electricityData = CoreDataManager.shared.fetchElectricityUsage().filter {
            calendar.isDate($0.date ?? Date(), inSameDayAs: date)
        }
        let electricityEmission = electricityData.reduce(0) { $0 + $1.co2Footprint }

        let lpgData = CoreDataManager.shared.fetchLPGUsage().filter {
            calendar.isDate($0.date ?? Date(), inSameDayAs: date)
        }
        let lpgEmission = lpgData.reduce(0) { $0 + $1.co2Footprint }

        let foodWasteData = CoreDataManager.shared.fetchFoodWaste().filter {
            calendar.isDate($0.date ?? Date(), inSameDayAs: date)
        }
        let foodWasteEmission = foodWasteData.reduce(0) { $0 + $1.co2Footprint }

        return fuelEmission + electricityEmission + lpgEmission + foodWasteEmission
    }

    // Helper to format the date for display
    func getFormattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
