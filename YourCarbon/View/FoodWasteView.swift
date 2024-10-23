//
//  FoodWasteView.swift
//  YourCarbon
//
//  Created by William Handoko on 02/10/24.
//

import SwiftUI

struct FoodWasteView: View {
    @StateObject private var viewModel = FoodWasteViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Plastic Waste Calculator")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .padding()

            TextField("Plastic Type (eg. plastic bottles)", text: $viewModel.foodType)
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

            Button("Calculate and Save Plastic Waste") {
                viewModel.calculateFootprint()
                presentationMode.wrappedValue.dismiss()
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
