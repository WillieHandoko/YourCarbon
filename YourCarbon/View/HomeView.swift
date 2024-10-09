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
    let category: [String] = ["Fuel Usage","LPG Usage","Electricity Usage","Food Waste"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                LabeledContent("Welcome to YourCarbon!") {
                    Button (action: {
                        viewModel.showTargetSetting = true
                    }, label: {
                        Image(systemName: "gear.circle")
                            .font(.largeTitle)
                            .padding(.trailing,20)
                    })
                }
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal, 25)
                
                if let target = viewModel.userTarget {
                    Text("Your target: Reduce \(target, specifier: "%.1f") kg CO₂")
                        .font(.headline)
                        .foregroundColor(viewModel.isOverTarget ? .orange : .green)
                }
                
                
                // Navigation Links for calculating carbon footprint
                VStack {
                    
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
                    
                    
                    Form{
                        Section(header: Text("Count your emissions")){
                            Picker("Category", selection: $viewModel.selectedCategory)
                            {
                                ForEach(category, id: \.self) {number in Text("\(number)")
                                }
                                .font(.footnote)
                            }
                            .font(.footnote)
                            .fontWeight(.medium)
                        }
                    }
                    .frame(width: 365, height: 90)
                    .padding(.horizontal, 38)
                    .padding(.top,5)
                    
                    VStack{
                        if (viewModel.selectedCategory == "Fuel Usage") {
                            NavigationLink(destination: FuelUsageView()) {
                                Text("Continue")
                                    .foregroundStyle(Color.white)
                                    .background{
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.gray.opacity(0.2))
                                            .frame(width: 325, height: 40)
                                    }
                            }
                            .frame(width: 325, height: 40)
                            .padding(.horizontal, 38)
                            .padding(.top, 5)
                        }
                        else if (viewModel.selectedCategory == "LPG Usage") {
                            NavigationLink(destination: LPGUsageView()) {
                                Text("Continue")
                                    .foregroundStyle(Color.white)
                                    .background{
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.gray.opacity(0.2))
                                            .frame(width: 325, height: 40)
                                    }
                            }
                            .frame(width: 325, height: 40)
                            .padding(.horizontal, 38)
                            .padding(.top, 5)
                        }
                        else if (viewModel.selectedCategory == "Electricity Usage") {
                            NavigationLink(destination: ElectricityUsageView()) {
                                Text("Continue")
                                    .foregroundStyle(Color.white)
                                    .background{
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.gray.opacity(0.2))
                                            .frame(width: 325, height: 40)
                                    }
                            }
                            .frame(width: 325, height: 40)
                            .padding(.horizontal, 38)
                            .padding(.top, 5)
                        }
                        else if (viewModel.selectedCategory == "Food Waste") {
                            NavigationLink(destination: FoodWasteView()) {
                                Text("Continue")
                                    .foregroundStyle(Color.white)
                                    .background{
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.gray.opacity(0.2))
                                            .frame(width: 325, height: 40)
                                    }
                            }
                            .frame(width: 325, height: 40)
                            .padding(.horizontal, 38)
                            .padding(.top, 5)
                        }
                    }
                }
                .padding(.horizontal)
                
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

#Preview {
    HomeView(viewModel: HomeViewModel())
}
