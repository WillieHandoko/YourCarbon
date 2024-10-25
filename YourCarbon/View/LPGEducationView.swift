//
//  LPGEducationView.swift
//  YourCarbon
//
//  Created by William Handoko on 16/10/24.
//

import SwiftUI

struct LPGEducationView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("LPG and Your Carbon Footprint")
                    .font(.title)
                    .padding(.top)

                Text("""
                Liquefied petroleum gas (LPG) is a fossil fuel commonly used for heating, cooking, and transportation. While it produces fewer carbon emissions compared to coal and oil, LPG still contributes to greenhouse gas emissions when burned. Additionally, the extraction, processing, and transportation of LPG are associated with methane leaks and other environmental risks.
                """)

                Text("""
                One of the key advantages of LPG is its relatively high efficiency as a fuel source. In homes, LPG can be used for heating, cooking, and water heating with fewer emissions compared to traditional fuels like coal. However, like all fossil fuels, LPG is finite and contributes to the overall carbon footprint of households and businesses.
                """)

                Text("""
                To reduce the carbon footprint associated with LPG use, individuals can focus on energy efficiency. For example, using modern, high-efficiency appliances for cooking and heating can help reduce fuel consumption. In addition, regular maintenance of LPG systems can prevent leaks, which not only wastes fuel but also increases greenhouse gas emissions.
                """)

                Text("""
                Switching to alternative energy sources, such as solar or electric heating systems, can further reduce reliance on LPG. While these systems may require an initial investment, they offer long-term savings on fuel costs and significantly lower carbon emissions. In many regions, governments offer subsidies or tax incentives for households that switch to renewable energy systems.
                """)

                Text("""
                The future of low-carbon heating solutions lies in renewable energy. However, until renewable sources become more widely available and affordable, making the most of the efficiency and lower emissions of LPG can still help in the transition to a cleaner energy future.
                """)
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding()
        }
    }
}

#Preview {
    LPGEducationView()
}
