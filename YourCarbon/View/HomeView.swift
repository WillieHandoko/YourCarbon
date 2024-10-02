//
//  HomeView.swift
//  YourCarbon
//
//  Created by William Handoko on 02/10/24.
//

import SwiftUI
import Charts

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Username Display
                if let username = viewModel.username {
                    Text("Welcome, \(username)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                } else {
                    Text("Welcome!")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }

                // Carbon Reduction Target
                if let target = viewModel.userTarget {
                    Text("Your target: Reduce \(target, specifier: "%.1f") kg CO₂")
                        .font(.headline)
                        .foregroundColor(viewModel.isOverTarget ? .orange : .green)
                    Button("Edit Target") {
                        viewModel.showTargetSetting = true
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                } else {
                    Button("Set Target") {
                        viewModel.showTargetSetting = true
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                }

                // Navigation Links for calculating carbon footprint
                VStack {
                    HStack {
                        NavigationLink(destination: LPGUsageView()) {
                            Text("LPG Usage")
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .frame(maxWidth: .infinity)
                        }
                        NavigationLink(destination: FuelUsageView()) {
                            Text("Fuel Usage")
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    HStack {
                        NavigationLink(destination: ElectricityUsageView()) {
                            Text("Electricity Usage")
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .frame(maxWidth: .infinity)
                        }
                        NavigationLink(destination: FoodWasteView()) {
                            Text("Food Waste")
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding(.horizontal)

                // Chart to show today's emissions by category
                Chart(viewModel.todayEmissionData) { data in
                    BarMark(
                        x: .value("Category", data.category),
                        y: .value("Emissions", data.co2Emission)
                    )
                    .foregroundStyle(.yellow)
                }
                .frame(height: 250)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()

                // Display today's total carbon emissions
                VStack{
                    Text("Total Carbon Emissions")
                    Text("Today: \(viewModel.totalFootprint, specifier: "%.2f") kg CO₂")
                }
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(.top, 10)

                Spacer()
            }
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $viewModel.showTargetSetting) {
                TargetSettingView(viewModel: viewModel)  // This fixes the error
            }
            .onAppear {
                viewModel.calculateTotalFootprint()
                viewModel.fetchTodayEmissions() // Fetch today's emissions for chart
            }
        }
    }
}
