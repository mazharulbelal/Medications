//
//  MedicationsApp.swift
//  Medications
//
//  Created by Mazharul on 21/4/25.
//

import SwiftUI

@main
struct MedicationsApp: App {
    @StateObject private var medicationViewModel = MedicationViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(medicationViewModel)
        }
    }
}
