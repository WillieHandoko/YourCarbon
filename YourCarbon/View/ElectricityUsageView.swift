//
//  ElectricityUsageView.swift
//  YourCarbon
//
//  Created by William Handoko on 02/10/24.
//

import SwiftUI

struct ElectricityUsageView: View {
    @StateObject private var viewModel = ElectricityUsageViewModel()

    var body: some View {
        VStack {
            Text("Electricity Usage Calculator")
                .font(.largeTitle)
                .padding()

            TextField("Electricity Usage (kWh)", text: $viewModel.electricityUsage)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.decimalPad)
                .padding(.horizontal)

            TextField("Usage Time (hours)", text: $viewModel.usageTime)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.numberPad)
                .padding(.horizontal)

            Button("Calculate and Save Electricity Usage") {
                viewModel.calculateFootprint()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.black)
            .cornerRadius(10)
            .padding()

            Spacer()
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
