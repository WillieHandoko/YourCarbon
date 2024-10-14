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
                .font(.title)
                .padding()
            
            if records.isEmpty {
                Text("No records found for \(category)")
                    .foregroundColor(.gray)
                    .padding()
                
            } else {
                List(records.indices, id: \.self) { index in
                    if let fuelRecord = records[index] as? FuelUsage {
                        
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
                            
                            VStack(alignment: .center, spacing: 22) {
                                
                                HStack{
                                    Text("\(fuelRecord.date ?? Date(), formatter: dateFormatter)")
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("\(fuelRecord.vehicleType ?? "Unknown")")
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("\(fuelRecord.fuelType ?? "Unknown")")
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("\(fuelRecord.co2Footprint, specifier: "%.3f") kg CO₂")
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                    else if let electricityRecord = records[index] as? ElectricityUsage {
                        
                        HStack(spacing: 30) {
                            VStack(alignment:.center, spacing: 10){
                                Image(systemName: "calendar")
                                    .font(.system(size: 30))
                                Image(systemName: "bolt")
                                    .font(.system(size: 30))
                                Image(systemName: "leaf")
                                    .font(.system(size: 30))
                            }
                            
                            VStack(alignment: .center, spacing: 22) {
                                
                                HStack{
                                    Text("\(electricityRecord.date ?? Date(), formatter: dateFormatter)")
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("\(electricityRecord.electricityUsage, specifier: "%.3f") kWh")
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("\(electricityRecord.co2Footprint, specifier: "%.3f") kg CO₂")
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                    else if let lpgRecord = records[index] as? LPGUsage {
                        
                        HStack(spacing: 30) {
                            VStack(alignment:.center, spacing: 10){
                                Image(systemName: "calendar")
                                    .font(.system(size: 30))
                                Image(systemName: "macpro.gen2")
                                    .font(.system(size: 30))
                                Image(systemName: "leaf")
                                    .font(.system(size: 30))
                            }
                            
                            VStack(alignment: .center, spacing: 22) {
                                
                                HStack{
                                    Text("\(lpgRecord.date ?? Date(), formatter: dateFormatter)")
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("\(lpgRecord.lpgAmount, specifier: "%.3f") kg")
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("\(lpgRecord.co2Footprint, specifier: "%.3f") kg CO₂")
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                    else if let foodwasteRecord = records[index] as? FoodWaste {
                        
                        HStack(spacing: 30) {
                            VStack(alignment:.center, spacing: 10){
                                Image(systemName: "calendar")
                                    .font(.system(size: 30))
                                Image(systemName: "fork.knife.circle")
                                    .font(.system(size: 30))
                                Image(systemName: "leaf")
                                    .font(.system(size: 30))
                            }
                            
                            VStack(alignment: .center, spacing: 22) {
                                
                                HStack{
                                    Text("\(foodwasteRecord.date ?? Date(), formatter: dateFormatter)")
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("\(foodwasteRecord.foodType ?? "Unknown")")
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("\(foodwasteRecord.co2Footprint, specifier: "%.3f") kg CO₂")
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                            }
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
