//
//  FuelEducationView.swift
//  YourCarbon
//
//  Created by William Handoko on 16/10/24.
//

import SwiftUI

struct FuelEducationView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Fuel and Your Carbon Footprint")
                    .font(.title)
                    .padding(.top)

                Text("""
                Fuel consumption, particularly gasoline and diesel, is a significant contributor to carbon emissions worldwide. The burning of fossil fuels in vehicles releases large quantities of carbon dioxide (CO₂) and other harmful gases into the atmosphere, contributing to global warming. As vehicle ownership continues to grow, especially in developing countries, addressing the carbon footprint from fuel consumption has become an urgent priority.
                """)

                Text("""
                One of the major problems with fossil fuel-powered vehicles is their inefficiency. Internal combustion engines lose a lot of energy through heat, friction, and other processes, meaning that a large portion of the fuel used doesn't actually go towards moving the vehicle. By switching to electric or hybrid vehicles, which are much more energy-efficient, individuals can drastically reduce their transportation-based carbon footprint.
                """)

                Text("""
                For those not ready to make the leap to electric vehicles, there are still plenty of ways to reduce fuel consumption. Regular vehicle maintenance, such as keeping tires properly inflated and changing air filters, can improve fuel efficiency. Additionally, adopting better driving habits, such as accelerating smoothly and avoiding excessive idling, can further decrease fuel consumption and associated emissions.
                """)

                Text("""
                Public transportation, carpooling, and biking are other highly effective ways to cut down on fuel usage. By sharing rides or choosing to walk or bike for shorter trips, individuals can not only reduce their own carbon footprint but also help alleviate traffic congestion and improve air quality in urban areas. Governments and cities are increasingly investing in cycling infrastructure and public transportation networks to encourage these behaviors.
                """)

                Text("""
                Reducing our dependence on fossil fuels will require a combination of individual action and systemic change. While technological advancements like electric vehicles are making a difference, reducing the overall demand for fuel through lifestyle changes and the promotion of cleaner transportation methods will be key in the fight against climate change.
                """)
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    FuelEducationView()
}
