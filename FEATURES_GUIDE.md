# 🎯 KrishiBandhu - Features Guide

Comprehensive guide to all features and how to use them.

---

## Table of Contents
1. [Authentication](#authentication)
2. [Dashboard](#dashboard)
3. [Crop Image Capture](#crop-image-capture)
4. [Insurance Claims](#insurance-claims)
5. [Insurance Schemes](#insurance-schemes)
6. [Profile Management](#profile-management)
7. [Weather Integration](#weather-integration)
8. [Offline Mode](#offline-mode)

---

## 🔐 Authentication

### Phone OTP Login
**Best For**: First-time farmers without email

#### Flow:
```
Enter Phone (+91) → Send OTP → Verify → Dashboard
```

#### Demo Account:
- Phone: +919876543210
- OTP: Auto-sent (test mode: 123456)

#### Features:
- ✅ SMS delivery confirmation
- ✅ Auto-read OTP
- ✅ Resend timer (60s)
- ✅ Multiple attempts

### Email/Password Authentication
**Best For**: Officials and repeat users

#### Demo Account:
```
Email: farmer@demo.com
Password: demo123
Role: Farmer
```

#### Features:
- ✅ Password strength validator
- ✅ Forgot password recovery
- ✅ Show/hide password toggle
- ✅ Remember me option

### Role-Based Access
- **Farmer Role**: Can file claims, upload images
- **Official Role**: Can verify claims, manage database

---

## 🏠 Dashboard

### Components

#### Header Section
- **Greeting**: "नमस्ते, [Name]" in user's preferred language
- **Weather Widget**: Current temperature, condition, icon
- **Location**: Auto-detected via GPS

#### Statistics Cards
```
┌─────────────────────────┐
│ Total Land: 5.0 एकड़   │  ← Linked to profile
├─────────────────────────┤
│ Active Crops: 3         │  ← धान, गेहूं, गन्ना
├─────────────────────────┤
│ Pending Claims: 2       │  ← Real-time from Firestore
└─────────────────────────┘
```

#### Quick Action Buttons
1. **Capture Crop Image** (Primary)
   - Direct to camera screen
   - Auto GPS detection
   - Photo upload

2. **File New Claim**
   - Opens claim form
   - Pre-fills farmer data

3. **View Claims**
   - Lists all submitted claims
   - Filter by status
   - View details

4. **Insurance Info**
   - Browse schemes
   - Premium calculator
   - Eligibility check

#### Recent Activity Feed
```
📸 Image uploaded: 2 hours ago
  └─ Location: Jaitpur, Barabanki
  └─ Status: AI Analysis in progress

✅ Claim Approved: Yesterday
  └─ Crop: धान (Rice)
  └─ Amount: ₹50,000

📝 New Scheme Available: PMFBY 2024-25
```

#### Bottom Navigation
- 🏠 Home (Dashboard)
- 📋 Claims
- 🛡️ Schemes
- 👤 Profile

---

## 📸 Crop Image Capture

### Location Detection

#### Automatic GPS
```
Status: Detecting Location...
↓
Latitude: 26.7589°N
Longitude: 80.9486°E
↓
Village: Jaitpur
District: Barabanki
State: Uttar Pradesh
Accuracy: ±5m
```

#### Refresh Location
- Button to manually refresh GPS
- Useful when indoors or blocked signal
- Shows accuracy indicator

### Image Capture Options

#### Option 1: Take Photo (Camera)
```
Steps:
1. Click "Camera" button
2. Point at crop (full plant visibility)
3. Click shutter → Preview
4. Accept or Retake
```

#### Option 2: Choose from Gallery
```
Steps:
1. Click "Gallery" button
2. Select existing image
3. Preview and confirm
```

### Upload Process

#### Metadata Included:
- 📷 Image file (compressed)
- 🗺️ GPS coordinates
- ⏰ Timestamp
- 📍 Location name
- 📝 Device information

#### Upload Status:
```
Uploading: ▓▓▓▓░░░░░░ 40%

OR

✅ Upload Complete!
Image saved to Firebase Storage
Awaiting AI Analysis...
```

#### AI Analysis Trigger:
Cloud Function automatically:
1. Analyzes image quality
2. Identifies crop type
3. Detects health/damage
4. Updates Firestore
5. Notifies farmer

---

## 📋 Insurance Claims

### Claim Form Fields

#### 1. **Crop Name**
- Dropdown with 8 options:
  - 🌾 धान (Rice)
  - 🌾 गेहूं (Wheat)
  - 🍂 गन्ना (Sugarcane)
  - 🌽 मक्का (Corn)
  - 🫘 दाल (Pulse)
  - 🥔 आलू (Potato)
  - 🌶️ मिर्च (Chilli)
  - 🧅 प्याज (Onion)

#### 2. **Damage Reason**
Selection menu:
```
Damage Type          Impact      Premium Increase
├─ बाढ़ (Flood)      ████░      +5%
├─ सूखा (Drought)    ████░      +3%
├─ कीट (Pest)       ███░░      +2%
├─ रोग (Disease)    ███░░      +2%
├─ ओलावृष्टि (Hail)  ████░      +4%
├─ तूफान (Storm)    ████░      +5%
├─ फ्रॉस्ट (Frost)   ██░░░      +1%
└─ अन्य (Other)     ░░░░░      Custom
```

#### 3. **Incident Date**
- Date picker
- Maximum: 90 days in past
- Validation: Cannot be in future

#### 4. **Estimated Loss %**
- Number field (0-100)
- Slider option available
- Real-time percentage display

#### 5. **Description**
- Free text field (minimum 20 chars)
- Hindi & English mix supported
- Examples provided

#### 6. **Photo Evidence**
- Link to uploaded crop images
- Multiple photo support
- Gallery preview

### Submission Process

```
Form Validation
    ↓
    ✓ All required fields filled?
    ✓ Valid date range?
    ✓ Loss % between 0-100?
    ✓ Photo attached?
    ↓
Create Firestore Document
    ↓
    {
      farmerId: "uid",
      cropName: "धान",
      status: "SUBMITTED",
      submittedAt: now,
      ...
    }
    ↓
Show Success Message
    ↓
Redirect to Claims List
```

### Claim Status Tracking

```
SUBMITTED (Orange)
    ↓
UNDER_REVIEW (Blue)
    ↓
Approved ✅ / Rejected ❌
```

#### Claim Details View
```
Claim ID: CLM-2024-001
Crop: धान
Damage: बाढ़
Status: UNDER_REVIEW

Timeline:
• Submitted: Dec 15, 2024
• Under Review: Dec 16, 2024
• [Pending...]

Expected Resolution: Dec 25, 2024
```

---

## 🛡️ Insurance Schemes

### Scheme Information Cards

#### 1. PMFBY (Pradhan Mantri Fasal Bima Yojana)

```
Premium Rate:
├─ Kharif (Monsoon): 2%
└─ Rabi (Winter): 1.5%

Coverage:
├─ Minimum: ₹50,000
└─ Maximum: ₹2,00,000

Benefits:
✓ Yield loss coverage
✓ Named peril coverage
✓ Prevented sowing
✓ Fast claim settlement

Eligibility:
• Indian farmers (all)
• Sharecroppers allowed
• No age limit
• No land size limit

Required Documents:
• Aadhar/ID proof
• Land ownership proof
• Bank account details
• Crop sowing proof
```

#### 2. Weather Based Crop Insurance

```
Premium Rate: 3-5%

Triggers:
├─ Excessive rainfall
├─ Frost/Cold wave
├─ Strong winds
├─ Hailstorm
└─ Drought

Coverage:
✓ Automatic claim without survey
✓ Fast settlement (7-14 days)
```

#### 3. Modified NAIS

```
Premium Rate: 1.5-3.5%
Coverage: Up to 100% crop value

Advantages:
✓ Lowest premium
✓ Simple process
✓ Flexible coverage
```

### Premium Calculator

```
Select Crop: गेहूं (Wheat)
Enter Land Area: 2.5 एकड़
Select Season: Rabi (Winter)
Select Scheme: PMFBY

↓

Estimated Yield: 50 quintals
Crop Value: ₹1,50,000
Premium Rate: 1.5%

Premium Amount: ₹2,250
Your Share: ₹2,250
Government Subsidy: ₹28,750 (95%)
Total Coverage: ₹1,50,000

Estimated Annual Saving: ₹28,750
```

---

## 👤 Profile Management

### Farmer Profile View

```
┌─────────────────────────┐
│    Profile Photo        │
│   (Optional Avatar)     │
└─────────────────────────┘

Personal Information:
├─ Name: Anshika
├─ Phone: +919876543210
├─ Email: anshika@example.com
└─ Language: हिंदी

Farm Details:
├─ Village: Jaitpur
├─ District: Barabanki
├─ State: Uttar Pradesh
├─ Total Land: 5.0 एकड़
└─ Crops: धान, गेहूं, गन्ना

Document Details:
├─ Aadhar: XXXX-XXXX-1234
├─ Bank A/C: XXXXXXX1234
└─ IFSC Code: SBIN0002345
```

### Edit Profile
- Update personal details
- Add/change profile photo
- Modify farm information
- Update bank details
- Change language preference

### Security Settings
```
Security
├─ Change Password
├─ Two-Factor Authentication (optional)
├─ Connected Devices
└─ Login History
```

### Preferences
```
Notifications
├─ Push Notifications: ✓ ON
├─ Email Updates: ✓ ON
├─ SMS Alerts: ✓ ON
└─ Notification Time: 09:00 AM

Language
├─ App Language: हिंदी
├─ Document Language: हिंदी
└─ Support Language: हिंदी

Data
├─ Download my data
├─ Delete account
└─ Export records
```

---

## 🌤️ Weather Integration

### Daily Weather Widget

```
Today's Weather
┌─────────────────────┐
│  ☀️ 28°C            │
│  Sunny, 5% Rainfall │
│  Wind: 10 km/h      │
│  Humidity: 65%      │
└─────────────────────┘

Next 7 Days Forecast:
[Chart showing rain/temp]

Weather Alerts:
⚠️ Heavy rainfall expected tomorrow
✓ No hail warnings
✓ Optimal sowing conditions today
```

### Weather Impact on Crops

```
Current Conditions: Favorable ✓
└─ Temperature: Optimal range
└─ Moisture: Adequate
└─ Wind: Low risk

Next 24 Hours: Caution ⚠️
└─ Light rainfall expected
└─ Monitor for waterlogging

Recommendations:
• Don't apply pesticides (rain expected)
• Water plants adequately
• Check drainage system
```

---

## 📱 Offline Mode

### Works Offline:
- ✅ Browse schemes (cached)
- ✅ View past claims
- ✅ Read profile info
- ✅ Access help documents

### Requires Internet:
- ❌ Upload new images
- ❌ File new claims
- ❌ Real-time updates
- ❌ Verify OTP

### Sync on Reconnect:
```
Internet Connection Restored ✓

Syncing:
├─ Uploading pending images...
├─ Submitting draft claims...
├─ Fetching latest claim status...
└─ Downloading scheme updates...

Sync Complete ✅
```

---

## 🔔 Notifications

### Notification Types

#### Claim Updates
```
✉️ Claim Approved!
Your claim CLM-2024-001 has been approved.
Amount: ₹50,000 will be credited in 5 days.
Tap to view details →
```

#### Image Analysis
```
✉️ Image Analysis Complete
Your crop image has been analyzed.
Crop: Rice | Health: Good ✓
Tap to view full report →
```

#### Weather Alerts
```
⚠️ Heavy Rainfall Alert
Rainfall of 50mm expected in next 24 hours.
Check drainage and waterlogging risk.
Tap for recommendations →
```

#### System Updates
```
🔄 App Update Available
New features and bug fixes.
Tap to update →
```

---

## 📊 Data & Privacy

### Data Collected
- Personal: Name, phone, email, Aadhar
- Farm: Location, crops, land area
- Images: GPS location, timestamp, image data
- Claims: Crop info, damage details, amounts

### Data Usage
- ✓ Process insurance claims
- ✓ Analyze crop health via AI
- ✓ Improve recommendations
- ✗ Never shared with third parties
- ✗ No commercial use

### Privacy Controls
```
Privacy Settings
├─ Location Data: Allow / Deny
├─ Analytics: Allow / Deny
├─ Promotional: Allow / Deny
└─ Image Deletion: Auto delete after 30 days
```

---

## ⚙️ Settings

### General
```
├─ Language: हिंदी / English
├─ Theme: Light / Dark / Auto
├─ Font Size: Normal / Large / XLarge
├─ Auto-sync: ON / OFF
└─ Offline Mode: Enabled
```

### Notifications
```
├─ Claim Updates: ON ✓
├─ Weather Alerts: ON ✓
├─ AI Analysis Results: ON ✓
├─ Promotional: OFF
└─ Do Not Disturb: 10 PM - 6 AM
```

### Location
```
├─ GPS: ON ✓
├─ Location Accuracy: High
├─ Auto-detect: ON ✓
└─ Manual Location: Allow manual entry
```

---

## 🆘 Help & Support

### In-App Help
- FAQ with video tutorials
- Live chat with support team
- Email support
- Phone helpline

### Troubleshooting

#### "GPS Not Detecting"
```
Solutions:
1. Enable Location Services
2. Move outdoors (away from buildings)
3. Refresh location button
4. Restart app
5. Check GPS permissions in Settings
```

#### "Image Upload Failed"
```
Solutions:
1. Check internet connection
2. Verify image size (<10MB)
3. Clear app cache
4. Try uploading again
5. Contact support
```

#### "Claim Not Submitted"
```
Solutions:
1. Fill all required fields
2. Check internet connection
3. Clear form and retry
4. Check device storage
5. Update app to latest version
```

---

**Last Updated**: December 2024
**Version**: 1.0.0+1
