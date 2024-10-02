//
//  StatisticsView.swift
//  YourCarbon
//
//  Created by William Handoko on 02/10/24.
//

import SwiftUI
import Charts

struct StatisticsView: View {
    @StateObject private var viewModel = StatisticsViewModel()
    @State private var selectedDate = Date() // State for the currently selected date

    var body: some View {
        VStack {
            // Date Navigation (Previous and Next)
            HStack {
                Button(action: {
                    // Move to the previous day
                    if let prevDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) {
                        selectedDate = prevDate
                        viewModel.fetchDailyData(for: selectedDate) // Fetch data for the selected date
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding()
                }
                
                Spacer()

                // Display the current date
                Text(viewModel.getFormattedDate(date: selectedDate))
                    .foregroundColor(.white)
                    .font(.headline)
                
                Spacer()

                Button(action: {
                    // Move to the next day
                    if let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) {
                        selectedDate = nextDate
                        viewModel.fetchDailyData(for: selectedDate) // Fetch data for the next date
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                        .padding()
                }
            }
            .padding(.horizontal)
            
            // Weekly Graph for MTWTFSS
            Chart(viewModel.weeklyEmissionsData) { data in
                BarMark(
                    x: .value("Day", data.day),
                    y: .value("Emissions", data.co2Emission)
                )
                .foregroundStyle(data.isToday ? .green : .yellow) // Highlight current day in green
            }
            .frame(height: 300)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding()

            // Total Emissions
            Text("\(viewModel.totalEmissions, specifier: "%.2f") kgCO₂e")
                .font(.largeTitle)
                .padding()

            // Comparison with Yesterday
            if viewModel.isLessThanYesterday {
                Text("\(abs(viewModel.emissionDifference), specifier: "%.2f") kg less than yesterday")
                    .foregroundColor(.green)
            } else {
                Text("\(viewModel.emissionDifference, specifier: "%.2f") kg more than yesterday")
                    .foregroundColor(.orange)
            }

            // Emissions by Category
            VStack(spacing: 20) {
                HStack {
                    Text("Fuel Emissions")
                    Spacer()
                    Text("\(viewModel.fuelEmissions, specifier: "%.2f") kg CO₂")
                        .foregroundColor(.yellow)
                }

                HStack {
                    Text("Electricity Usage")
                    Spacer()
                    Text("\(viewModel.electricityEmissions, specifier: "%.2f") kg CO₂")
                        .foregroundColor(.yellow)
                }

                HStack {
                    Text("LPG Usage")
                    Spacer()
                    Text("\(viewModel.lpgEmissions, specifier: "%.2f") kg CO₂")
                        .foregroundColor(.yellow)
                }

                HStack {
                    Text("Food Waste")
                    Spacer()
                    Text("\(viewModel.foodWasteEmissions, specifier: "%.2f") kg CO₂")
                        .foregroundColor(.yellow)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .onAppear {
            viewModel.fetchDailyData(for: selectedDate) // Fetch data for the current day on view load
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
