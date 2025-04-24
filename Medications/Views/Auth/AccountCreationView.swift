//
//  AccountCreationView.swift
//  Medications
//
//  Created by Mazharul on 21/4/25.
//
import SwiftUI

struct AccountCreationView: View {
    @State private var name = "Alice"
    @State private var email = "example@gmail.com"
    @State private var password = ""
    @ObservedObject private var viewModel = AuthViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            VStack(alignment: .center, spacing: 8) {
                Text("Create New Account")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
            }
            .padding(.top, 40)
            // Form Fields
            VStack(spacing: 16) {
                InputFieldView(label: "Name", text: $name, placeHolderText: "Alice")
                InputFieldView(label: "Email", text: $email, placeHolderText: "example@gmail", keyboardType: .emailAddress)
                InputFieldView(label: "Create a password", text: $password, placeHolderText: "•••••••", isSecure: true)
                
                if case .error(let error) = viewModel.authStatus {
                    Text(error)
                        .foregroundStyle(Color.red)
                        .font(.body)
                        .multilineTextAlignment(.center)
                    
                }
                
                if viewModel.authStatus == .success {
                    Text("Your account has been successfully created.\nPlease go back and log in to your account.")
                        .foregroundStyle(Color.green)
                        .font(.body)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            Spacer()
            
            
            if viewModel.authStatus != .loading {
                AppThemeButton(title: "Create the account", action: {
                    print("Login Your Account")
                    viewModel.createAccount(withEmail: "mazharul.belal@gmail.com", password: "Mykey2013")
                
                })
            }
            
            if viewModel.authStatus == .loading {
                ProgressView("Authenticating...\nPlease wait a moment.")
                    .multilineTextAlignment(.center)
            }
        }
        
        .padding(.bottom, 40)
    }
}



// Preview
#Preview {
    AccountCreationView()
}
