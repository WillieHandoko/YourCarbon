//
//  ElectricityUsageView.swift
//  YourCarbon
//
//  Created by William Handoko on 02/10/24.
//

import SwiftUI

struct ElectricityUsageView: View {
    @StateObject private var viewModel = ElectricityUsageViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Electricity Usage Calculator")
                .font(.title)
                .padding()

            TextField("Electricity Usage (W)", text: $viewModel.electricityUsage)
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
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.primary)
            .cornerRadius(10)
            .padding()

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ElectricityUsageView()
}
