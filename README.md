# 🛍️ E-Shop – Flutter Shopping App

**E-Shop** is a full-featured Flutter e-commerce application developed to explore and master **state management, authentication, API integration, and local data persistence** in Flutter.

This project was an exciting and challenging journey that helped me combine multiple Flutter concepts into one real-world application — from Firebase authentication to offline data storage with Hive and state handling using Provider.

---

## 🚀 Project Overview

The **E-Shop App** allows users to browse products, manage their cart, and place orders — all while keeping their data synced across app sessions using local storage.

Through this project, I learned to:

* Structure a scalable Flutter project with **Provider state management**
* Manage user sessions with **Firebase Authentication**
* Save user preferences and cart data locally using **Hive** and **SharedPreferences**
* Handle REST APIs with proper **error handling and async data fetching**

It was a complete hands-on experience to understand **data flow** in Flutter apps — from user input to persistent storage and reactive UI updates.

---

## 🧠 Learning Journey

### 🟢 Authentication (FirebaseAuth)

* Implemented **Email & Password Authentication**
* Added auto-login, logout, and splash logic
* Displayed Firebase error messages directly on UI

### 🟡 State Management (Provider)

* Managed products, cart, and orders globally
* Prevented unnecessary widget rebuilds
* Separated business logic from UI for cleaner architecture

### 🔵 Local Data Storage (Hive + SharedPreferences)

* Stored favorites, cart, and theme settings locally
* Restored user preferences automatically after restart
* Improved performance with Hive caching

### 🔴 API Integration

* Fetched and stored product data using Firebase Realtime Database
* Added loading spinners and proper error messages
* Created custom HttpException for cleaner error handling

---

## ⚙️ Core Features

### 🛒 Product Management

* Fetch products from Firebase
* Add, edit, and delete products
* Detailed product screen with image, price, and description

### ❤️ Favorites

* Mark/unmark items as favorites
* Persist favorites using Hive

### 🧾 Cart & Orders

* Add/remove items from the cart
* Auto-calculate total price
* Place an order and view past orders

### 🌗 Themes & Preferences

* Light/Dark mode toggle
* Saved locally using SharedPreferences

### 🔐 Authentication

* Firebase Login & Signup
* Error handling with friendly messages
* Persistent login

---

## 🛠️ Technologies & Packages Used

| Package                | Description                   |
| ---------------------- | ----------------------------- |
| provider               | State management              |
| firebase_auth          | Firebase authentication       |
| firebase_database      | Store/fetch products & orders |
| http                   | REST API calls                |
| hive / hive_flutter    | Local offline data storage    |
| shared_preferences     | Store preferences             |
| cached_network_image   | Faster image loading          |
| flutter_spinkit        | Loading animations            |
| intl                   | Date formatting               |
| flutter_launcher_icons | App icon setup                |

---

## 🧩 Project Structure (Simplified)

```
lib/
├── main.dart
├── provider/
├── models/
├── screens/
└── widgets/
```

---

## 📸 App Screenshots (9 Pictures)

| Screen 1                                                     | Screen 2                                                     | Screen 3                                                     |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](https://github.com/MuhmmadUmair/E-Shop/blob/075a63c34766f542fbf0cfa72b0c4b1566e814b8/assets/images/Screenshot%201.png) | ![](https://github.com/MuhmmadUmair/E-Shop/blob/075a63c34766f542fbf0cfa72b0c4b1566e814b8/assets/images/Screenshot%202.png) | ![](https://github.com/MuhmmadUmair/E-Shop/blob/075a63c34766f542fbf0cfa72b0c4b1566e814b8/assets/images/Screenshot%203.png) |

| Screen 4                                                     | Screen 5                                                     | Screen 6                                                     |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](https://github.com/MuhmmadUmair/E-Shop/blob/075a63c34766f542fbf0cfa72b0c4b1566e814b8/assets/images/Screenshot%204.png) | ![](https://github.com/MuhmmadUmair/E-Shop/blob/075a63c34766f542fbf0cfa72b0c4b1566e814b8/assets/images/Screenshot%205.png) | ![](https://github.com/MuhmmadUmair/E-Shop/blob/075a63c34766f542fbf0cfa72b0c4b1566e814b8/assets/images/Screenshot%206.png) |

| Screen 7                                                     | Screen 8                                                     | Screen 9                                                     |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](https://github.com/MuhmmadUmair/E-Shop/blob/075a63c34766f542fbf0cfa72b0c4b1566e814b8/assets/images/Screenshot%207.png) | ![](https://github.com/MuhmmadUmair/E-Shop/blob/075a63c34766f542fbf0cfa72b0c4b1566e814b8/assets/images/Screenshot%208.png) | ![](https://github.com/MuhmmadUmair/E-Shop/blob/075a63c34766f542fbf0cfa72b0c4b1566e814b8/assets/images/Screenshot%209.png) |

---

## 🧰 How to Run the Project

1. Clone the repo

   ```
   git clone https://github.com/yourusername/E-Shop-App.git
   ```

2. Install dependencies

   ```
   flutter pub get
   ```

3. Add Firebase config files

   * `google-services.json` (Android)
   * `GoogleService-Info.plist` (iOS)

4. Run the app

   ```
   flutter run
   ```

---

## 💡 What I Learned

This project taught me:

* How real-world apps structure data & state
* Scaling Provider for global state
* Handling Firebase authentication securely
* Implementing clean and maintainable architecture
* Improving performance using offline-first storage

---

## 🌐 Connect with Me

🔗 **LinkedIn:** [https://www.linkedin.com/in/muhmmadumair3233](https://www.linkedin.com/in/muhmmadumair3233)
---

## ⭐ Final Thoughts

**E-Shop** was not just a coding exercise — it was a complete, practical journey into **real-world Flutter development**.
From authentication and API integration to Provider and Hive, every part of this project helped me grow as a Flutter developer.
