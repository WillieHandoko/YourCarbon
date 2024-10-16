//
//  ElectricityEducationView.swift
//  YourCarbon
//
//  Created by William Handoko on 16/10/24.
//
import SwiftUI

struct ElectricityEducationView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Electricity and Your Carbon Footprint")
                    .font(.title)
                    .padding(.top)

                Text("""
                Electricity consumption is a major contributor to global carbon emissions, especially in regions that rely on non-renewable energy sources such as coal, natural gas, and oil. These fossil fuels release carbon dioxide and other greenhouse gases when burned to generate electricity, exacerbating climate change. As the demand for electricity continues to rise with the growth of technology and urbanization, reducing electricity-based carbon emissions has become a critical environmental challenge.
                """)

                Text("""
                One of the key issues in electricity generation is the heavy reliance on coal-fired power plants, which produce the highest levels of carbon emissions among energy sources. Switching from coal to renewable energy such as wind, solar, or hydroelectric power can significantly reduce a country's carbon footprint. Countries that have made substantial investments in renewable energy, such as Germany and Denmark, have already seen declines in their national emissions.
                """)

                Text("""
                On an individual level, reducing electricity consumption can be achieved through a number of practical steps. Energy-efficient appliances, for example, use less electricity to perform the same tasks as traditional appliances. Compact fluorescent lamps (CFLs) and LED lights are two great examples of energy-efficient alternatives to incandescent bulbs, reducing energy consumption by up to 75%.
                """)

                Text("""
                Another effective strategy is utilizing smart technologies, such as programmable thermostats and smart home systems. These devices optimize heating and cooling schedules and can automatically adjust energy consumption based on usage patterns. This helps homeowners save energy without sacrificing comfort, leading to a smaller carbon footprint.
                """)

                Text("""
                Additionally, unplugging devices that are not in use can help reduce electricity waste from standby power. Even when electronics are turned off, many continue to draw small amounts of power. Using power strips or unplugging devices manually can eliminate this "phantom load," further cutting down on unnecessary carbon emissions.
                """)

                Text("Sources:")
                    .font(.headline)
                VStack(alignment: .leading, spacing: 10) {
                    Link("Electricity and the Environment", destination: URL(string: "https://www.epa.gov/energy/electricity-and-environment")!)
                    Link("10 Ways to Save Energy at Home", destination: URL(string: "https://www.energy.gov/energysaver/energy-saver")!)
                    Link("Renewable Energy and Carbon Emissions", destination: URL(string: "https://www.nrdc.org/stories/renewable-energy-and-carbon-emissions")!)
                    Link("How to Optimize Your Electricity Use", destination: URL(string: "https://www.worldwildlife.org/initiatives/renewable-energy")!)
                    Link("Smart Home Energy Efficiency", destination: URL(string: "https://www.energystar.gov/products/smart_home")!)
                }
                .foregroundColor(.blue)
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
    ElectricityEducationView()
}
