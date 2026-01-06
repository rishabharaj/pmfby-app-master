# 🎬 KrishiBandhu - Complete Installation & Getting Started Guide

**A comprehensive step-by-step guide to set up and run KrishiBandhu**

---

## Table of Contents
1. [System Requirements](#system-requirements)
2. [Pre-Installation Checklist](#pre-installation-checklist)
3. [Step-by-Step Installation](#step-by-step-installation)
4. [Firebase Setup](#firebase-setup)
5. [Running the App](#running-the-app)
6. [First Time Setup (In-App)](#first-time-setup-in-app)
7. [Testing the Features](#testing-the-features)
8. [Troubleshooting](#troubleshooting)

---

## 💻 System Requirements

### For macOS (Apple)
- macOS 12 (Monterey) or higher
- 4GB RAM minimum (8GB recommended)
- 2GB free disk space

### For Windows
- Windows 10 or higher
- 4GB RAM minimum (8GB recommended)
- 2GB free disk space
- PowerShell or Command Prompt

### For Linux
- Ubuntu 20.04 LTS or higher
- 4GB RAM minimum (8GB recommended)
- 2GB free disk space
- Git installed

### Device Requirements
- **Android Phone/Emulator**: Android 5.0+ (API 21+)
- **Internet Connection**: Required for Firebase features

---

## ✅ Pre-Installation Checklist

### 1. Download and Install Flutter

**macOS/Linux:**
```bash
# Download Flutter (stable)
git clone https://github.com/flutter/flutter.git -b stable ~/flutter

# Add Flutter to PATH
export PATH="$PATH:~/flutter/bin"
echo 'export PATH="$PATH:~/flutter/bin"' >> ~/.bashrc
source ~/.bashrc
```

**Windows:**
- Download from: https://flutter.dev/docs/get-started/install/windows
- Extract to `C:\flutter`
- Add `C:\flutter\bin` to PATH environment variable

**Verify Installation:**
```bash
flutter --version
# Output should show Flutter X.X.X, Dart X.X.X
```

### 2. Install Android Studio/Emulator

**macOS/Windows/Linux:**
1. Download from: https://developer.android.com/studio
2. Install Android Studio
3. Run Android Studio and install Android SDK
4. Create virtual device:
   ```
   Tools → Device Manager → Create Device
   ```

**Verify Android Setup:**
```bash
flutter doctor
```

### 3. Install VS Code (Recommended)

Download from: https://code.visualstudio.com/

Install extensions:
- Flutter (by Dart Code)
- Dart (by Dart Code)

### 4. Create GitHub Account (Optional but Recommended)

For cloning the repository and version control.

---

## 🔧 Step-by-Step Installation

### Step 1: Clone Repository

**Using Git:**
```bash
# Navigate to desired directory
cd ~/projects

# Clone the repository
git clone https://github.com/rishabharaj/pmfby-app-master.git

# Enter project directory
cd pmfby-app-master
```

**Or Download as ZIP:**
1. Visit: https://github.com/rishabharaj/pmfby-app-master
2. Click "Code" → "Download ZIP"
3. Extract to desired location
4. Open terminal in extracted folder

### Step 2: Install Flutter Dependencies

```bash
# Update Flutter
flutter upgrade

# Get project dependencies
flutter pub get

# Analyze project
flutter analyze
```

**Expected Output:**
```
Running "flutter pub get" in pmfby-app-master...
Running "flutter pub upgrade" in pmfby-app-master...
Resolving dependencies... (this may take several minutes)
Got dependencies in X seconds.
```

### Step 3: Verify Installation

```bash
# Full system check
flutter doctor

# Expected: ✓ Flutter (version X.X.X)
#          ✓ Android toolchain (Android SDK X.X.X)
#          ✓ Android Studio (version X.X.X)
```

---

## 🔥 Firebase Setup

### Option A: Quick Test (Without Firebase)

The app will run but Firebase features won't work:
```bash
flutter run
```

### Option B: Full Setup (With Firebase) - RECOMMENDED

#### 1. Create Firebase Project

1. Go to: https://console.firebase.google.com/
2. Click "Add project"
3. Enter project name: `KrishiBandhu`
4. Accept terms and click "Create project"
5. Wait for project creation (2-3 minutes)

#### 2. Create Android App in Firebase

1. In Firebase console, click "Add app"
2. Select "Android"
3. Fill in:
   - Package name: `com.example.krashi_bandhu`
   - App nickname: `KrishiBandhu`
   - SHA-1 certificate fingerprint (optional for now)

4. Click "Register app"

#### 3. Download google-services.json

1. Click "Download google-services.json"
2. Save the file
3. Place in: `android/app/` folder of your project
   ```
   pmfby-app-master/
   └── android/
       └── app/
           └── google-services.json  ← Place here
   ```

#### 4. Enable Firebase Services

**In Firebase Console:**

**Authentication:**
1. Go to "Authentication" section
2. Click "Get started"
3. Select "Phone" sign-in method
4. Enable it

**Firestore Database:**
1. Go to "Firestore Database"
2. Click "Create database"
3. Start in "Test mode" (for development)
4. Select location: "asia-southeast1" (closest to India)
5. Click "Create"

**Cloud Storage:**
1. Go to "Storage"
2. Click "Get started"
3. Select location: "asia-southeast1"
4. Click "Done"

#### 5. Update project/android/build.gradle

Find this section and update google-services version:
```gradle
buildscript {
    ext.kotlin_version = '1.8.0'
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:7.3.0'
        classpath 'com.google.gms:google-services:4.3.15'  // Update this
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}
```

---

## 🚀 Running the App

### Option 1: Run on Android Emulator

```bash
# Start emulator
flutter emulators --launch Pixel_5_API_33

# Run app
flutter run
```

### Option 2: Run on Physical Device

```bash
# Enable USB Debugging on your phone:
# Settings → Developer Options → USB Debugging (Enable)

# Connect phone via USB

# List connected devices
flutter devices

# Run app
flutter run -d <device-id>
```

### Option 3: Run from VS Code

1. Open VS Code
2. Open the project folder
3. Press `F5` or click "Run" → "Start Debugging"
4. Select "Flutter" emulator/device

---

## 👤 First Time Setup (In-App)

### Step 1: Login Screen

**Option A: Phone OTP Login**
```
1. Enter phone number: +919876543210
2. Tap "Send OTP"
3. Receive SMS with code
4. Enter OTP: 123456 (in test mode)
5. Tap "Verify"
```

**Option B: Email Login**
```
1. Enter email: farmer@demo.com
2. Enter password: demo123
3. Select "Login as Farmer"
4. Tap "Login"
```

### Step 2: Profile Setup

After login, complete profile:
```
Name: Anshika
Village: Jaitpur
District: Barabanki
State: Uttar Pradesh
Land Area: 5.0 एकड़

Select Crops:
☑ धान (Rice)
☑ गेहूं (Wheat)
☑ गन्ना (Sugarcane)

Tap "Save"
```

### Step 3: Grant Permissions

App will request:
```
☑ Camera - For capturing crop photos
☑ Location - For GPS geotagging
☑ Storage - For image access
☑ Notifications - For claim updates

Tap "Allow" for all
```

---

## 🧪 Testing the Features

### Test 1: Capture Crop Image

```
Dashboard → "Capture Crop Image" button
↓
Select "Camera" or "Gallery"
↓
Take/Select photo
↓
Check GPS location auto-detected
↓
Tap "Upload"
↓
✓ Image uploaded successfully!
```

### Test 2: File Insurance Claim

```
Dashboard → "File New Claim"
↓
Crop: धान (Rice)
Damage: बाढ़ (Flood)
Date: (Select date)
Loss: 60%
↓
Attach photo
Description: "Heavy rainfall caused..."
↓
Tap "Submit Claim"
↓
✓ Claim filed successfully!
```

### Test 3: View Insurance Schemes

```
Dashboard → "Insurance Schemes"
↓
Browse:
- PMFBY (Pradhan Mantri Fasal Bima Yojana)
- Weather-based Insurance
- Modified NAIS
↓
View premium rates, benefits, eligibility
```

### Test 4: Check Profile

```
Dashboard → Profile tab
↓
View all farm details
↓
Edit profile (if needed)
↓
View logout button
```

---

## 🐛 Troubleshooting

### Common Issues & Solutions

#### Issue 1: "Flutter command not found"
```bash
Solution:
1. Check Flutter installation
2. Add Flutter to PATH:
   export PATH="$PATH:$(pwd)/flutter/bin"
3. Verify: flutter --version
```

#### Issue 2: "Android SDK not found"
```bash
Solution:
1. Run: flutter doctor --android-licenses
2. Accept all licenses
3. Run: flutter doctor -v
4. Check Android Studio installation
```

#### Issue 3: "google-services.json not found"
```bash
Solution:
1. Download from Firebase console
2. Place in: android/app/google-services.json
3. Verify file path
4. Run: flutter clean && flutter run
```

#### Issue 4: "Build failed: Gradle error"
```bash
Solution:
1. Clear build:
   flutter clean
2. Get dependencies again:
   flutter pub get
3. Upgrade gradle:
   ./gradlew wrapper --gradle-version=X.X.X
4. Try again:
   flutter run
```

#### Issue 5: "GPS not working in emulator"
```bash
Solution:
1. Open Android Studio
2. Tools → Device Manager
3. Select your emulator
4. Click extended controls (⋮)
5. Go to Location tab
6. Enter test coordinates:
   Latitude: 26.7589
   Longitude: 80.9486
7. Click "Send"
```

#### Issue 6: "Firebase initialization failed"
```bash
Solution:
1. Verify google-services.json in android/app/
2. Check Firebase project ID matches
3. Ensure internet connectivity
4. Check if services enabled in Firebase console
5. Try: flutter run -v (verbose mode for more info)
```

#### Issue 7: "Camera not working"
```bash
Solution:
1. Check camera permission in AndroidManifest.xml
2. Grant camera permission on device
3. Check device has built-in camera
4. Verify image_picker package version
5. Try: flutter clean && flutter pub get
```

#### Issue 8: "Package dependencies conflict"
```bash
Solution:
1. Clear everything:
   flutter clean
   rm pubspec.lock
2. Get dependencies:
   flutter pub get
3. Analyze:
   flutter analyze
4. Run:
   flutter run
```

---

## 📝 Build for Release

### Create Release APK

```bash
# Build signed release APK
flutter build apk --release

# Output location:
# build/app/outputs/apk/release/app-release.apk

# Install on device
flutter install --release
```

### Create for Google Play Store

```bash
# Build App Bundle (recommended for Play Store)
flutter build appbundle --release

# Output location:
# build/app/outputs/bundle/release/app-release.aab
```

---

## 📚 Project Structure Overview

```
pmfby-app-master/
├── README.md                    ← Main documentation (START HERE!)
├── FEATURES_GUIDE.md            ← All features explained
├── DEVELOPER_GUIDE.md           ← Technical details
├── SETUP_GUIDE.md               ← Detailed setup
├── QUICK_REFERENCE.md           ← Quick commands
│
├── lib/
│   ├── main.dart                ← App entry point
│   └── src/
│       ├── features/            ← Feature modules
│       │   ├── auth/            ← Login/Auth
│       │   ├── dashboard/       ← Home screen
│       │   ├── crop_monitoring/ ← Camera & GPS
│       │   ├── claims/          ← Claim filing
│       │   └── schemes/         ← Insurance info
│       ├── models/              ← Data classes
│       ├── services/            ← Business logic
│       └── widgets/             ← UI components
│
├── android/                     ← Android native code
├── pubspec.yaml                 ← Dependencies
└── test/                        ← Tests
```

---

## 🎯 Next Steps After Installation

1. ✅ Complete login & profile setup
2. ✅ Test camera and GPS features
3. ✅ Practice filing a claim
4. ✅ Explore insurance schemes
5. ✅ Review the [FEATURES_GUIDE.md](FEATURES_GUIDE.md)
6. ✅ Check [DEVELOPER_GUIDE.md](DEVELOPER_GUIDE.md) if developing

---

## 📞 Support

- **GitHub Issues**: https://github.com/rishabharaj/pmfby-app-master/issues
- **Email**: support@krishibandhu.app
- **PMFBY Helpline**: 1800-180-1551

---

## 📖 Documentation Quick Links

| Document | For | Purpose |
|----------|-----|---------|
| [README.md](README.md) | Everyone | Project overview |
| [FEATURES_GUIDE.md](FEATURES_GUIDE.md) | End Users | How to use features |
| [DEVELOPER_GUIDE.md](DEVELOPER_GUIDE.md) | Developers | Technical implementation |
| [QUICK_REFERENCE.md](QUICK_REFERENCE.md) | Quick Help | Common commands |
| [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) | Deep Dive | Complete project details |

---

## ⚡ Quick Checklist

### Before First Run
- [ ] Flutter installed and working
- [ ] Android SDK/Emulator set up
- [ ] VS Code with Flutter extensions
- [ ] Git installed
- [ ] Repository cloned

### After Installation
- [ ] Dependencies installed (`flutter pub get`)
- [ ] `google-services.json` in `android/app/`
- [ ] Firebase services enabled
- [ ] Emulator/device connected
- [ ] App runs without errors

### First Session
- [ ] Login successfully
- [ ] Complete profile setup
- [ ] Take a test photo (camera test)
- [ ] Check GPS location
- [ ] File a test claim

---

**Last Updated**: December 2024
**Version**: 1.0.0+1
**Status**: ✅ Production Ready
