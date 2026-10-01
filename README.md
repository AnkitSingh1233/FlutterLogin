# Nexus Auth - Modern Flutter Login & Authentication

A modern, responsive, and visually stunning authentication experience created with **Flutter** (Material 3).

---

## ✨ Features

- 🎨 **Modern Aesthetics**: Frosted glassmorphism card, ambient glowing backdrop orbs, and vivid linear gradients.
- 🌓 **Dynamic Theme Switching**: Seamless toggle between Dark and Light themes.
- 🔄 **Sign In & Sign Up Modes**: Animated tab switcher with mode-specific form fields (Full Name & Confirm Password for registration).
- ⚡ **1-Click Demo Auto-Fill**: Fast testing button that instantly inputs valid credentials.
- 🛡️ **Comprehensive Form Validation**:
  - Email format validation with regex.
  - Password strength validation (minimum length check).
  - Password confirmation matching in registration mode.
- 👁️ **Interactive Password Reveal**: Smooth visibility toggles with eye icons.
- 🔑 **Forgot Password Flow**: Elegant modal bottom sheet with animated feedback.
- 🌐 **Social Authentication**: Custom-rendered vector buttons for **Google**, **Apple**, and **GitHub**.
- 📱 **Fully Responsive Layout**: Scales gracefully across Mobile (Android/iOS), Web, and Desktop.
- 🚀 **Dashboard Transition**: Smooth animated transition to a welcome dashboard post-login.
- 🚪 **Secure Logout Experience**:
  - Reusable bottom sheet confirmation (`LogoutSheet`) with user info card.
  - Active session invalidation with loading state.
  - Option to clear or preserve saved credentials.
  - Automatic purging of sensitive password fields on logout.
  - Feedback toast/snackbar confirming successful sign out.

---

## 📁 Project Architecture

```
d:/FlutterLogin/
├── lib/
│   ├── main.dart                       # App entry point & ThemeMode state management
│   ├── theme/
│   │   ├── app_colors.dart             # Color palette, gradients, and tokens
│   │   └── app_theme.dart              # Material 3 Light & Dark ThemeData
│   ├── widgets/
│   │   ├── custom_text_field.dart      # Reusable form field with prefix/suffix icons
│   │   ├── social_button.dart          # Vector-painted social auth buttons
│   │   ├── forgot_password_sheet.dart  # Modal bottom sheet for password recovery
│   │   └── logout_sheet.dart           # Interactive logout confirmation bottom sheet
│   └── screens/
│       ├── login_screen.dart           # The primary login & sign-up screen
│       └── home_screen.dart            # Post-login dashboard screen with theme toggle & logout
├── web/
│   ├── index.html                      # Flutter Web entry point
│   └── manifest.json                   # Web manifest configuration
├── preview/
│   └── index.html                      # Standalone interactive browser preview with logout modal
├── pubspec.yaml                        # Project metadata and dependencies
└── analysis_options.yaml               # Linter configuration
```

---

## 🚀 How to Run the Flutter App

### Prerequisites
1. Install [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.0.0 or higher).
2. Ensure `flutter` is added to your system `PATH`.

### Commands

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Run on an attached mobile device or emulator:**
   ```bash
   flutter run
   ```

3. **Run on Chrome (Web):**
   ```bash
   flutter run -d chrome
   ```

4. **Build APK (Android):**
   ```bash
   flutter build apk --release
   ```

5. **Build Web Bundle:**
   ```bash
   flutter build web --release
   ```

---

## 🌐 Instant Browser Preview

You can open and interact with the UI preview in your browser by opening:
`d:\FlutterLogin\preview\index.html`
