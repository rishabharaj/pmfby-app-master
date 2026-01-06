# 🧪 Testing Guide - PMFBY App (Demo Mode)

## ✅ What's Been Implemented

### 1. **Demo Authentication System**
- ✅ Bypassed real OTP verification for testing
- ✅ Auto-accept OTP `123456` for all demo users
- ✅ Instant login without Firebase/SMS costs
- ✅ Pre-configured test users (3 farmers + 3 officers)

### 2. **Login Methods**
- ✅ **Phone OTP Login**: Enter phone → Auto OTP verification
- ✅ **Email Login**: Traditional email/password authentication
- ✅ Demo credentials displayed on login screen

### 3. **Registration System**
- ✅ Registration buttons on login screen
- ✅ Routes: `/register/farmer` and `/register/officer`
- ✅ Dialog prompt for unknown users

---

## 🚀 Quick Start Testing

### Fastest Way to Login:
```
1. Open app
2. See "Demo Test Accounts" card on login screen
3. Enter: 9876543210
4. Click "Send OTP"
5. Enter: 123456
6. Done! ✅
```

---

## 📱 Demo User Credentials

### 👨‍🌾 Farmers (Password: test123)
| Name | Phone | Email | Location |
|------|-------|-------|----------|
| Ramesh Patel | 9876543210 | ramesh@farmer.test | Khandala, Nagpur |
| Suresh Kumar | 9876543211 | suresh@farmer.test | Pipri, Nagpur |
| Anita Devi | 9876543212 | anita@farmer.test | Kamptee, Nagpur |

### 👔 Officers (Password: admin123)
| Name | Phone | Email | Role |
|------|-------|-------|------|
| Rahul Sharma | 9876543220 | rahul@officer.test | Field Officer |
| Priya Singh | 9876543221 | priya@officer.test | Admin |
| Amit Verma | 9876543222 | amit@officer.test | Data Annotator |

---

## 🎯 Test Scenarios

### Scenario 1: Farmer Workflow
```bash
# Login
Phone: 9876543210
OTP: 123456

# Actions Available:
- View Dashboard
- Capture Crop Images
- File Insurance Claims
- View Schemes
- Track Claim Status
```

### Scenario 2: Officer Workflow
```bash
# Login
Phone: 9876543220
OTP: 123456

# Actions Available:
- Review Pending Claims
- Approve/Reject Claims
- View Farmer Details
- Generate Reports
```

### Scenario 3: Admin Workflow
```bash
# Login
Email: priya@officer.test
Password: admin123

# Actions Available:
- Full System Access
- User Management
- Analytics Dashboard
- Data Export
```

### Scenario 4: New User Registration
```bash
# Try login with: 9999999999
# Result: "User not found" dialog
# Options: 
  - Register as Farmer
  - Register as Officer
```

---

## 🔧 Technical Implementation

### Files Modified:
1. **`lib/src/features/auth/presentation/login_screen.dart`**
   - Added demo OTP bypass
   - Added registration buttons
   - Added demo credentials display
   - Added registration dialog

2. **`lib/src/utils/demo_users.dart`** (New)
   - Contains all demo user data
   - OTP validation logic
   - User lookup functions

3. **`lib/main.dart`**
   - Added `/register/farmer` route
   - Added `/register/officer` route

### Key Functions:
```dart
// Check if user is demo
DemoUsers.findByPhone('9876543210')

// Validate OTP (always true for '123456')
DemoUsers.isValidOTP('123456')

// Get all demo phones
DemoUsers.getAllPhones()
```

---

## 🎨 UI Changes

### Login Screen Now Shows:
1. **Demo Credentials Card** (top of screen)
   - Quick reference for test phones
   - Demo OTP reminder

2. **Registration Section** (bottom of screen)
   - "Register as Farmer" button
   - "Register as Officer" button

3. **Enhanced Messages**
   - Bilingual (Hindi + English)
   - User-friendly error messages
   - Welcome messages with names

---

## ⚙️ Configuration

### Demo OTP (Hardcoded):
```dart
static const String demoOTP = '123456';
```

### Auto-Login Flow:
```
Phone Entry → Check Demo User → Send "OTP" → 
Enter 123456 → Validate → Navigate to Dashboard
```

### Registration Flow:
```
Unknown Phone → Error Dialog → Choose Role → 
Registration Form → Create Account → Login
```

---

## 📊 Testing Checklist

- [ ] Login with farmer phone (9876543210)
- [ ] Login with officer phone (9876543220)
- [ ] Login with email (rahul@officer.test)
- [ ] Try wrong OTP (should fail)
- [ ] Try correct OTP 123456 (should work)
- [ ] Click "Register as Farmer"
- [ ] Click "Register as Officer"
- [ ] Test with unknown phone number
- [ ] Verify bilingual messages
- [ ] Check dashboard navigation

---

## 🐛 Common Issues & Solutions

### Issue: "User not found"
**Solution**: Use demo phone numbers (9876543210-212, 9876543220-222)

### Issue: "Invalid OTP"
**Solution**: Demo OTP is always `123456`

### Issue: Registration routes not working
**Solution**: Ensure routes are added in `main.dart`

### Issue: Login succeeds but crashes
**Solution**: Check if dashboard screen is properly configured

---

## 🚦 Production Readiness

### Current Status: ⚠️ DEMO MODE
- Using hardcoded credentials
- No real SMS/OTP service
- No backend authentication

### Before Production:
- [ ] Implement real OTP service
- [ ] Add MongoDB authentication
- [ ] Remove demo users
- [ ] Enable Firebase auth
- [ ] Add rate limiting
- [ ] Implement JWT tokens
- [ ] Add security headers

---

## 📞 Support

**For Demo Testing Issues:**
- Check `DEMO_USERS.md` for complete user list
- Verify OTP is exactly `123456`
- Ensure phone format is 10 digits (no +91)

**Documentation:**
- `DEMO_USERS.md` - Complete user credentials
- `API_KEYS_SETUP.md` - API configuration guide
- `MONGODB_SETUP.md` - Database setup guide

---

**Testing Mode**: ACTIVE ✅
**Production Ready**: NO ⚠️
**Last Updated**: November 23, 2025
