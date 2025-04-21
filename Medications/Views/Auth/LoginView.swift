//
//  LoginView.swift
//  Medications
//
//  Created by Mazharul on 21/4/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = "example@gmail.com"
    @State private var password = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            // Header
            
            VStack(alignment: .center, spacing: 8) {
                Text("Login")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
            }
            .padding(.top, 40)
            
            // Form Fields
            VStack(spacing: 16) {
                InputFieldView(label: "Email", text: $email, keyboardType: .emailAddress)
                InputFieldView(label: "Create a password", text: $password, isSecure: true)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            Spacer()
            
            // Logn Account Button
            ReusableButton(title: "Login", action: {
                print("Login Your Account")
                
            })
        }
        
        .padding(.bottom, 40)
    }
}


#Preview {
    LoginView()
}
