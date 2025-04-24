//
//  LoginView.swift
//  Medications
//
//  Created by Mazharul on 21/4/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            VStack(alignment: .center, spacing: 8) {
                Text("Login")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
            }
            .padding(.top, 40)
            VStack(spacing: 16) {
                InputFieldView(label: "Email", text: $email, placeHolderText: "example@email", keyboardType: .emailAddress)
                InputFieldView(label: "Type your password", text: $password, placeHolderText: "•••••••", isSecure: true)
                if case .error(let error) = viewModel.authStatus {
                    Text(error)
                        .foregroundStyle(Color.red)
                        .font(.body)
                        .multilineTextAlignment(.center)
                    
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            Spacer()
            
            
            if viewModel.authStatus != .loading {
                AppThemeButton(title: "Login", action: {
                    print("Login Your Account")
                    viewModel.signIn(withEmail: email, password: password)
                    
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




struct InputFieldView: View {
    var label: String
    @Binding var text: String
    var placeHolderText: String
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(hex: "#E0E3E7"))
                    .frame(height: 60)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(label)
                        .font(.caption)
                        .foregroundColor(.black)
                    
                    if isSecure {
                        SecureField(placeHolderText, text: $text)
                            .keyboardType(keyboardType)
                            .foregroundColor(.gray)
                        
                        
                    } else {
                        TextField(placeHolderText, text: $text)
                            .foregroundColor(Color.gray)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .disableAutocorrection(true)
                        
                        
                    }
                }
                .padding(.horizontal, 12)
            }
        }
    }
}



#Preview {
    LoginView()
}
