//
//  TargetSettingView.swift
//  YourCarbon
//
//  Created by William Handoko on 02/10/24.
//

import SwiftUI

struct TargetSettingView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var targetReduction: String = ""

    var body: some View {
        VStack {
            Text("Set Carbon Reduction Target")
                .font(.largeTitle)
                .padding()

            TextField("Enter Target (kg CO₂)", text: $targetReduction)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.decimalPad)
                .padding(.horizontal)

            Button("Save Target") {
                if let target = Double(targetReduction) {
                    viewModel.setUserTarget(target)
                    viewModel.showTargetSetting = false
                }
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
    TargetSettingView(viewModel: .init())
}
