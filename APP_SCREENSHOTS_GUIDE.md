# 📸 KrishiBandhu App Walkthrough - Visual Guide

**Visual guide with all app screenshots showing the complete user journey**

---

## 🎬 Complete App Journey

### Screen 1: App Banner & Introduction

![KrishiBandhu App Banner](assets/images/avatars/forReadme/I0.png)

**What is shown:**
- KrishiBandhu app logo
- App tagline: "Revolutionizing Crop Insurance for Indian Farmers"
- Key features at a glance
- Download information

**For:**
- App store presentation
- Marketing materials
- Project introduction

---

### Screen 2: Authentication & Login

![Login Screen](assets/images/avatars/forReadme/I1.png)

**What is shown:**
- Login interface
- Two authentication options:
  - **Phone OTP Login**: Enter +91 phone number, receive SMS OTP
  - **Email/Password Login**: Enter email and password
- Bilingual support (Hindi/English toggle)
- Role selection (Farmer/Official)
- Beautiful green agricultural theme

**How to Use:**
```
Step 1: Enter phone number (+919876543210)
Step 2: Tap "Send OTP"
Step 3: Receive SMS with verification code
Step 4: Enter OTP
Step 5: Complete! Redirected to Dashboard

OR

Step 1: Enter email (farmer@demo.com)
Step 2: Enter password (demo123)
Step 3: Select "Farmer" role
Step 4: Tap "Login"
Step 5: Complete! Redirected to Dashboard
```

**Key Features:**
- ✅ Secure phone authentication via Firebase
- ✅ Credential-based login support
- ✅ Role-based access control
- ✅ Bilingual interface
- ✅ Demo account creation

**Demo Credentials:**
```
Phone: +919876543210
Email: farmer@demo.com
Password: demo123
```

---

### Screen 3: Dashboard & Home

![Dashboard Screen](assets/images/avatars/forReadme/I2.png)

**What is shown:**
- User profile greeting ("नमस्ते, Anshika")
- Weather information with current conditions
- Quick statistics cards:
  - Total land (5.0 एकड़)
  - Active crops (3)
  - Pending claims (2)
- Primary action button: "Capture Crop Image"
- Quick action grid:
  - File New Claim
  - View My Claims
  - Insurance Schemes
  - Help Center
- Recent activity feed with timestamps
- Bottom navigation tabs (Home, Claims, Schemes, Profile)

**How to Use:**
```
After Login:
1. You land on Dashboard
2. Review your farm statistics
3. Check weather conditions
4. Click any quick action button:
   - Capture Crop Image → Camera screen
   - File New Claim → Claim form
   - View Claims → Claims list
   - Insurance Schemes → Schemes browser
5. Use bottom tabs to navigate sections
```

**Key Statistics Displayed:**
- 🌾 Total Land: Shows total agricultural area in एकड़ (acres)
- 🌱 Active Crops: Number of crops being cultivated
- 📋 Pending Claims: Number of claims awaiting review
- 🌤️ Weather: Current weather and recommendations

**Quick Actions:**
| Button | Leads To | Purpose |
|--------|----------|---------|
| 📸 Capture Crop Image | Camera Screen | Upload geo-tagged photos |
| 📋 File New Claim | Claim Form | Submit insurance claim |
| 📄 My Claims | Claims List | View submitted claims |
| 🛡️ Schemes | Schemes Browser | Learn about insurance options |

---

### Screen 4: Image Capture with GPS Geotagging

![Image Capture Screen](assets/images/avatars/forReadme/I3.png)

**What is shown:**
- GPS location detection indicator
- Auto-detected location information:
  - Village: Jaitpur
  - District: Barabanki
  - State: Uttar Pradesh
  - Latitude: 26.7589°N
  - Longitude: 80.9486°E
  - Accuracy: ±5m
- Refresh location button (for manual updates)
- Capture options:
  - 📷 Take Photo (Opens camera)
  - 🖼️ Choose from Gallery
- Image preview area
- Upload status indicator
- Instructions in Hindi/English:
  - "फसल को स्पष्ट रूप से दिखाएं" (Show crop clearly)
  - "पूरे पौधे को शामिल करें" (Include entire plant)
  - "अच्छी रोशनी में फोटो लें" (Take photo in good light)

**How to Use:**
```
Step 1: Navigate to Dashboard
Step 2: Tap "Capture Crop Image"
Step 3: Wait for GPS to detect location
   - App shows: Detecting Location...
   - Auto-fills: Village, District, State, Coordinates
   - Shows accuracy radius
Step 4: Choose photo option:
   - Option A: Tap camera icon → Take photo
   - Option B: Tap gallery icon → Select existing photo
Step 5: Preview photo
Step 6: Tap "Confirm" → Image uploads
Step 7: Success message appears
Step 8: Redirected to Dashboard
```

**GPS Features:**
- 🗺️ **Automatic Detection**: GPS auto-enables and detects location
- 📍 **Location Name**: Reverse geocoding shows village/district
- 🎯 **Accuracy**: Shows ±5m accuracy indicator
- 🔄 **Manual Refresh**: Button to manually refresh if needed
- 💾 **Metadata**: Captures:
  - GPS coordinates (latitude, longitude)
  - Timestamp (date & time)
  - Location name (village, district, state)
  - Device information
  - Image quality metadata

**Upload Process:**
```
Photo Selection
    ↓
Image Compression (reduce file size)
    ↓
GPS Tagging (add coordinates)
    ↓
Firebase Upload (to Cloud Storage)
    ↓
Database Entry (save metadata to Firestore)
    ↓
AI Analysis Trigger (Cloud Function)
    ↓
Success Notification
```

**Instructions Provided:**
```
📸 फसल को स्पष्ट रूप से दिखाएं
   (Show your crop clearly)

🌾 पूरे पौधे को शामिल करें
   (Include the entire plant)

☀️ अच्छी रोशनी में फोटो लें
   (Take photo in good light)

⚠️ बेहतर परिणामों के लिए:
   (For better results:)
   - कोण बदलें (Change angle)
   - नीचे से ऊपर फोटो लें (Shoot from below)
   - पूरा पौधा दिखे (Full plant visible)
```

---

### Screen 5: Claim Filing & Insurance Information

![Claim Filing & Insurance Screen](assets/images/avatars/forReadme/I4.png)

**What is shown:**
- Two sections visible:
  - **Claim Form** (Left/Top):
    - Crop selection dropdown
    - Damage reason selection
    - Incident date picker
    - Loss percentage input
    - Description text area
    - Photo evidence attachment
    - Submit button
  - **Insurance Schemes** (Right/Bottom):
    - PMFBY scheme details
    - Premium rates
    - Coverage information
    - Eligibility criteria
    - Contact helpline

**How to Use - Filing a Claim:**
```
Step 1: Dashboard → "File New Claim"
Step 2: Fill claim form:
   ├─ Crop Name: Select from dropdown
   │  (धान, गेहूं, गन्ना, मक्का, दाल, आलू, मिर्च, प्याज)
   │
   ├─ Damage Reason: Select damage type
   │  (बाढ़, सूखा, कीट, रोग, ओलावृष्टि, तूफान, अन्य)
   │
   ├─ Incident Date: Pick date from calendar
   │  (Must be within last 90 days)
   │
   ├─ Loss Percentage: Enter 0-100%
   │  (Estimated crop damage)
   │
   ├─ Description: Type in Hindi/English
   │  (Minimum 20 characters)
   │  (Example: "Heavy rainfall caused waterlogging...")
   │
   └─ Photo Evidence: Attach captured images
      (Tap to link previously uploaded photos)

Step 3: Review all fields
Step 4: Tap "Submit Claim"
Step 5: Success confirmation appears
Step 6: Claim number provided (e.g., CLM-2024-001)
Step 7: Redirected to Claims list
```

**Claim Form Fields Explained:**

### 1. **Crop Name** (Dropdown)
```
Options:
├─ 🌾 धान (Rice)
├─ 🌾 गेहूं (Wheat)
├─ 🍂 गन्ना (Sugarcane)
├─ 🌽 मक्का (Corn)
├─ 🫘 दाल (Pulse/Lentil)
├─ 🥔 आलू (Potato)
├─ 🌶️ मिर्च (Chilli)
└─ 🧅 प्याज (Onion)
```

### 2. **Damage Reason** (Selection Menu)
```
Damage Type          Impact          Premium Impact
├─ बाढ़ (Flood)      ████░ 80%       +5% to base rate
├─ सूखा (Drought)    ████░ 75%       +3% to base rate
├─ कीट (Pest)       ███░░ 60%       +2% to base rate
├─ रोग (Disease)    ███░░ 60%       +2% to base rate
├─ ओलावृष्टि (Hail)  ████░ 85%       +4% to base rate
├─ तूफान (Storm)    ████░ 80%       +5% to base rate
├─ फ्रॉस्ट (Frost)   ██░░░ 40%       +1% to base rate
└─ अन्य (Other)     ?????            Custom rate
```

### 3. **Incident Date**
- Calendar picker opens
- Maximum 90 days in past allowed
- Cannot select future dates
- Shows date range validity

### 4. **Estimated Loss %**
- Number field: 0-100
- Slider alternative available
- Validation: Must be realistic
- Examples:
  - 25% = Quarter damage
  - 50% = Half damage
  - 75% = Severe damage
  - 100% = Complete loss

### 5. **Description**
- Text area (minimum 20 characters)
- Bilingual support (mix Hindi & English)
- Examples:
  - "Heavy rainfall for 3 consecutive days caused flooding in the field"
  - "Pest attack visible on 60% of plants, brown spots on leaves"
  - "Severe drought, plants wilted, unable to recover"

### 6. **Photo Evidence**
- Links to previously captured images
- Multiple photos supported
- Shows photo thumbnail
- Can attach/remove photos

---

## Insurance Schemes Explained

### 🛡️ PMFBY (Pradhan Mantri Fasal Bima Yojana)

**Premium Rates:**
```
Kharif (Monsoon): 2% of crop value
Rabi (Winter):    1.5% of crop value
Example:
├─ Crop value: ₹1,00,000
├─ Kharif premium: ₹2,000 (paid by farmer)
├─ Government subsidy: ₹38,000 (95%)
└─ Total coverage: ₹1,00,000
```

**Coverage:**
```
Who Gets Covered:
├─ All farmers (small, marginal, large)
├─ Landless laborers
└─ Tenant farmers

What's Covered:
├─ Yield losses (> 20%)
├─ Named perils (named damage types)
├─ Post-harvest losses (14 days)
└─ Prevented sowing losses

Benefits:
├─ Fast claim settlement (7-30 days)
├─ No co-insurance burden
├─ Weather index support
└─ Crop loans linked
```

**Eligibility:**
```
✓ Indian farmers (any nationality)
✓ Cultivators (owners/tenants/sharecroppers)
✓ All crops (notified)
✓ All geographic areas
✓ No upper limit on farm size
✓ No age limit
```

### 🌤️ Weather-Based Crop Insurance

**Premium:** 3-5% of crop value

**Triggers:**
```
├─ Excessive Rainfall
├─ Frost/Cold Wave
├─ Strong Winds/Cyclone
├─ Hailstorm
└─ Drought
```

**Advantage:** Automatic claim without crop survey

### 📊 Modified NAIS

**Premium:** 1.5-3.5% of crop value
**Coverage:** Up to 100% crop value

---

## 🔄 Complete User Journey Flowchart

```
Start
  ↓
[I0] → App Introduction
  ↓
[I1] → User Login/Registration
  ├─ Phone OTP OR
  └─ Email/Password
  ↓
[I2] → Dashboard (Home)
  ├─ View farm statistics
  ├─ Check weather
  └─ Choose action
  ↓
  ├─→ [I3] Capture Crop Image ←─┐
  │                              │
  ├─→ [I4] File Claim ←──────────┤
  │   (Uses photo from [I3])     │
  │                              │
  ├─→ [I4] Browse Insurance ←────┤
  │                              │
  └─→ Continue from [I2] ────────┘
```

---

## 📱 Navigation Map

```
App Structure:

KrishiBandhu App
│
├─ Authentication
│  ├─ [I1] Login Screen
│  ├─ Registration Screen
│  └─ OTP Verification
│
├─ Main App
│  │
│  ├─ [I2] Dashboard (Home Tab)
│  │   ├─ Farm statistics
│  │   ├─ Weather info
│  │   └─ Quick actions
│  │
│  ├─ [I3] Crop Monitoring
│  │   ├─ Camera screen
│  │   ├─ GPS geotagging
│  │   ├─ Image upload
│  │   └─ Upload history
│  │
│  ├─ [I4] Claims Section
│  │   ├─ File new claim
│  │   ├─ View claims list
│  │   ├─ Claim details
│  │   └─ Claim status
│  │
│  ├─ [I4] Insurance Schemes
│  │   ├─ PMFBY details
│  │   ├─ Other schemes
│  │   ├─ Premium calculator
│  │   └─ Eligibility checker
│  │
│  └─ Profile
│      ├─ Farm information
│      ├─ Personal details
│      ├─ Settings
│      └─ Logout
│
└─ Support
   ├─ Help center
   ├─ FAQ
   ├─ Contact us
   └─ Send feedback
```

---

## 🎯 Key Takeaways

### What Each Screenshot Shows

| Screen | Component | Purpose | Key Info |
|--------|-----------|---------|----------|
| I0 | App Banner | Introduction | App branding |
| I1 | Login | Authentication | Phone OTP, Email login |
| I2 | Dashboard | Main hub | Stats, weather, actions |
| I3 | Image Capture | GPS tagging | Location, camera, upload |
| I4 | Claims & Schemes | Form & Info | Claim filing, insurance details |

### User Actions Flow

```
I0 (Start)
  ↓
I1 (Login)
  ↓
I2 (Dashboard)
  ↓
I3 (Capture Image) ← Links to → I4 (Claims Form)
  ↓
I4 (File Claim using photo from I3)
  ↓
Submit & Track in I2 Dashboard
```

---

## 💡 Feature Highlights

### 📸 Image Capture (Screen I3)
- ✅ Automatic GPS detection
- ✅ Reverse geocoding (location name)
- ✅ Timestamp capture
- ✅ Image compression
- ✅ Firebase upload
- ✅ AI analysis trigger

### 📋 Claim Filing (Screen I4)
- ✅ Multi-field form
- ✅ Validation checks
- ✅ Photo attachment
- ✅ Bilingual support
- ✅ Firestore storage
- ✅ Status tracking

### 🛡️ Insurance Info (Screen I4)
- ✅ Scheme details
- ✅ Premium calculator
- ✅ Eligibility guide
- ✅ Contact information
- ✅ Application process
- ✅ Claim process

### 📊 Dashboard (Screen I2)
- ✅ Real-time stats
- ✅ Weather integration
- ✅ Quick actions
- ✅ Activity feed
- ✅ Navigation tabs
- ✅ Profile access

### 🔐 Authentication (Screen I1)
- ✅ Phone OTP login
- ✅ Email/password login
- ✅ Role-based access
- ✅ Bilingual interface
- ✅ Firebase integration
- ✅ Auto-logout on app delete

---

## 📖 Related Documentation

| For More Info | See Document |
|---------------|--------------|
| Full feature list | [FEATURES_GUIDE.md](FEATURES_GUIDE.md) |
| Setup instructions | [INSTALLATION_GUIDE.md](INSTALLATION_GUIDE.md) |
| Technical details | [DEVELOPER_GUIDE.md](DEVELOPER_GUIDE.md) |
| Troubleshooting | [ERROR_RESOLUTION.md](ERROR_RESOLUTION.md) |
| Complete project | [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) |

---

**Last Updated**: December 2024
**Version**: 1.0.0+1

🌾 **Made with ❤️ for Indian Farmers | KrishiBandhu**
