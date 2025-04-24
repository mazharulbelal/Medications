//
//  MedicationsApp.swift
//  Medications
//
//  Created by Mazharul on 21/4/25.
//

import SwiftUI
import Firebase

@main
struct MedicationsApp: App {
   
    init() {
           FirebaseApp.configure()
       }
    
    @StateObject private var medicationViewModel = MedicationViewModel()
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some Scene {
            WindowGroup {
                if authViewModel.isLoggedIn {
                    MyMedicationsView()
                        .environmentObject(authViewModel)
                        .environmentObject(medicationViewModel)
                } else {
                    HomeView()
                        .environmentObject(authViewModel)
                }
            }
        }
    }
