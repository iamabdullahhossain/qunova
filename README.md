# Qunova
---

## 📋 Table of Contents

- [Setup Steps](#setup-steps)
- [Flutter Version](#flutter-version)
- [How to Run the App](#how-to-run-the-app)
- [Libraries Used & Why](#libraries-used--why)
- [Assumptions Made](#assumptions-made)
- [Project Structure](#project-structure)

---

## 🚀 Setup Steps

### Prerequisites
- **Flutter SDK**: Version ^3.10.8 or higher
- **Dart SDK**: Version 3.10.8 or higher
- **Git**: For version control
- **IDE**: Android Studio, VS Code, or IntelliJ IDEA (recommended)

### 1. Clone the Repository
```bash
git clone <repository-url>
cd qunova
```

### 2. Install Flutter Dependencies
```bash
- flutter clean
- flutter pub get
```

### 3. Generate Code (Important - Run Before First Build)
This project uses code generation for asset management and data models. Run the following command:
```bash
dart run build_runner build --delete-conflicting-outputs
```


### 4. iOS Specific Setup (macOS only)
```bash
cd ios
pod install
cd ..
```

---

## 📱 Flutter Version

- **Minimum SDK**: Dart 3.10.8
- **Target SDK**: Latest stable (tested with Flutter 3.19+)
- **Supported Platforms**: 
  - Android 5.0+ (API level 21+)
  - iOS 11.0+

Check your Flutter version:
```bash
flutter --version
```

---

## ▶️ How to Run the App

### 1. Development Build
```bash
flutter run
```

### 2. Release Build (Android)
```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

### 3. Release Build (iOS)
```bash
flutter build ios --release
```

---

## 📚 Libraries Used & Why

### State Management
- **`flutter_riverpod: ^2.6.1`** - Reactive state management with better type safety and testability compared to Provider. Used for managing contacts, categories, and app state.
- **`riverpod_annotation: ^2.6.1`** - Annotations for code generation with Riverpod
- **`riverpod_generator: ^2.6.5`** - Code generator for Riverpod providers

### Networking & HTTP
- **`dio: ^5.9.0`** - Powerful HTTP client with interceptors, request cancellation, and timeout management
- **`pretty_dio_logger: ^1.4.0`** - Enhanced logging for Dio requests/responses for debugging

### Local Storage
- **`hive_flutter: ^1.1.0`** - Fast, lightweight NoSQL database for local caching and offline support

### UI & Design
- **`flutter_screenutil: ^5.9.3`** - Responsive UI design for different screen sizes
- **`flutter_animate: ^4.5.2`** - Smooth animations and transitions
- **`gap: ^3.0.1`** - Simplified spacing between widgets
- **`page_transition: ^2.2.1`** - Custom page transition animations
- **`cupertino_icons: ^1.0.8`** - iOS-style icons

### Navigation
- **`go_router: ^16.2.4`** - Modern declarative routing with deep linking support

### File & Device Handling
- **`open_filex: ^4.7.0`** - Open files with default applications
- **`path_provider: ^2.1.5`** - Platform-specific file paths
- **`device_info_plus: ^12.2.0`** - Device information (model, OS version)
- **`permission_handler: ^12.0.1`** - Runtime permission management


### Development Tools
- **`flutter_gen_runner: ^5.12.0`** - Asset generation from YAML configuration
- **`build_runner: ^2.5.4`** - Code generation tool
- **`flutter_lints: ^6.0.0`** - Lint rules for code quality

### Utilities (DevOps)
- **`flutter_asset_gen: ^0.3.0`** - Asset generation helper
- **`device_preview: ^1.3.1`** - Preview app on different devices (development only)

---

## 🎯 Assumptions Made

### 1. **Category Image Placeholder**
- **Issue**: The API category response does not include image assets
- **Solution**: The first character of each category name is used as a visual identifier/avatar
- **Implementation**: When displaying categories, we extract the first character and use it in a circular avatar widget

### 2. **Categories as Relations**
- **Approach**: API categories are used as "Relations" in the contact form
- **Filtering**: The "All" and "Blocked" categories are excluded from the relations dropdown
- **Reason**: These are system categories for filtering contacts, not applicable as relationship types when adding new contacts

### 3. **Contact Filtering Logic**
- When category "All" is selected → Display all contacts across all categories
- When a specific category is selected → Filter and display only contacts belonging to that category
- Filtering is performed using `categoryId` parameter in API requests

### 4. **Search Functionality**
- Search works in conjunction with category filtering
- Users can search by contact **name** or **phone number**
- When both category filter and search text are active, results match **both** criteria
- The search bar appears inline with a close/clear button for easy reset

### 5. **No Results Handling**
- When a search query returns no results, display "No contacts found" message
- This applies whether filtering by category or searching

### 6. **Data Persistence**
- Hive is used for local caching of contacts and categories

---

## 📁 Project Structure

```
qunova/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── core/                     # Core utilities and constants
│   │   ├── constants/
│   │   ├── components/
│   │   ├── network/
│   │   └── utils/
│   │   └── config/
│   │   └── routes/
│   │   └── service/
│   │    
│   ├── feature/                  # Feature modules
│   │   ├── splash_screen/
│   │   ├── home_screen/
│   │   ├── contacts/
│   │   └── ...
│   ├── shared/                   # Shared widgets and components
│   └── gen/                      # Generated assets (from build_runner)
├── assets/                       # Static assets
│   ├── png/                      # PNG images
│   └── ...
├── android/                      # Android native code
├── ios/                          # iOS native code
├── pubspec.yaml                  # Project dependencies
└── analysis_options.yaml         # Lint rules
```

---

## 🔧 Important Commands

### Build Runner
```bash
# Generate code files
dart run build_runner build --delete-conflicting-outputs

# Watch for changes and auto-generate
dart run build_runner watch --delete-conflicting-outputs
```


---

