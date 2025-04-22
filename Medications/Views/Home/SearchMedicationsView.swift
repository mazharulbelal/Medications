//
//  SearchMedicationsView.swift
//  Medications
//
//  Created by Mazharul on 21/4/25.
//

import SwiftUI

struct SearchMedicationsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = SearchMedicationsViewModel()
    @State private var isFirstSearch = true
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                if viewModel.isLoading {
                    ProgressView("Searching...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding(.top, 40)
                        .transition(.opacity)
                }
                
                else if viewModel.searchQuery.isEmpty {
                    Text("Search for medications by entering a name.")
                        .foregroundColor(.gray)
                        .padding(.top, 20)
                        .transition(.opacity)
                    
                }
                
                else if !viewModel.isLoading && viewModel.conceptProperties.isEmpty {
                    VStack {
                        
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.gray)
                            .padding(.bottom, 8)
                        
                        Text("No results found.\nTry a different medication name.")
                            .font(.body)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                        
                    }
                    .transition(.opacity.combined(with: .scale))
                }
                
                
                if !viewModel.conceptProperties.isEmpty {
                    List {
                        Section(header: Text("Search Results")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .textCase(nil)) {
                                ForEach(viewModel.conceptProperties) { medicine in
                                    MedicationRow(name: "medicine")
                                }
                            }
                    }
                    .listStyle(.insetGrouped)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                
                Spacer()
            }
            .navigationTitle("Search Medications")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                }
            }
            .searchable(text: $viewModel.searchQuery, prompt: "Search Medications")
            .onChange(of: viewModel.searchQuery) { _ in
                if isFirstSearch {
                    isFirstSearch = false
                }
            }
        }
    }
}


#Preview {
    SearchMedicationsView()
}
