//
//  AuthManager.swift
//  Medications
//
//  Created by Mazharul on 23/4/25.
//
import Combine
import FirebaseAuth

class AuthManager {
    
    // Sign in function with Firebase authentication
    func signIn(withEmail email: String, password: String) -> AnyPublisher<User, Error> {
        return performAuthRequest { completion in
            Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        }
    }
    
    // Create account function with Firebase authentication
    func createAccount(withEmail email: String, password: String) -> AnyPublisher<User, Error> {
        return performAuthRequest { completion in
            Auth.auth().createUser(withEmail: email, password: password, completion: completion)
        }
    }
    
    // Sign out function
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    // Generalized function to handle authentication requests
    private func performAuthRequest(_ request: @escaping (@escaping (AuthDataResult?, Error?) -> Void) -> Void) -> AnyPublisher<User, Error> {
        return Future { promise in
            request { result, error in
                if let error = error {
                    promise(.failure(error))
                } else if let user = result?.user {
                    promise(.success(user))
                } else {
                    promise(.failure(NSError(domain: "UnknownError", code: -1, userInfo: nil)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
