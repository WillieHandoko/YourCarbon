//
//  FoodWasteView.swift
//  YourCarbon
//
//  Created by William Handoko on 02/10/24.
//

import SwiftUI

struct FoodWasteView: View {
    @StateObject private var viewModel = FoodWasteViewModel()

    var body: some View {
        VStack {
            Text("Food Waste Calculator")
                .font(.largeTitle)
                .padding()

            TextField("Food Type", text: $viewModel.foodType)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)

            TextField("Weight (kg)", text: $viewModel.weight)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.decimalPad)
                .padding(.horizontal)

            Button("Calculate and Save Food Waste") {
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

#Preview {
    FoodWasteView()
}
