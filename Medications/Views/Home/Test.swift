//
//  Test.swift
//  Medications
//
//  Created by Mazharul on 22/4/25.
//
import SwiftUI

struct NativeSearchBarWithSubmit: View {
    @State private var searchText = ""
    @FocusState private var isSearchFocused: Bool
    @State private var keyboardHeight: CGFloat = 0

    var body: some View {
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
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding()

                Spacer()
            }

            // ✅ Show only when focused AND search text is not blank
            if isSearchFocused && !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Button(action: {
                    print("Searching: \(searchText)")
                    hideKeyboard()
                    isSearchFocused = false
                }) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                }
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: keyboardHeight)
            }
        }
        .onAppear {
            // Keyboard Show/Hide Listeners
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
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    private func safeAreaBottomInset() -> CGFloat {
        UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    }
}

#Preview {
    NativeSearchBarWithSubmit()
}
