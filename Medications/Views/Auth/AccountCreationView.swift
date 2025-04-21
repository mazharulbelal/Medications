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
    
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            // Header
            
            VStack(alignment: .center, spacing: 8) {
                Text("Create New Account")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
            }
            .padding(.top, 40)
            
            // Form Fields
            VStack(spacing: 16) {
                InputFieldView(label: "Name", text: $name)
                InputFieldView(label: "Email", text: $email, keyboardType: .emailAddress)
                InputFieldView(label: "Create a password", text: $password, isSecure: true)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            Spacer()
            
            // Create Account Button
            ReusableButton(title: "Create the account", action: {
                print("Create the account tapped")
                
            })
        }
  
        .padding(.bottom, 40)
    }
}

struct InputFieldView: View {
    var label: String
    @Binding var text: String
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
                        SecureField("", text: $text)
                            .keyboardType(keyboardType)
                            .foregroundColor(.gray)
                        
                    } else {
                        TextField("", text: $text)
                            .keyboardType(keyboardType)
                            .autocapitalization(.none)
                            .foregroundColor(Color.gray)
                    }
                }
                .padding(.horizontal, 12)
            }
        }
    }
}


// Preview
#Preview {
    AccountCreationView()
}
