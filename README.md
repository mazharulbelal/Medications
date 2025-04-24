# 💊 Drug Search and Tracker

An iOS application built with SwiftUI and MVVM architecture that allows users to search for drugs using the National Library of Medicine's RxNorm API, view detailed information, and manage a personal medication list. The app uses Firebase for email authentication and RealmDB for local data storage.

---

## 📸 Demo Video

▶️ [Watch the demo on YouTube](https://youtu.be/Or_hiWFpU78)

---

## 🧩 Features Implemented

-  Firebase Email Authentication (Login & Signup)
-  Drug Search using RxNorm API
-  Display search results
-  Add drug to personal medication list
-  Delete drug via swipe gesture
-  Retrieve user drugs on login
-  Offline data storage with RealmDB
-  Combine for networking and data binding
-  Repository pattern for API and local database abstraction
-  Dependency injection for testability and modularity
-  Coordinator pattern for navigation
-  Proper memory management using `[weak self]`
  
---

## 🛠️ Technologies Used
- **iOS Deployment Target**: 16.0+
- **Frameworks**: SwiftUI, Combine, FirebaseAuth, RealmSwift
- **Architecture**: MVVM + Repository

---
## 🚀 Future Improvements

- Polish UI with pixel-perfect layout and smooth animations.  
- Better memory management: use `[weak self]`, `deinit`, and `lazy` where needed.  
- Improve Dependency Injection, especially in `AuthViewModel`, for better testability.  
- Refactor routing:  
  - One route system for auth (login/signup)  
  - Another for authenticated user flows  
- Centralize string constants, image assets, and API routes for better maintainability.  
- Add unit tests for all ViewModels and services.  
- Add UI tests to cover login, search, and medication list flows.  
- Add and configure `.gitignore` properly:  
  - Exclude sensitive files like `GoogleService-Info.plist` and other environment-specific data.  


## 🧑‍💻 Dev Message
Due to limited time and tight scheduling, I wasn’t able to fully implement everything I initially planned for this project

