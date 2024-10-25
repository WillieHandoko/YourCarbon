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
                    .font(.title2)
                    .foregroundColor(.primary)
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
                HStack{
                    Text("Sources:")
                        .font(.headline)
                        .padding(.leading,28)
                    Spacer()
                }
                HStack{
                    VStack(alignment: .leading, spacing: 10) {
                        Link("U.S. Environmental Protection Agency", destination: URL(string: "https://www.epa.gov")!)
                        Link("Natural Resources Defense Council", destination: URL(string: "https://www.nrdc.org")!)
                        Link("United Nations Environment Programme", destination: URL(string: "https://www.unep.org")!)
                        Link("World Resources Institute", destination: URL(string: "https://www.wri.org")!)
                        Link("Energy", destination: URL(string: "https://www.energy.gov")!)
                    }
                    Spacer()
                }
                .padding(.leading,28)
                .foregroundColor(.blue)
                Spacer()
            }
            .padding()
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
            .foregroundColor(.primary)
            .cornerRadius(10)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    EducationView()
}
