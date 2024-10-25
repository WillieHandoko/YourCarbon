//
//  LPGUsageView.swift
//  YourCarbon
//
//  Created by William Handoko on 02/10/24.
//

import SwiftUI

struct LPGUsageView: View {
    
    @ObservedObject private var viewModel = LPGUsageViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("LPG Usage Calculator")
                .font(.largeTitle)
                .padding()

            TextField("Enter LPG Amount (kg) (eg. 3,5,12)", text: $viewModel.lpgAmount)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.decimalPad)
                .padding(.horizontal)

            TextField("Enter Usage Time (days)", text: $viewModel.usageTime)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.numberPad)
                .padding(.horizontal)

            Button("Calculate LPG Footprint") {
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
    LPGUsageView()
}
