# Intermediate Login & Registration (Flutter)

A modern and intermediate level Flutter app demonstrating a clean flow (Splash screen → Welcome page → Login/Sign Up forms → Home page) with persistent light/dark mode and locally stored user info recommended for local storages only. The UI uses Poppins typography, gradient backgrounds (no more heavy images from the first drafts), and a refreshed Home experience.

## Main Features Implemented

1. **Onboarding Flow:** Splash screen with animation → Welcome → Login or Sign Up → Home.
2. **Local Authentication State:** Stores basic user info (e.g., `fullName`, `email`) using the SharedPreferences package.
3. **Theming:** Material 3 with `ColorScheme.fromSeed`, Poppins via `google_fonts`, and a theme toggle with persisted `ThemeMode`. Improved UI design. 
4. **Modern Backgrounds:** Reusable gradient backgrounds with soft shapes. For Modularity and efficiency. 
5. **Home Page Features:**
	- **Balance hide/reveal:** Blur animation to obscure or show the balance.
	- **Gradient account card:** Shimmers on the first load for creative interaction.
	- **Profile initial avatar:** Displays the first letter of the saved name. Cannot be edited. 

## List of Widgets Used

- **App/Scaffold:** `MaterialApp`, `Scaffold`, `SafeArea`.
- **Layout:** `Stack`, `Positioned`, `Column`, `Row`, `Expanded`, `SingleChildScrollView`, `Padding`, `Align`, `Container`.
- **Styling:** `BoxDecoration`, `LinearGradient`, `CircleAvatar`, `IconButton`, `ElevatedButton`, `OutlinedButton`.
- **Text/Images:** `Text`, `Image.asset`, `Icon`.
- **Animations:** `AnimationController`, `FadeTransition`, `ScaleTransition`, `AnimatedBuilder`, `ClipRect`, `ImageFiltered` (for blur).
- **Async/State:** `FutureBuilder`, `AnimatedBuilder` (for theme), `SharedPreferences` (persistence).

## Steps to Run the Project

Option A — Terminal (Flutter CLI):

```powershell
cd "directory of the flutter project folder"
flutter pub get
flutter run
```

Option B — Android Studio (Run button):
- Open the project folder in Android Studio.
- Let it finish syncing and fetching packages.
- Select an emulator or connected Android device.
- Press the Run ▶ button.

Notes:
- If you previously installed the app on the device, uninstall first for a completely clean state (clears saved `SharedPreferences`).
- This project uses local storage only.
