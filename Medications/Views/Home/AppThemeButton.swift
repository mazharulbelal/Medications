//
//  AppThemeButton.swift
//  Medications
//
//  Created by Mazharul on 23/4/25.
//

import SwiftUI

struct AppThemeButton: View {
    var title: String
    var action: () -> Void
    @State private var animate = false
    
    var body: some View {
        Button(action: action) {
            Text(title)
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
        .onAppear {
            withAnimation(.easeOut(duration: 0.5).delay(0.4)) {
                animate = true
            }
        }
    }
}
