//
//  StatisticsView.swift
//  YourCarbon
//
//  Created by William Handoko on 02/10/24.
//

import SwiftUI
import Charts

struct StatisticsView: View {
    @State private var chartScale: Int = 1000
    @StateObject private var viewModel = StatisticsViewModel()
    @State private var selectedDate = Date() // State for the currently selected date

    var body: some View {
        NavigationView {
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
                            .foregroundColor(.primary)
                            .padding()
                    }
                    
                    Spacer()

                    // Display the current date
                    Text(viewModel.getFormattedDate(date: selectedDate))
                        .foregroundColor(.primary)
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
                            .foregroundColor(.primary)
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
                .chartYScale(domain: 0...(chartScale))
                .frame(height: 250)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
                
                HStack(alignment:.center,spacing: 5){
                    Spacer()
                    Button {
                        self.chartScale = 1000
                    } label: {
                        Text("1000")
                            .foregroundColor(.primary)
                            .background
                        {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 60,height: 35)
                        }
                    }
                    .frame(width: 60,height: 35)
                    
                    Button {
                        self.chartScale = 2500
                    } label: {
                        Text("2500")
                            .foregroundColor(.primary)
                            .background
                        {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 60,height: 35)
                            
                        }
                    }
                    .frame(width: 60,height: 35)
                    
                    Button {
                        self.chartScale = 5000
                    } label: {
                        Text("5000")
                            .foregroundColor(.primary)
                            .background
                        {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 60,height: 35)
                        }
                    }
                    .frame(width: 60,height: 35)
                    
                    Button {
                        self.chartScale = 10000
                    } label: {
                        Text("10000")
                            .foregroundColor(.primary)
                            .background
                        {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 60,height: 35)
                        }
                    }
                    .frame(width: 60,height: 35)
                    
                    Button {
                        self.chartScale = 15000
                    } label: {
                        Text("15000")
                            .foregroundColor(.primary)
                            .background
                        {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 60,height: 35)
                        }
                    }
                    .frame(width: 60,height: 35)
                    Spacer()
                }
                .background
                {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width:340,height:50)
                        
                }
                .padding(.top,5)

                // Total Emissions
                Text("\(viewModel.totalEmissions, specifier: "%.3f") kgCO₂e")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                // Yesterday Comparison
                if viewModel.isLessThanYesterday {
                    Text("\(viewModel.emissionDifference, specifier: "%.3f") kg less than yesterday")
                        .foregroundColor(.green)
                } else {
                    Text("\(viewModel.emissionDifference, specifier: "%.3f") kg more than yesterday")
                        .foregroundColor(.orange)
                }

                // Emissions by Category (Clickable List)
                VStack{
                    List{
                        NavigationLink(destination: EmissionDetailView(category: "Fuel", records: viewModel.fuelRecords)
                        ) {
                            HStack {
                                Text("Fuel Emissions")
                                Spacer()
                                Text("\(viewModel.fuelEmissions, specifier: "%.3f") kg CO₂")
                                    .foregroundColor(.orange)
                            }
                        }
                        .listRowBackground(Color.gray.opacity(0.15))
                        
                        NavigationLink(destination: EmissionDetailView(category: "Electricity", records: viewModel.electricityRecords)) {
                            HStack {
                                Text("Electricity Usage")
                                Spacer()
                                Text("\(viewModel.electricityEmissions, specifier: "%.3f") kg CO₂")
                                    .foregroundColor(.orange)
                            }
                        }
                        .listRowBackground(Color.gray.opacity(0.15))
                        
                        NavigationLink(destination: EmissionDetailView(category: "LPG", records: viewModel.lpgRecords)) {
                            HStack {
                                Text("LPG Usage")
                                Spacer()
                                Text("\(viewModel.lpgEmissions, specifier: "%.3f") kg CO₂")
                                    .foregroundColor(.orange)
                            }
                        }
                        .listRowBackground(Color.gray.opacity(0.15))
                        
                        NavigationLink(destination: EmissionDetailView(category: "Plastic Waste", records: viewModel.foodWasteRecords)) {
                            HStack {
                                Text("Plastic Waste")
                                Spacer()
                                Text("\(viewModel.foodWasteEmissions, specifier: "%.3f") kg CO₂")
                                    .foregroundColor(.orange)
                            }
                        }
                        .listRowBackground(Color.gray.opacity(0.15))
                    }
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
                }
            }
            .padding()
            .onAppear {
                viewModel.fetchDailyData(for: selectedDate) // Fetch data for the current day on view load
            }
        }
    }
}

#Preview{
    StatisticsView()
}
