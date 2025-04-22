//
//  AlertView.swift
//  Medications
//
//  Created by Mazharul on 22/4/25.
//

import SwiftUI

struct AlertView: View {
    var image: String?
    var title: String?
    var description: String
    var body: some View {
        VStack(spacing: 4) {
            if let messageImage = image {
                Image(systemName: messageImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray.opacity(0.6))
            }

            if let messageTitle = title {
                Text(messageTitle)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }

            Text(description)
                .font(.subheadline)
                .foregroundColor(.gray.opacity(0.8))
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}
