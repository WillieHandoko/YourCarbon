//
//  EmissionDetailView.swift
//  YourCarbon
//
//  Created by William Handoko on 10/10/24.
//

import SwiftUI

struct EmissionDetailView: View {
    var category: String
    var records: [Any] // Use Any and cast to specific types inside
    
    var body: some View {
        VStack {
            Text("\(category) Emissions Details")
                .font(.largeTitle)
                .padding()
            
            if records.isEmpty {
                //                Text("No records found for \(category)")
                //                    .foregroundColor(.gray)
                //                    .padding()
                
                List{
                    //First List
                    HStack(spacing: 30) {
                        VStack(alignment:.center, spacing: 10){
                            Image(systemName: "calendar")
                                .font(.system(size: 30))
                            Image(systemName: "car")
                                .font(.system(size: 30))
                            Image(systemName: "fuelpump")
                                .font(.system(size: 30))
                            Image(systemName: "leaf")
                                .font(.system(size: 30))
                           
                        }
                        VStack(alignment:.center, spacing: 22){
                            HStack{
                                Text("10 Oct 2024")
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            HStack{
                                Text("Sedan")
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            HStack{
                                Text("Gasoline")
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            HStack{
                                Text("20.0 kg")
                                    .fontWeight(.bold)
                                Spacer()
                            }
                        }
                    }
                    
                    //Second List
                    
                    HStack(spacing: 30) {
                        VStack(alignment:.center, spacing: 10){
                            Image(systemName: "calendar")
                                .font(.system(size: 30))
                            Image(systemName: "car")
                                .font(.system(size: 30))
                            Image(systemName: "fuelpump")
                                .font(.system(size: 30))
                            Image(systemName: "leaf")
                                .font(.system(size: 30))
                           
                        }
                        VStack(alignment:.center, spacing: 22){
                            HStack{
                                Text("10 Oct 2024")
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            HStack{
                                Text("Sedan")
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            HStack{
                                Text("Gasoline")
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            HStack{
                                Text("20.0 kg")
                                    .fontWeight(.bold)
                                Spacer()
                            }
                        }
                    }
                    
                    .padding(.vertical)
                }
                
                
            } else {
                List(records.indices, id: \.self) { index in
                    if let fuelRecord = records[index] as? FuelUsage {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Date: \(fuelRecord.date ?? Date(), formatter: dateFormatter)")
                                .font(.headline)
                            Text("CO₂ Footprint: \(fuelRecord.co2Footprint, specifier: "%.2f") kg")
                                .font(.subheadline)
                            Text("Vehicle Type: \(fuelRecord.vehicleType ?? "Unknown")")
                            Text("Fuel Type: \(fuelRecord.fuelType ?? "Unknown")")
                        }
                        .padding(.vertical)
                    }
                    // Add similar blocks for ElectricityUsage, LPGUsage, FoodWaste, etc.
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
    
    // Helper date formatter
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

#Preview {
    EmissionDetailView(category: "Fuel", records: [])
}
