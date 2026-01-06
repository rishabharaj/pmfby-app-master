# 🧪 Demo Test Users for PMFBY App

## 🌾 Farmer Test Accounts

### Farmer 1: Ramesh Patel
- **Phone**: `9876543210`
- **Email**: `ramesh@farmer.test`
- **Password**: `test123`
- **Location**: Khandala, Nagpur, Maharashtra
- **Use Case**: Primary farmer account for testing claim submissions

### Farmer 2: Suresh Kumar
- **Phone**: `9876543211`
- **Email**: `suresh@farmer.test`
- **Password**: `test123`
- **Location**: Pipri, Nagpur, Maharashtra
- **Use Case**: Secondary farmer for testing multiple user scenarios

### Farmer 3: Anita Devi
- **Phone**: `9876543212`
- **Email**: `anita@farmer.test`
- **Password**: `test123`
- **Location**: Kamptee, Nagpur, Maharashtra
- **Use Case**: Female farmer representative for testing

---

## 👔 Officer Test Accounts

### Officer 1: Rahul Sharma (Field Officer)
- **Phone**: `9876543220`
- **Email**: `rahul@officer.test`
- **Password**: `admin123`
- **Role**: Field Officer
- **District**: Nagpur
- **Permissions**: Review claims, approve local claims, view/update farmers
- **Use Case**: Front-line officer for field verification

### Officer 2: Priya Singh (Admin)
- **Phone**: `9876543221`
- **Email**: `priya@officer.test`
- **Password**: `admin123`
- **Role**: District Admin
- **District**: Nagpur
- **Permissions**: Full access - approve claims, manage users, view analytics, export data
- **Use Case**: District-level administrator with full permissions

### Officer 3: Amit Verma (Data Annotator)
- **Phone**: `9876543222`
- **Email**: `amit@officer.test`
- **Password**: `admin123`
- **Role**: Data Annotator
- **District**: Nagpur
- **Permissions**: Annotate images, view images
- **Use Case**: AI training data annotation specialist

---

## 🔐 Login Methods

### Method 1: Phone OTP Login (Recommended for Testing)
1. Enter phone number (e.g., `9876543210`)
2. Click "Send OTP"
3. Enter OTP: **`123456`** (Demo OTP - always works)
4. Click "Verify"

### Method 2: Email Password Login
1. Switch to "Email Login" tab
2. Enter email (e.g., `ramesh@farmer.test`)
3. Enter password: `test123` (for farmers) or `admin123` (for officers)
4. Click "Login as Farmer" or "Login as Official"

---

## 📝 Registration (For New Users)

If you try to login with a phone number that's not in the demo list:
1. You'll get a "User not found" message
2. Click on registration options:
   - **Register as Farmer**: For new farmer accounts
   - **Register as Officer**: For new government officials

---

## 🎯 Quick Test Scenarios

### Scenario 1: Farmer Login & Claim Submission
```
Phone: 9876543210
OTP: 123456
Action: Navigate to Dashboard → File New Claim
```

### Scenario 2: Officer Review & Approval
```
Phone: 9876543220
OTP: 123456
Action: Navigate to Dashboard → Review Pending Claims
```

### Scenario 3: Admin Functions
```
Email: priya@officer.test
Password: admin123
Action: Access admin panel → View analytics → Manage users
```

### Scenario 4: Multi-User Testing
```
Login as: Farmer (9876543210)
- Submit a claim

Login as: Field Officer (9876543220)
- Review and approve the claim

Login as: Admin (9876543221)
- Generate reports and analytics
```

---

## 🔧 Technical Details

### Demo Mode Features:
- ✅ **Auto OTP Verification**: Always accepts `123456` as valid OTP
- ✅ **No SMS Costs**: Bypasses actual OTP sending for testing
- ✅ **Instant Login**: No Firebase/backend dependency required
- ✅ **Persistent Demo Data**: Hardcoded users in `lib/src/utils/demo_users.dart`

### Implementation:
```dart
// Check demo user
final demoUser = DemoUsers.findByPhone('9876543210');

// Validate OTP
if (DemoUsers.isValidOTP('123456')) {
  // Login successful
}
```

---

## ⚠️ Important Notes

1. **Demo OTP is always**: `123456`
2. **Passwords**:
   - Farmers: `test123`
   - Officers: `admin123`
3. **Phone Format**: Enter 10 digits without +91 prefix
4. **Production**: This demo system will be replaced with real authentication
5. **Security**: Never use these credentials in production

---

## 🚀 Getting Started

### Quick Test:
1. Launch the app
2. On login screen, enter: `9876543210`
3. Click "Send OTP"
4. Enter OTP: `123456`
5. You're logged in as Ramesh Patel (Farmer)

### Alternative:
1. Switch to "Email Login" tab
2. Email: `rahul@officer.test`
3. Password: `admin123`
4. Click "Login as Official"
5. You're logged in as Rahul Sharma (Field Officer)

---

## 📞 Support

For issues with demo accounts:
- Check `lib/src/utils/demo_users.dart` for full user list
- All demo users are in Nagpur district
- OTP is always `123456` in demo mode
- Passwords: `test123` (farmers) | `admin123` (officers)

---

**Last Updated**: November 23, 2025
**Version**: 1.0 (Demo Mode)
