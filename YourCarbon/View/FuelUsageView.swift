//
//  FuelUsageView.swift
//  YourCarbon
//
//  Created by William Handoko on 02/10/24.
//

import SwiftUI

struct FuelUsageView: View {
    @StateObject private var viewModel = FuelUsageViewModel()
    let fuelType: [String] = ["Gasoline","Diesel"]
    @State var choosedGasoline: Bool = true
    @State var choosedDiesel: Bool = false
    @State private var navigateToHome = false
    
    var body: some View {
        VStack {
            Text("Fuel Usage Calculator")
                .font(.largeTitle)
                .padding()
            
            TextField(
                "Vehicle Type (e.g. Car, Truck, SUV)",
                text: $viewModel.vehicleType
            )
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal)
            
            HStack{
                Button {
                    viewModel.fuelType = "Gasoline"
                    choosedGasoline = true
                    choosedDiesel = false
                } label: {
                    Text("Gasoline")
                        .foregroundStyle(Color.white)
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    choosedGasoline ? Color.green : Color.gray
                                        .opacity(0.0),
                                    lineWidth: 1
                                )
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 165, height: 50)
                            
                        }
                        .frame(width: 165, height: 50)
                }
                Button {
                    viewModel.fuelType = "Diesel"
                    choosedDiesel = true
                    choosedGasoline = false
                } label: {
                    Text("Diesel")
                        .foregroundStyle(Color.white)
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    choosedDiesel ? Color.green : Color.gray
                                        .opacity(0.0),
                                    lineWidth: 1
                                )
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 165, height: 50)
                            
                        }
                        .frame(width: 165, height: 50)
                }
                
            }
            
            TextField(
                "Fuel Consumption (km / liters)",
                text: $viewModel.fuelConsumption
            )
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .keyboardType(.decimalPad)
            .padding(.horizontal)
            
            TextField("Vehicle Range (km)", text: $viewModel.vehicleRange)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.decimalPad)
                .padding(.horizontal)
            
            
            if (
                viewModel.fuelConsumption.isEmpty || viewModel.vehicleRange.isEmpty || viewModel.vehicleType.isEmpty
            ) {
                if (choosedGasoline && !choosedDiesel) {
                    Button("Calculate and Save Fuel Usage") {
                        viewModel.calculateFootprintGasoline()
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .padding()
                    .disabled(true)
                }
                
                if (choosedDiesel && !choosedGasoline) {
                    Button("Calculate and Save Fuel Usage") {
                        viewModel.calculateFootprintDiesel()
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .padding()
                    .disabled(true)
                }
               
            } else if (
                !viewModel.fuelConsumption.isEmpty && !viewModel.vehicleRange.isEmpty && !viewModel.vehicleType.isEmpty
            ){
                if (choosedGasoline && !choosedDiesel) {
                    Button("Calculate and Save Fuel Usage") {
                        viewModel.calculateFootprintGasoline()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .padding()
                }
                
                if (choosedDiesel && !choosedGasoline) {
                    Button("Calculate and Save Fuel Usage") {
                        viewModel.calculateFootprintDiesel()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .padding()
                }
            }
            
            
            Spacer()
            
            NavigationLink(value: navigateToHome) {
                EmptyView() // Invisible view acting as a navigation trigger
            }
        }
        .navigationDestination(isPresented: $navigateToHome) {
            HomeView()
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    FuelUsageView()
}
