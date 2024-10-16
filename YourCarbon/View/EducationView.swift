//
//  EducationView.swift
//  YourCarbon
//
//  Created by William Handoko on 16/10/24.
//

import SwiftUI

struct EducationView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Learn about Your Carbon Footprint")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                
                // Navigation to each category
                VStack {
                    NavigationLink(destination: ElectricityEducationView()) {
                        EducationCategoryButton(title: "Electricity")
                    }
                    NavigationLink(destination: PlasticWasteEducationView()) {
                        EducationCategoryButton(title: "Plastic Waste")
                    }
                    NavigationLink(destination: FuelEducationView()) {
                        EducationCategoryButton(title: "Fuel")
                    }
                    NavigationLink(destination: LPGEducationView()) {
                        EducationCategoryButton(title: "LPG")
                    }
                }
                Spacer()
            }
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}

struct EducationCategoryButton: View {
    var title: String
    var body: some View {
        Text(title)
            .frame(width: 240,height: 50)
            .font(.title3)
            .fontWeight(.bold)
            .padding()
            .background(Color.gray.opacity(0.2))
            .foregroundColor(.white)
            .cornerRadius(10)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    EducationView()
}
