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
    @Published var emissionDifference: Double = 0.0 // Difference between today and yesterday
    @Published var isLessThanYesterday: Bool = false // Whether emissions are less than yesterday

    let calendar = Calendar.current

    // Fetches daily emission data for a specific date
    func fetchDailyData(for date: Date) {
        let today = calendar.startOfDay(for: date)
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today) ?? Date()

        // Today's emissions
        let fuelDataToday = CoreDataManager.shared.fetchFuelUsage().filter {
            calendar.isDate($0.date ?? Date(), inSameDayAs: today)
        }
        fuelEmissions = fuelDataToday.reduce(0) { $0 + $1.co2Footprint }

        let electricityDataToday = CoreDataManager.shared.fetchElectricityUsage().filter {
            calendar.isDate($0.date ?? Date(), inSameDayAs: today)
        }
        electricityEmissions = electricityDataToday.reduce(0) { $0 + $1.co2Footprint }

        let lpgDataToday = CoreDataManager.shared.fetchLPGUsage().filter {
            calendar.isDate($0.date ?? Date(), inSameDayAs: today)
        }
        lpgEmissions = lpgDataToday.reduce(0) { $0 + $1.co2Footprint }

        let foodWasteDataToday = CoreDataManager.shared.fetchFoodWaste().filter {
            calendar.isDate($0.date ?? Date(), inSameDayAs: today)
        }
        foodWasteEmissions = foodWasteDataToday.reduce(0) { $0 + $1.co2Footprint }

        // Calculate today's total emissions
        totalEmissions = fuelEmissions + electricityEmissions + lpgEmissions + foodWasteEmissions

        // Yesterday's emissions
        let fuelDataYesterday = CoreDataManager.shared.fetchFuelUsage().filter {
            calendar.isDate($0.date ?? Date(), inSameDayAs: yesterday)
        }
        let fuelEmissionsYesterday = fuelDataYesterday.reduce(0) { $0 + $1.co2Footprint }

        let electricityDataYesterday = CoreDataManager.shared.fetchElectricityUsage().filter {
            calendar.isDate($0.date ?? Date(), inSameDayAs: yesterday)
        }
        let electricityEmissionsYesterday = electricityDataYesterday.reduce(0) { $0 + $1.co2Footprint }

        let lpgDataYesterday = CoreDataManager.shared.fetchLPGUsage().filter {
            calendar.isDate($0.date ?? Date(), inSameDayAs: yesterday)
        }
        let lpgEmissionsYesterday = lpgDataYesterday.reduce(0) { $0 + $1.co2Footprint }

        let foodWasteDataYesterday = CoreDataManager.shared.fetchFoodWaste().filter {
            calendar.isDate($0.date ?? Date(), inSameDayAs: yesterday)
        }
        let foodWasteEmissionsYesterday = foodWasteDataYesterday.reduce(0) { $0 + $1.co2Footprint }

        // Calculate yesterday's total emissions
        let totalEmissionsYesterday = fuelEmissionsYesterday + electricityEmissionsYesterday + lpgEmissionsYesterday + foodWasteEmissionsYesterday

        // Calculate the difference between today and yesterday
        emissionDifference = totalEmissions - totalEmissionsYesterday
        isLessThanYesterday = emissionDifference < 0

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
