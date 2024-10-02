//
//  CoreDataManager.swift
//  YourCarbon
//
//  Created by William Handoko on 02/10/24.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "EmissionCalculatorApp")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - User Management
    func fetchUser() -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users = try context.fetch(request)
            return users.first
        } catch {
            print("Failed to fetch user: \(error)")
            return nil
        }
    }

    func createUser(username: String) -> User {
        let user = User(context: context)
        user.username = username
        saveContext()
        return user
    }

    func updateUserTarget(user: User, targetReduction: Double) {
        if let target = user.target {
            target.targetReduction = targetReduction
        } else {
            let newTarget = UserTarget(context: context)
            newTarget.targetReduction = targetReduction
            user.target = newTarget
        }
        saveContext()
    }

    // MARK: - FuelUsage Management
    func saveFuelUsage(vehicleType: String, fuelType: String, fuelConsumption: Double, vehicleRange: Double, footprint: Double) {
        let fuelUsage = FuelUsage(context: context)
        fuelUsage.vehicleType = vehicleType
        fuelUsage.fuelType = fuelType
        fuelUsage.fuelConsumption = fuelConsumption
        fuelUsage.vehicleRange = vehicleRange
        fuelUsage.co2Footprint = footprint
        fuelUsage.date = Date()
        saveContext()
    }

    func fetchFuelUsage() -> [FuelUsage] {
        let request: NSFetchRequest<FuelUsage> = FuelUsage.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch fuel usage: \(error)")
            return []
        }
    }

    // MARK: - LPGUsage Management
    func saveLPGUsage(lpgAmount: Double, usageTime: Int, footprint: Double) {
        let lpgUsage = LPGUsage(context: context)
        lpgUsage.lpgAmount = lpgAmount
        lpgUsage.usageTime = Int16(usageTime)
        lpgUsage.co2Footprint = footprint
        lpgUsage.date = Date()
        saveContext()
    }

    func fetchLPGUsage() -> [LPGUsage] {
        let request: NSFetchRequest<LPGUsage> = LPGUsage.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch LPG usage: \(error)")
            return []
        }
    }

    // MARK: - ElectricityUsage Management
    func saveElectricityUsage(electricityAmount: Double, usageTime: Int, footprint: Double) {
            let electricityUsage = ElectricityUsage(context: context)
            electricityUsage.electricityUsage = electricityAmount // Rename the parameter here
            electricityUsage.usageTime = Int16(usageTime)
            electricityUsage.co2Footprint = footprint
            electricityUsage.date = Date()
            saveContext()
        }

    func fetchElectricityUsage() -> [ElectricityUsage] {
        let request: NSFetchRequest<ElectricityUsage> = ElectricityUsage.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch electricity usage: \(error)")
            return []
        }
    }

    // MARK: - FoodWaste Management
    func saveFoodWaste(foodType: String, weight: Double, footprint: Double) {
        let foodWaste = FoodWaste(context: context)
        foodWaste.foodType = foodType
        foodWaste.weight = weight
        foodWaste.co2Footprint = footprint
        foodWaste.date = Date()
        saveContext()
    }

    func fetchFoodWaste() -> [FoodWaste] {
        let request: NSFetchRequest<FoodWaste> = FoodWaste.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch food waste: \(error)")
            return []
        }
    }

    // MARK: - Save Context
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
