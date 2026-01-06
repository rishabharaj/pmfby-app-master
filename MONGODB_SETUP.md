# MongoDB Atlas Setup Guide

## 1. MongoDB Atlas Configuration

### Step 1: Create MongoDB Atlas Account
1. Go to https://www.mongodb.com/cloud/atlas
2. Sign up for a free account
3. Create a new cluster (M0 free tier is sufficient for development)

### Step 2: Setup Database Access
1. Go to Database Access
2. Add a new database user
3. Set username and password (save these securely)
4. Grant "Read and write to any database" permissions

### Step 3: Setup Network Access
1. Go to Network Access
2. Add IP Address
3. For development: Add 0.0.0.0/0 (allows access from anywhere)
4. For production: Add specific IP addresses

### Step 4: Get Connection String
1. Click "Connect" on your cluster
2. Choose "Connect your application"
3. Copy the connection string
4. It will look like: `mongodb+srv://<username>:<password>@cluster0.xxxxx.mongodb.net/<dbname>?retryWrites=true&w=majority`

## 2. Configure the App

### Option 1: Environment Variables (Recommended)
Run the app with environment variables:
```bash
flutter run --dart-define=MONGO_USER=your_username \
            --dart-define=MONGO_PASSWORD=your_password \
            --dart-define=MONGO_CLUSTER=cluster0.xxxxx \
            --dart-define=MONGO_DB=pmfby_app
```

### Option 2: Update Config File
Edit `lib/src/config/mongodb_config.dart` and replace the connection string:
```dart
static String get connectionString {
  return 'mongodb+srv://YOUR_USER:YOUR_PASSWORD@YOUR_CLUSTER.mongodb.net/pmfby_app?retryWrites=true&w=majority';
}
```

## 3. Initialize MongoDB in Your App

Update `lib/main.dart` to initialize MongoDB:

```dart
import 'package:flutter/material.dart';
import 'src/services/mongodb_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize MongoDB
  try {
    await MongoDBService.instance.connect();
    debugPrint('MongoDB initialized successfully');
  } catch (e) {
    debugPrint('MongoDB initialization failed: $e');
  }
  
  runApp(const MyApp());
}
```

## 4. Database Collections

The app uses the following collections:

1. **farmers** - Stores farmer information with hashed Aadhaar
2. **crop_images** - Stores crop image metadata and AI analysis
3. **claims** - Stores insurance claim data
4. **ai_inferences** - Stores AI model predictions
5. **satellite_data** - Stores satellite and weather data
6. **audit_logs** - Stores all system actions for audit trail
7. **officials** - Stores official user accounts with hashed passwords

## 5. Security Features Implemented

### Password Hashing
- Passwords are hashed using SHA-256 with salt
- Stored format: `salt:hash`
- Never store plain text passwords

### Sensitive Data Protection
- Aadhaar numbers are hashed before storage
- Display format shows only last 4 digits: `xxxx-xxxx-1234`
- Phone numbers normalized to +91 format

### Input Sanitization
- All user inputs are sanitized to prevent injection attacks
- Special characters like `$`, `{`, `}` are removed

### Audit Logging
- All database operations are logged
- Tracks: entity, action, actor, timestamp, and details

## 6. Usage Examples

### Create a New Farmer
```dart
final farmerRepo = FarmerRepository();
final farmerId = await farmerRepo.createFarmer(
  firstName: 'Rohan',
  lastName: 'Patel',
  phone: '9876543210',
  aadhaarNumber: '123456789012',
  state: 'Maharashtra',
  district: 'Nagpur',
  taluka: 'XYZ',
  village: 'ABC',
  pincode: '440001',
);
```

### Register an Official
```dart
final authRepo = AuthRepository();
final userId = await authRepo.registerOfficial(
  name: 'Rahul Sharma',
  phone: '9876543210',
  password: 'SecurePassword123!',
  role: 'field_officer',
  assignedDistrict: 'Nagpur',
);
```

### Login
```dart
final authRepo = AuthRepository();
final official = await authRepo.loginOfficial(
  '9876543210',
  'SecurePassword123!',
);

if (official != null) {
  print('Login successful: ${official.name}');
} else {
  print('Invalid credentials');
}
```

### Add Audit Log
```dart
final authRepo = AuthRepository();
await authRepo.logAudit(
  entity: 'farmer',
  entityId: 'FRM_12345',
  action: 'CREATE',
  actor: 'OFF_678',
  details: {'newFarmer': true},
);
```

## 7. Database Indexes

The following indexes are automatically created for better performance:

### Farmers Collection
- `farmerId` (unique)
- `phone`
- `aadhaar.number`

### Claims Collection
- `claimId` (unique)
- `farmerId`
- `status`
- `{farmerId, season}` (compound)

### Images Collection
- `imageId` (unique)
- `farmerId`
- `parcelId`
- `{farmerId, season}` (compound)

## 8. Best Practices

1. **Never commit credentials** to version control
2. **Use environment variables** for sensitive data
3. **Enable MongoDB Atlas backups** for production
4. **Monitor database usage** through Atlas dashboard
5. **Implement rate limiting** for API endpoints
6. **Use connection pooling** for better performance
7. **Regular security audits** of database access
8. **Keep packages updated** for security patches

## 9. Troubleshooting

### Connection Issues
- Check if IP address is whitelisted in MongoDB Atlas
- Verify username and password are correct
- Ensure internet connection is stable

### Authentication Errors
- Verify database user has correct permissions
- Check if password contains special characters (may need URL encoding)

### Performance Issues
- Check if indexes are created properly
- Monitor slow queries in Atlas
- Consider upgrading to higher tier for production

## 10. Production Checklist

- [ ] Enable MongoDB Atlas backups
- [ ] Set up monitoring and alerts
- [ ] Configure specific IP whitelist
- [ ] Use strong passwords (generated, not user-created)
- [ ] Enable 2FA for Atlas account
- [ ] Set up disaster recovery plan
- [ ] Implement data retention policies
- [ ] Regular security audits
- [ ] Load testing and optimization
- [ ] Set up staging environment

## Support

For issues, refer to:
- MongoDB Documentation: https://docs.mongodb.com/
- mongo_dart Package: https://pub.dev/packages/mongo_dart
