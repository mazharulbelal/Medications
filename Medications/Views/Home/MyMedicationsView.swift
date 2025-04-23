//
//  MyMedicationsView.swift
//  Medications
//
//  Created by Mazharul on 21/4/25.
//
//
import SwiftUI

struct MyMedicationsView: View {
    @State private var showingAddMedication = false
    @EnvironmentObject var viewModel: MedicationViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.myMedicationList) { medication in
                        MedicationRow(name: medication.name?.maxTwoWords() ?? "Invalid")
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    withAnimation {
                                        viewModel.deleteMedication(medication)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    showingAddMedication = true
                    viewModel.searchState = .isFirstTime
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                        Text("Search Medications")
                            .bold()
                    }
                    .foregroundColor(.blue)
                }
                .buttonStyle(.plain)
                .sheet(isPresented: $showingAddMedication) {
                    SearchMedicationsView()
                    
                }
            }
            .onAppear {
                viewModel.loadSavedMedications()
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("My Medications")
        }
    }
}


struct MedicationRow: View {
    var name: String
    var body: some View {
        HStack {
            Image("pill")
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.callout)
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
        }
        .padding(.vertical, 3)
    }
}

#Preview{
    MyMedicationsView()
}
