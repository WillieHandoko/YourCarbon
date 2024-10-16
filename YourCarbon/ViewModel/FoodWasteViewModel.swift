//
//  FoodWasteViewModel.swift
//  YourCarbon
//
//  Created by William Handoko on 02/10/24.
//

import SwiftUI

class FoodWasteViewModel: ObservableObject {
    @Published var foodType: String = ""
    @Published var weight: String = ""

    func calculateFootprint() {
        guard let weight = Double(weight) else { return }

        let co2Footprint = weight * 6 // Approx CO2 per kg of food waste
        CoreDataManager.shared.saveFoodWaste(foodType: foodType, weight: weight, footprint: co2Footprint)
    }
}
