//
//  MedicationDetailView.swift
//  Medications
//
//  Created by Mazharul on 22/4/25.
//

import SwiftUI

struct MedicationDetailView: View {
    let conceptProperty: ConceptPropertyDTO
    @Environment(\.dismiss) var dismiss
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 0.0
    @ObservedObject var viewModel: MedicationViewModel
    
    var body: some View {
        VStack{
            VStack {
                Image("pill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding()
                
                Text(conceptProperty.psn?.maxTwoWords() ?? "Napa One")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(conceptProperty.name?.maxTwoWords() ?? "Paracetamol")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.5)) {
                    scale = 1.1
                    opacity = 1.0
                }
            }
            .padding(.bottom)
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Details")
                        .font(.title3)
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        DosageSection(
                            title: "Tablet:",
                            instructions: [
                                "Adult: 1–2 tablets every 4 to 6 hours up to a maximum of 4 gm (8 tablets) daily.",
                                "Children (6–12 years): ½ to 1 tablet 3 to 4 times daily. For long term treatment it is wise not to exceed the dose beyond 2.6 gm/day."
                            ]
                        )
                        
                        DosageSection(
                            title: "Extended Release Tablet:",
                            instructions: [
                                "Adults & Children over 12 years: Two tablets, swallowed whole, every 6 to 8 hours (maximum of 6 tablets in any 24 hours). The tablet must not be crushed.",
                                
                            ]
                        )
                        
                        DosageSection(
                            title: "Syrup/Suspension:",
                            instructions: [
                                "Children under 3 months: 10 mg/kg body weight (reduce to 5 mg/kg if necessary)."
                            ]
                        )
                    }
                    
                }
                .padding()
            }
            .background(Color(.white))
            .clipShape(RoundedCorner(radius: 10, corners: [.topRight, .topLeft]))
            .padding(.horizontal, 20)
            
            AppThemeButton(title: "Add Medication to List", action: {
                viewModel.saveToRealm(model: conceptProperty)
                print("Add Medication to List")
            })
            .padding(.bottom)
            .background(Color.white)
        }
        .background(Color(.systemGray6))
        .navigationBarTitle("Details", displayMode: .inline)
        .navigationTitle("Search Medications")
        
    }
}


struct DosageSection: View {
    let title: String
    let instructions: [String]
    
    var body: some View {
        Group {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
            
            ForEach(instructions, id: \.self) { instruction in
                Text("• \(instruction)")
            }
        }
    }
}
