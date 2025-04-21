//
//  HomeView.swift
//  Medications
//
//  Created by Mazharul on 21/4/25.
//

import SwiftUI

struct HomeView: View {
    @State private var animate = false

    var body: some View {
        ZStack {
            Color(hex: "#E0EAFF")
                .ignoresSafeArea()

            VStack {
                Spacer()

                // Logo 
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .padding()
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.8)
                    .animation(.easeOut(duration: 0.6).delay(0.2), value: animate)

                Spacer()

                // "Create the account" Button
                Button(action: {
                    print("Create the account tapped")
                }) {
                    Text("Create the account")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .shadow(radius: 5)
                }
                .opacity(animate ? 1 : 0)
                .offset(y: animate ? 0 : 20)
                .animation(.easeOut(duration: 0.5).delay(0.4), value: animate)

                // "I already have an account" Button
                Button(action: {
                    print("I already have an account tapped")
                }) {
                    Text("I already have an account")
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .padding(.horizontal)
                        .padding(.bottom, 30)
                }
                .opacity(animate ? 1 : 0)
                .offset(y: animate ? 0 : 20)
                .animation(.easeOut(duration: 0.5).delay(0.6), value: animate)
            }
        }
        .onAppear {
            animate = true
        }
    }
}

#Preview {
    HomeView()
}

