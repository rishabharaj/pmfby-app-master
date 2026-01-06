# API Keys & Environment Setup Guide

## Quick Setup

### 1. MongoDB Atlas Setup
1. Go to [MongoDB Atlas](https://cloud.mongodb.com/)
2. Create a free cluster (M0)
3. Create a database user with username/password
4. Get your connection string from "Connect" → "Connect your application"
5. Extract the values:
   - Username: `your_username`
   - Password: `your_password` 
   - Cluster: `cluster0.xxxxx.mongodb.net`

### 2. Firebase Setup (Already configured with demo keys)
The app currently uses demo Firebase keys in `lib/firebase_options.dart`. To use your own:
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create/select your project
3. Go to Project Settings → General
4. Copy your configuration values
5. Update `lib/firebase_options.dart` or use environment variables

### 3. Add Keys to .env File
Edit `.env` file and add your actual credentials:

```env
MONGO_USER=your_mongodb_username
MONGO_PASSWORD=your_mongodb_password
MONGO_CLUSTER=cluster0.xxxxx.mongodb.net
MONGO_DB=pmfby_app
```

## Running the App with Environment Variables

### Option 1: Using flutter run with --dart-define (Recommended)
```bash
flutter run \
  --dart-define=MONGO_USER=your_username \
  --dart-define=MONGO_PASSWORD=your_password \
  --dart-define=MONGO_CLUSTER=cluster0.xxxxx.mongodb.net \
  --dart-define=MONGO_DB=pmfby_app
```

### Option 2: Directly edit mongodb_config.dart (Not recommended for production)
Edit `lib/src/config/mongodb_config.dart` and replace the connection string:
```dart
static String get connectionString {
  return 'mongodb+srv://YOUR_USER:YOUR_PASSWORD@YOUR_CLUSTER.mongodb.net/pmfby_app?retryWrites=true&w=majority';
}
```

## API Keys Location

### Current Setup:
- **MongoDB Config**: `lib/src/config/mongodb_config.dart`
- **Firebase Config**: `lib/firebase_options.dart` (using demo keys)
- **Environment Template**: `.env.example`
- **Your Keys**: `.env` (create and add your actual keys)

### Files Created:
✅ `.env` - Your actual API keys (ignored by git)
✅ `.env.example` - Template with example values (committed to git)
✅ Updated `.gitignore` - Ensures .env is never committed

## Security Notes:
⚠️ **NEVER commit `.env` file to git** - It contains sensitive credentials
✅ `.env` is now added to `.gitignore`
✅ Only commit `.env.example` with placeholder values
✅ Use environment variables for production deployments

## Next Steps:
1. Get your MongoDB Atlas credentials (see MONGODB_SETUP.md for detailed guide)
2. Add them to `.env` file
3. Run the app with `--dart-define` flags or update the config file directly
