//
//  AuthViewModel.swift
//  Medications
//
//  Created by Mazharul on 23/4/25.
//

import Combine
import FirebaseAuth
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var authStatus: ApiStatus = .idle
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    private var cancellables = Set<AnyCancellable>()
    private let authManager = AuthManager()
    
    // Sign in with email & password using Firebase.
    func signIn(withEmail email: String, password: String) {
        authStatus = .loading
        authManager.signIn(withEmail: email, password: password)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.authStatus = .error(error.localizedDescription)
                }
            }, receiveValue: { [weak self] user in
                self?.authStatus = .success
                self?.isLoggedIn = true
            })
            .store(in: &cancellables)
    }
    
    // Create user account with email & password using .
    func createAccount(withEmail email: String, password: String) {
        authStatus = .loading
        authManager.createAccount(withEmail: email, password: password)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.authStatus = .error(error.localizedDescription)
                }
            }, receiveValue: { [weak self] user in
                self?.authStatus = .success
            })
            .store(in: &cancellables)
    }
    
 // Sign out user and reset auth state.
    func signOut() {
        do {
            try authManager.signOut()
            authStatus = .idle
            isLoggedIn = false
        } catch {
            authStatus = .error(error.localizedDescription)
        }
    }
}



