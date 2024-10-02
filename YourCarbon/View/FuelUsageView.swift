//
//  FuelUsageView.swift
//  YourCarbon
//
//  Created by William Handoko on 02/10/24.
//

import SwiftUI

struct FuelUsageView: View {
    @StateObject private var viewModel = FuelUsageViewModel()

    var body: some View {
        VStack {
            Text("Fuel Usage Calculator")
                .font(.largeTitle)
                .padding()

            TextField("Vehicle Type", text: $viewModel.vehicleType)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)

            TextField("Fuel Type", text: $viewModel.fuelType)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)

            TextField("Fuel Consumption (liters)", text: $viewModel.fuelConsumption)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.decimalPad)
                .padding(.horizontal)

            TextField("Vehicle Range (km)", text: $viewModel.vehicleRange)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.decimalPad)
                .padding(.horizontal)

            Button("Calculate and Save Fuel Usage") {
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
