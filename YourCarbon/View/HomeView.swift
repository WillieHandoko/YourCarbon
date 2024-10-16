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
    let category: [String] = ["Fuel Usage","LPG Usage","Electricity Usage","Plastic Waste"]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                LabeledContent("Welcome to YourCarbon!") {
                    Button (action: {
                        viewModel.showTargetSetting = true
                    }, label: {
                        Image(systemName: "gear.circle")
                            .font(.largeTitle)
                            .padding(.trailing,5)
                    })
                }
                .font(.title3)
                .fontWeight(.bold)
                .padding(.horizontal, 25)
                
                if let target = viewModel.userTarget {
                    Text("Monthly emmisions limit : \(target, specifier: "%.1f") kg CO₂")
                        .font(.callout)
                        .foregroundColor(viewModel.isOverTarget ? .orange : .green)
                }
                
                ProgressView(value: ((viewModel.totalFootprints/(viewModel.userTarget ?? 0))*100)/100, label: {}, currentValueLabel: { Text("\((viewModel.totalFootprints/(viewModel.userTarget ?? 0))*100, specifier: "%.0f")%") })
                    .progressViewStyle(BarProgressStyle(height: 25.0))
                    .padding(.horizontal,30)
                
                
                
                // Navigation Links for calculating carbon footprint
                VStack {
                    
                    // Chart to show today's emissions by category
                    Chart(viewModel.todayEmissionData) { data in
                        BarMark(
                            x: .value("Category", data.category),
                            y: .value("Emissions", data.co2Emission)
                        )
                        .cornerRadius(5)
                        .foregroundStyle(.yellow)
                    }
                    .chartYScale(domain: 0...(viewModel.totalFootprint + 10))
                    .frame(height: 300)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
                    .padding()
                    
                    // Display today's total carbon emissions
                    VStack{
                        Text("Total Carbon Emissions")
                        Text("This Month : \(viewModel.totalFootprints, specifier: "%.3f") kg CO₂")
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
                        else if (viewModel.selectedCategory == "Plastic Waste") {
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
                viewModel.fetchTodayEmissions()
                viewModel.fetchEmissions()// Fetch today's emissions for chart
            }
        }
    }
}

struct BarProgressStyle: ProgressViewStyle {

    var color: Color = .gray.opacity(0.5)
    var height: Double = 5.0
    var labelFontStyle: Font = .body

    func makeBody(configuration: Configuration) -> some View {

        let progress = configuration.fractionCompleted ?? 0.0

        GeometryReader { geometry in

            HStack{
                VStack(alignment: .leading) {
                    
                    configuration.label
                        .font(labelFontStyle)
                    
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(Color(uiColor: .systemGray5))
                        .frame(height: height)
                        .frame(width: geometry.size.width * 0.8)
                        .overlay(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 5.0)
                                .fill(color)
                                .frame(width: geometry.size.width * 0.8 * progress)
                            
                            
                        }
                    
                }
                if let currentValueLabel = configuration.currentValueLabel {
                    
                    currentValueLabel
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.leading,10)
                }
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
