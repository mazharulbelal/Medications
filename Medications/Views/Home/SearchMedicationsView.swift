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
    @State private var searchText = ""
    @FocusState private var isSearchFocused: Bool
    @State private var keyboardHeight: CGFloat = 0
    @State private var showingMedicationDetailView = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    // iOS-style Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $searchText)
                            .focused($isSearchFocused)
                            .textFieldStyle(PlainTextFieldStyle())
                            .submitLabel(.search)
                    }
                    .padding(10)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .padding()
                    Spacer()
                    switch viewModel.searchState {
                        
                    case .isFirstTime:
                        AlertView(image: "hand.point.up.left.fill",
                                  title: "Welcome!",
                                  description: "Start by entering a keyword in the search bar to find medications or concepts.")
                        Spacer()
                        
                    case .empty:
                        AlertView(image: "magnifyingglass",
                                  title: "No results found",
                                  description: "Try searching with a different keyword.")
                        Spacer()
                        
                    case .isLoading:
                        ProgressView("Searching...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding(.top, 40)
                            .transition(.opacity)
                        
                    case .loaded:
                        Section(header: Text("Search Results")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .listRowBackground(Color.clear)) {
                                List(viewModel.conceptProperties) { conceptProperty in
                                    NavigationLink(destination: MedicationDetailView(conceptProperty: conceptProperty)) {
                                        MedicationRow(name: conceptProperty.name ?? "")
                                    }
                                }
                            }
                        
                    case .error(let message):
                        AlertView(image: "exclamationmark.triangle.fill",
                                  description: message)
                        Spacer()
                    }
                }
                
                
                if isSearchFocused && !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    ReusableButton(title: "Search") {
                        viewModel.searchQuery = searchText
                        hideKeyboard()
                        isSearchFocused = false
                    }
                    .padding(.bottom, 10);
                    
                }
            }

            .background(Color(UIColor.systemGroupedBackground))
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                    if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                        withAnimation {
                            keyboardHeight = keyboardFrame.height
                        }
                    }
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                    withAnimation {
                        keyboardHeight = 0
                    }
                }
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
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}

#Preview {
    SearchMedicationsView()
}
