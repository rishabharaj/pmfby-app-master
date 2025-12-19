# 👨‍💻 KrishiBandhu - Developer Guide

Technical documentation for developers working on the KrishiBandhu project.

---

## Table of Contents
1. [Project Setup](#project-setup)
2. [Architecture Overview](#architecture-overview)
3. [Code Structure](#code-structure)
4. [Firebase Integration](#firebase-integration)
5. [State Management](#state-management)
6. [Database Operations](#database-operations)
7. [API Integration](#api-integration)
8. [Testing](#testing)
9. [Deployment](#deployment)
10. [Common Issues & Solutions](#common-issues--solutions)

---

## 🚀 Project Setup

### Environment Requirements
```bash
# Check Flutter version
flutter --version
# Required: Flutter 3.9.0+

# Check Dart version
dart --version
# Required: Dart 3.9.0+

# Check Android SDK
flutter doctor
# Required: Android API 21 (5.0) minimum
```

### Initial Setup
```bash
# Clone repository
git clone https://github.com/rishabharaj/pmfby-app-master.git
cd pmfby-app-master

# Get dependencies
flutter pub get

# Generate necessary files
flutter pub run build_runner build

# Run code analysis
flutter analyze

# Format code
flutter format lib/
```

### Firebase Initialization
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase for project
firebase init

# Deploy Firestore security rules
firebase deploy --only firestore:rules

# Deploy Cloud Functions
firebase deploy --only functions
```

---

## 🏗️ Architecture Overview

### Clean Architecture Pattern

```
┌─────────────────────────────────────────────┐
│           Presentation Layer                 │
│  (Screens, Widgets, State Management)        │
├─────────────────────────────────────────────┤
│             Domain Layer                     │
│  (Entities, Use Cases, Repositories)         │
├─────────────────────────────────────────────┤
│             Data Layer                       │
│  (Models, Data Sources, Repositories Impl)   │
└─────────────────────────────────────────────┘
```

### Folder Structure

```
lib/
├── main.dart                           # App entry point
├── firebase_options.dart               # Firebase config
│
└── src/
    ├── config/                         # Configuration files
    │   └── mongodb_config.dart
    │
    ├── features/                       # Feature modules
    │   ├── auth/
    │   │   ├── domain/
    │   │   │   ├── entities/
    │   │   │   ├── repositories/
    │   │   │   └── usecases/
    │   │   ├── data/
    │   │   │   ├── datasources/
    │   │   │   ├── models/
    │   │   │   └── repositories/
    │   │   └── presentation/
    │   │       ├── screens/
    │   │       ├── widgets/
    │   │       └── providers/
    │   │
    │   ├── crop_monitoring/
    │   ├── claims/
    │   ├── dashboard/
    │   ├── schemes/
    │   ├── profile/
    │   └── [other features]
    │
    ├── models/                         # Shared data models
    │   ├── user_profile.dart
    │   ├── insurance_claim.dart
    │   ├── crop_image.dart
    │   └── mongodb/
    │
    ├── providers/                      # Global providers
    │   ├── auth_provider.dart
    │   └── language_provider.dart
    │
    ├── repositories/                   # Data repositories
    │   ├── auth_repository.dart
    │   └── crop_image_repository.dart
    │
    ├── services/                       # Business logic
    │   ├── auth_service.dart
    │   ├── image_service.dart
    │   └── notification_service.dart
    │
    ├── localization/                   # i18n & L10n
    │   └── app_localizations.dart
    │
    ├── theme/                          # UI theme
    │   ├── app_colors.dart
    │   ├── app_text_styles.dart
    │   └── app_theme.dart
    │
    ├── utils/                          # Utility functions
    │   ├── constants.dart
    │   ├── validators.dart
    │   └── extensions.dart
    │
    └── widgets/                        # Reusable components
        ├── common_widgets.dart
        ├── custom_buttons.dart
        └── form_fields.dart
```

---

## 📝 Code Structure

### Feature Module Template

```dart
// feature/auth/domain/repositories/auth_repository.dart
abstract class AuthRepository {
  Future<Either<Failure, User>> loginWithPhone(String phoneNumber);
  Future<Either<Failure, User>> verifyOTP(String otp);
  Future<Either<Failure, User>> registerUser(User user);
  Future<Either<Failure, void>> logout();
}

// feature/auth/data/repositories/auth_repository_impl.dart
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  @override
  Future<Either<Failure, User>> loginWithPhone(String phoneNumber) async {
    try {
      final result = await remoteDataSource.loginWithPhone(phoneNumber);
      await localDataSource.saveUser(result);
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

// feature/auth/presentation/screens/login_screen.dart
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return Scaffold(
          body: Column(
            children: [
              TextField(
                onChanged: (value) => authProvider.phoneNumber = value,
              ),
              ElevatedButton(
                onPressed: () => authProvider.loginWithPhone(),
                child: Text('Login'),
              ),
            ],
          ),
        );
      },
    );
  }
}
```

---

## 🔥 Firebase Integration

### Firebase Authentication

#### Phone OTP Authentication
```dart
// lib/src/services/auth_service.dart

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Send OTP
  Future<void> sendPhoneOTP(String phoneNumber) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        throw Exception('Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        // Store verificationId for OTP verification
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('verificationId', verificationId);
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  // Verify OTP
  Future<User> verifyOTP(String otp) async {
    final verificationId = await SharedPreferences.getInstance()
        .then((prefs) => prefs.getString('verificationId') ?? '');

    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return userCredential.user!;
  }
}
```

#### Email/Password Authentication
```dart
class AuthService {
  // Register with email
  Future<User> registerWithEmail(String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user!;
  }

  // Login with email
  Future<User> loginWithEmail(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user!;
  }

  // Logout
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
```

### Firestore Database

#### CRUD Operations
```dart
// lib/src/services/firestore_service.dart

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // CREATE
  Future<void> createClaim(InsuranceClaim claim) async {
    await _firestore.collection('insurance_claims').add({
      'farmerId': claim.farmerId,
      'cropName': claim.cropName,
      'damageReason': claim.damageReason,
      'incidentDate': claim.incidentDate,
      'estimatedLoss': claim.estimatedLoss,
      'status': 'SUBMITTED',
      'submittedAt': FieldValue.serverTimestamp(),
    });
  }

  // READ
  Future<List<InsuranceClaim>> getUserClaims(String userId) async {
    final snapshot = await _firestore
        .collection('insurance_claims')
        .where('farmerId', isEqualTo: userId)
        .get();

    return snapshot.docs
        .map((doc) => InsuranceClaim.fromFirestore(doc))
        .toList();
  }

  // Real-time listener
  Stream<List<InsuranceClaim>> getUserClaimsStream(String userId) {
    return _firestore
        .collection('insurance_claims')
        .where('farmerId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => InsuranceClaim.fromFirestore(doc))
            .toList());
  }

  // UPDATE
  Future<void> updateClaimStatus(String claimId, String status) async {
    await _firestore.collection('insurance_claims').doc(claimId).update({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // DELETE
  Future<void> deleteClaim(String claimId) async {
    await _firestore.collection('insurance_claims').doc(claimId).delete();
  }
}
```

### Firebase Storage

#### Image Upload & Download
```dart
// lib/src/services/storage_service.dart

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload image
  Future<String> uploadCropImage(File imageFile, String userId) async {
    try {
      final fileName = 'crop_images/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      final reference = _storage.ref().child(fileName);
      
      final uploadTask = reference.putFile(
        imageFile,
        SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {
            'uploadedBy': userId,
            'uploadedAt': DateTime.now().toIso8601String(),
          },
        ),
      );

      final snapshot = await uploadTask;
      final downloadUrl = await reference.getDownloadURL();
      
      return downloadUrl;
    } catch (e) {
      throw Exception('Image upload failed: $e');
    }
  }

  // Download image
  Future<File> downloadCropImage(String imageUrl, String fileName) async {
    try {
      final Directory tempDir = await getTemporaryDirectory();
      final File file = File('${tempDir.path}/$fileName');

      await file.writeAsBytes(
        await Uint8List.fromFuture(
          _storage.refFromURL(imageUrl).getData(),
        ),
      );

      return file;
    } catch (e) {
      throw Exception('Image download failed: $e');
    }
  }

  // Delete image
  Future<void> deleteCropImage(String imageUrl) async {
    try {
      await _storage.refFromURL(imageUrl).delete();
    } catch (e) {
      throw Exception('Image deletion failed: $e');
    }
  }
}
```

---

## 🎛️ State Management

### Provider Pattern Implementation

```dart
// lib/src/features/auth/presentation/providers/auth_provider.dart

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _currentUser != null;

  // Initialize provider
  Future<void> initialize() async {
    _currentUser = await _authService.getCurrentUser();
    notifyListeners();
  }

  // Login
  Future<bool> login(String email, String password) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final user = await _authService.login(email, password);
      _currentUser = user;
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Register
  Future<bool> register(User user) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final registeredUser = await _authService.register(user);
      _currentUser = registeredUser;
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    await _authService.logout();
    _currentUser = null;
    notifyListeners();
  }
}
```

### Using Provider in Widgets

```dart
class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isLoggedIn) {
          return Scaffold(
            body: Column(
              children: [
                Text('Welcome, ${authProvider.currentUser?.name}'),
                ElevatedButton(
                  onPressed: () => authProvider.logout(),
                  child: Text('Logout'),
                ),
              ],
            ),
          );
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
```

---

## 💾 Database Operations

### MongoDB Connection

```dart
// lib/src/config/mongodb_config.dart

class MongoDBConfig {
  static const String connectionString = 
    'mongodb+srv://username:password@cluster.mongodb.net/database_name';

  static final Db db = Db(connectionString);

  static Future<void> connect() async {
    try {
      await db.open();
      print('Connected to MongoDB');
    } catch (e) {
      print('MongoDB connection error: $e');
    }
  }

  static Future<void> disconnect() async {
    await db.close();
  }
}

// Usage in service
class MongoDBService {
  static final db = MongoDBConfig.db;

  // Insert document
  static Future<void> insertClaim(Map<String, dynamic> claimData) async {
    final collection = db.collection('insurance_claims');
    await collection.insertOne(claimData);
  }

  // Find documents
  static Future<List<Map<String, dynamic>>> getClaims(String userId) async {
    final collection = db.collection('insurance_claims');
    final claims = await collection.find({'farmerId': userId}).toList();
    return claims;
  }

  // Update document
  static Future<void> updateClaimStatus(String claimId, String status) async {
    final collection = db.collection('insurance_claims');
    await collection.updateOne(
      where.id(ObjectId.fromHexString(claimId)),
      modify.set('status', status),
    );
  }
}
```

---

## 🔌 API Integration

### REST API Calls

```dart
// lib/src/services/api_service.dart

class ApiService {
  static const String baseUrl = 'https://api.krishibandhu.app/v1';
  final http.Client httpClient;

  ApiService({http.Client? httpClient})
      : httpClient = httpClient ?? http.Client();

  // GET request
  Future<dynamic> getRequest(String endpoint) async {
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await _getToken()}',
        },
      ).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // POST request
  Future<dynamic> postRequest(String endpoint, dynamic body) async {
    try {
      final response = await httpClient.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await _getToken()}',
        },
        body: jsonEncode(body),
      ).timeout(Duration(seconds: 30));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Get auth token
  Future<String> _getToken() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return await user.getIdToken();
    }
    return '';
  }
}
```

---

## ✅ Testing

### Unit Tests

```dart
// test/services/auth_service_test.dart

void main() {
  group('AuthService', () {
    late AuthService authService;
    late MockFirebaseAuth firebaseAuth;

    setUp(() {
      firebaseAuth = MockFirebaseAuth();
      authService = AuthService(firebaseAuth: firebaseAuth);
    });

    test('Login with valid credentials', () async {
      // Arrange
      const email = 'test@example.com';
      const password = 'password123';

      // Act
      final user = await authService.loginWithEmail(email, password);

      // Assert
      expect(user, isNotNull);
      expect(user.email, email);
    });

    test('Login with invalid credentials throws exception', () async {
      // Arrange
      const email = 'invalid@example.com';
      const password = 'wrong';

      // Act & Assert
      expect(
        () => authService.loginWithEmail(email, password),
        throwsException,
      );
    });
  });
}
```

### Widget Tests

```dart
// test/screens/login_screen_test.dart

void main() {
  group('LoginScreen', () {
    testWidgets('Login button is present', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => MockAuthProvider()),
          ],
          child: const MyApp(),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Entering credentials and submitting form', 
        (WidgetTester tester) async {
      // Test implementation
    });
  });
}
```

---

## 🚀 Deployment

### Android Build & Release

```bash
# Build APK
flutter build apk --release

# Build App Bundle (for Play Store)
flutter build appbundle --release

# Signed APK
flutter build apk --release --target-platform android-arm64

# Sign APK manually
jarsigner -verbose -sigalg SHA256withRSA -digestalg SHA-256 \
  -keystore ~/key.jks app-release-unsigned.apk my-key-alias
```

### Firebase Deployment

```bash
# Deploy Firestore rules
firebase deploy --only firestore:rules

# Deploy Cloud Functions
firebase deploy --only functions

# Deploy storage rules
firebase deploy --only storage

# Deploy all
firebase deploy
```

### Play Store Release

1. **Create app signing key**
2. **Generate signed APK/App Bundle**
3. **Upload to Google Play Console**
4. **Fill app details & screenshots**
5. **Submit for review**
6. **Wait for approval (24-48 hours)**

---

## 🐛 Common Issues & Solutions

### Issue: GPS Not Working

```
Solution:
1. Check location permissions in AndroidManifest.xml
2. Ensure geolocator package is properly initialized
3. Test on real device (emulator GPS is unreliable)
4. Call: await Geolocator.requestPermission();
5. Check if location services are enabled on device
```

### Issue: Firebase Initialization Failed

```
Solution:
1. Verify google-services.json is in android/app/
2. Check Firebase project ID matches
3. Ensure internet connectivity
4. Clear cache: flutter clean && flutter pub get
5. Check if Firebase services are enabled in console
```

### Issue: Image Upload Timeout

```
Solution:
1. Compress image before upload: flutter_image_compress
2. Increase timeout duration
3. Check internet speed
4. Split large files into chunks
5. Implement retry mechanism with exponential backoff
```

### Issue: Provider Not Updating UI

```
Solution:
1. Use Consumer<ProviderName> widget
2. Call notifyListeners() after state changes
3. Check if provider is properly initialized
4. Use MultiProvider at root level
5. Verify widget is listening to correct provider
```

---

## 📚 Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase for Flutter](https://firebase.flutter.dev/)
- [Provider Package](https://pub.dev/packages/provider)
- [Clean Architecture](https://resocoder.com/flutter-clean-architecture)
- [Dart Effective Dart](https://dart.dev/guides/language/effective-dart)

---

**Last Updated**: December 2024
**Version**: 1.0.0+1
