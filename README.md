# findoc_app

A findoc company assignment .

## Getting Started


- [Link1: Project Demo video Link watch it:](https://drive.google.com/file/d/16INOuFnELh_KcWw1EuzE1cumobkY1mmh/view?usp=drive_link)
- [Lin2: APK Link:](https://drive.google.com/file/d/1OVIK_LWXWSMLvlY8987p-pgDxNsXF-Ij/view?usp=drive_link)

# Flutter Bloc Login App

This is a simple Flutter application I built to demonstrate login functionality with form validation using Bloc, along with image fetching from an API. The app has two screens — a Login Screen and a Home Screen — and uses the [Picsum API](https://picsum.photos) to fetch and display images.

---

## 🔐 Login Screen

The login screen contains:
- An **email** input field
- A **password** input field
- A **submit** button

### ✅ Validation Rules:
- **Email:** Must be in a valid email format.
- **Password:** 
  - At least 8 characters
  - Includes one uppercase letter
  - Includes one lowercase letter
  - Includes one number
  - Includes one special character

When valid credentials are entered, the app navigates to the Home Screen.

---

## 🏠 Home Screen

Once logged in, the Home Screen displays a list of **10 random images** fetched from the [Picsum API](https://picsum.photos/v2/list).

### 📋 Each list item includes:
- The image (full screen width, maintaining aspect ratio)
- The author name (styled using **Montserrat Semi-Bold**)
- Image ID as description (styled with **Montserrat Regular**, dark grey, max 2 lines)

---

## ⚙️ Tech Used

- Flutter
- Dart
- Bloc (for state management)
- HTTP (for API calls)
- Custom fonts (Montserrat)

---





