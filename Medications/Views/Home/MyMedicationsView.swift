//
//  MyMedicationsView.swift
//  Medications
//
//  Created by Mazharul on 21/4/25.
//
//
import SwiftUI
//
//
//struct MyMedicationsView: View {
//    @State private var medications = Medication.dummy
//    @State private var showingAddMedication = false
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                List {
//                    ForEach(medications) { medication in
//                        MedicationRow(name:"Medicine")
//                            .swipeActions(edge: .trailing) {
//                                Button(role: .destructive) {
//                                    withAnimation {
//                                        medications.removeAll { $0.id == medication.id }
//                                    }
//                                } label: {
//                                    Label("Delete", systemImage: "trash")
//                            }
//                        }
//                    }
//                }
//                
//                Spacer()
//                
//                Button(action: {
//                    showingAddMedication = true
//                }) {
//                    HStack {
//                        Image(systemName: "plus.circle.fill")
//                            .font(.title2)
//                        Text("Search Medications")
//                            .bold()
//                    }
//                    .foregroundColor(.blue)
//                }
//                .buttonStyle(.plain)
//                .sheet(isPresented: $showingAddMedication) {
//                    SearchMedicationsView()
//                    
//                }
//            }
//            .background(Color(UIColor.systemGroupedBackground))
//            .navigationTitle("My Medications")
//        }
//        
//    }
//}


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

//
//#Preview{
//    MyMedicationsView()
//}
