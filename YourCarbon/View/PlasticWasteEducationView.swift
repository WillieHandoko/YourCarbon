//
//  PlasticWasteEducationView.swift
//  YourCarbon
//
//  Created by William Handoko on 16/10/24.
//
import SwiftUI

struct PlasticWasteEducationView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Plastic Waste and Your Carbon Footprint")
                    .font(.title)
                    .padding(.top)

                Text("""
                Plastic waste is one of the most pervasive environmental issues, contributing not only to pollution but also to carbon emissions. The production and disposal of plastic products, especially single-use plastics, are responsible for a significant amount of greenhouse gases. Plastics are derived from fossil fuels, meaning that the extraction and processing of oil and gas for plastics production also release large amounts of CO₂.
                """)

                Text("""
                A considerable amount of plastic waste ends up in landfills, where it can take hundreds of years to decompose. As plastics break down, they release methane, a potent greenhouse gas that exacerbates global warming. Additionally, the incineration of plastic waste, often used in waste-to-energy processes, produces harmful emissions, including carbon dioxide and other pollutants.
                """)

                Text("""
                One of the most effective ways to reduce plastic waste is to minimize the use of single-use plastics, such as bags, straws, and packaging. Opting for reusable alternatives, like cloth bags and metal straws, can drastically reduce the amount of plastic waste generated. Consumers can also choose products made from recycled plastics or other sustainable materials, helping to reduce the demand for new plastic production.
                """)

                Text("""
                Governments and organizations around the world are taking steps to address the plastic waste crisis by banning single-use plastics, improving recycling systems, and promoting plastic alternatives. However, individuals can also take action by making more conscious purchasing decisions and advocating for better waste management systems in their communities.
                """)

                Text("""
                Reducing plastic waste not only helps to prevent environmental degradation but also cuts down on carbon emissions associated with the entire lifecycle of plastic products. From production to disposal, minimizing plastic use can have a positive impact on both the planet and public health.
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

#Preview{
    PlasticWasteEducationView()
}
