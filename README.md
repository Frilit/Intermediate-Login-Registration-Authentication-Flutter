# Intermediate Login & Registration (Flutter)

A modern and intermediate level Flutter app demonstrating a clean flow (Splash screen → Welcome page → Login/Sign Up forms → Home page) with persistent light/dark mode and locally stored user info recommended for local storages only. The UI uses Poppins typography, gradient backgrounds (no more heavy images from the first drafts), and a refreshed Home experience.

## Main Features Implemented

1. **Onboarding Flow:** Splash screen with animation → Welcome → Login or Sign Up → Home.
2. **Local Authentication State:** Stores basic user info (e.g., `fullName`, `email`) using the SharedPreferences package.
3. **Theming:** Material 3 with `ColorScheme.fromSeed`, Poppins via `google_fonts`, and a theme toggle with persisted `ThemeMode`. All made to improve UI design. 
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

  ## Reflection

- Fritzch Santos

As someone responsible for researching and applying the knowledge gained in button navigation, screen transitions, and form validations, the hardest challenge I faced was applying the shared preference package as I needed to understand its new keywords and asynchronous initialization. Importing the shared preference package was my first taste of handling new functions made specifically for flutter, while other functions I made for this application had their logic inspired from my past experiences. I read through the documentation provided for the shared preference package to deepen my understanding of its asynchronous behavior so that I apply it reliably in our app. With new knowledge gained, I updated our initialization to load preferences before rendering, ensuring consistent state across launches. Understanding this new package gave me more knowledge on how I can handle account storage without losing them when the application turns off. 

Another challenge I faced was organizing the UI design elements. As someone weak when it comes to front end design, I had a hard time visualizing how I would make the application look pleasing to see instead of it being a jumbled mess of visual clutter. To fix this, I asked help from all my groupmates of what could be improved and applied their suggestions during the development of the application. 

- Andrei Gumiran

The challenge I have faced for creating the Flutter app is how to design the app itself. The app we were assigned is Login Validation, therefore there are a lot of buttons to consider in creating the Initial phase of UI. Also with this app, it needs multiple pages (e.g Welcome Page, Login Page etc.)

It is tricky to solve this problem because you need to consider the design/theme and button placements. The solution I used is to actually try and imitate an existing app with a clean UI. I considered every button placement of the app and applied it on our own app which made the app look comforting and efficient to use.

