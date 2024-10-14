//
//  FuelUsageViewModel.swift
//  YourCarbon
//
//  Created by William Handoko on 02/10/24.
//

import SwiftUI

class FuelUsageViewModel: ObservableObject {
    @Published var vehicleType: String = ""
    @Published var fuelType: String = "Gasoline"
    @Published var fuelConsumption: String = ""
    @Published var vehicleRange: String = ""
    var co2Footprint: Double = 0
    
    func calculateFootprintGasoline() {
        guard let fuelConsumption = Double(fuelConsumption),
              let vehicleRange = Double(vehicleRange) else { return }
        co2Footprint = ((0.7890/((fuelConsumption * vehicleRange)*1000*1000))*69300*41.868)
        CoreDataManager.shared.saveFuelUsage(vehicleType: vehicleType, fuelType: fuelType, fuelConsumption: fuelConsumption, vehicleRange: vehicleRange, footprint: co2Footprint)
    }
    
    func calculateFootprintDiesel() {
        guard let fuelConsumption = Double(fuelConsumption),
              let vehicleRange = Double(vehicleRange) else { return }
        co2Footprint = ((0.8677/((fuelConsumption * vehicleRange)*1000*1000))*74100*41.868)
        CoreDataManager.shared.saveFuelUsage(vehicleType: vehicleType, fuelType: fuelType, fuelConsumption: fuelConsumption, vehicleRange: vehicleRange, footprint: co2Footprint)
    }
}

