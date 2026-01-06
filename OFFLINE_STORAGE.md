# Offline Storage Implementation

## Overview
The PMFBY app now includes comprehensive offline storage functionality that allows farmers to capture crop images even without internet connectivity. Images are stored locally and automatically synced when the device comes online.

## Key Features

### 1. **Local Storage with GPS Tracking**
- Images captured are saved locally on the device
- GPS coordinates (latitude/longitude) are captured with each image
- Location name is resolved using reverse geocoding
- Crop type selection dialog for categorization
- All metadata stored in SharedPreferences

### 2. **Automatic Background Sync**
- **Foreground Sync**: Checks every 30 seconds when app is open
- **Background Sync**: WorkManager periodic task runs every 15 minutes
- Only syncs when network connectivity is available
- Retry mechanism (max 3 attempts) for failed uploads
- Push notifications for sync status

### 3. **Offline Indicator on Home Screen**
- Orange banner appears at top of dashboard when offline
- Shows count of pending uploads
- Tap banner to navigate to Upload Status screen
- Real-time connectivity monitoring

### 4. **Upload Status Monitoring**
- Dedicated screen (`/upload-status`) to view all uploads
- Statistics card showing:
  - Pending uploads count
  - Successfully synced count
  - Failed uploads count
  - Total storage used
  - Last sync timestamp
- Image thumbnails with GPS coordinates
- Color-coded status indicators:
  - 🟠 Orange: Pending upload
  - 🔵 Blue: Currently uploading
  - 🟢 Green: Successfully synced
  - 🔴 Red: Failed (with error message)
- Pull-to-refresh functionality
- Clear synced uploads feature

### 5. **Home Screen Integration**
- New action card "अपलोड स्टेटस" (Upload Status)
- Red badge showing pending uploads count
- Quick access to monitoring screen

## Technical Architecture

### Services Created

#### 1. LocalStorageService (`lib/src/services/local_storage_service.dart`)
```dart
// Core functionality:
- savePendingUpload() - Queue new upload
- getPendingUploads() - Retrieve all uploads
- updateUploadStatus() - Update sync status
- removeUpload() - Delete upload
- clearSyncedUploads() - Cleanup synced items
- saveImageLocally() - Copy image to app directory
- getStorageStats() - Calculate storage usage
- getPendingUploadsCount() - Count pending items
```

**PendingUpload Model:**
```dart
class PendingUpload {
  String id;                // Unique identifier
  String imagePath;         // Local file path
  String cropType;          // Wheat, Rice, etc.
  String description;       // Location name
  double latitude;          // GPS latitude
  double longitude;         // GPS longitude
  DateTime capturedAt;      // Capture timestamp
  SyncStatus status;        // pending/uploading/synced/failed
  int retryCount;          // Failed attempt count
  String? errorMessage;    // Error details
}
```

#### 2. ConnectivityService (`lib/src/services/connectivity_service.dart`)
```dart
// Real-time network monitoring:
- Extends ChangeNotifier
- StreamSubscription to connectivity_plus
- Boolean isOnline property
- Notifies listeners on connectivity changes
```

#### 3. AutoSyncService (`lib/src/services/auto_sync_service.dart`)
```dart
// Automatic synchronization:
- initializeBackgroundSync() - Register WorkManager
- startPeriodicSync() - Start foreground timer
- stopPeriodicSync() - Stop foreground timer
- syncPendingUploads() - Process upload queue
- Notification system for sync feedback
- Retry logic with exponential backoff
```

### Dependencies Added

```yaml
dependencies:
  connectivity_plus: ^6.1.0              # Network status monitoring
  flutter_local_notifications: ^18.0.1   # Push notifications
  workmanager: ^0.5.2                    # Background tasks
```

## User Flow

### Capturing Image Offline

1. User taps "Capture Image" FAB on home screen
2. App requests GPS location permission
3. User takes photo with camera
4. Crop type selection dialog appears
5. Image is saved locally with GPS coordinates
6. Success message: "फोटो सेव हुई! ऑनलाइन होने पर सिंक होगी"
7. User returns to home screen

### Automatic Sync

1. When device comes online, ConnectivityService detects change
2. AutoSyncService starts processing upload queue
3. Notification shows "Syncing X images..."
4. Each upload is attempted (max 3 retries)
5. Status updated: pending → uploading → synced/failed
6. Completion notification: "X images synced successfully"
7. Home screen badge count updates

### Monitoring Uploads

1. User taps offline banner or "Upload Status" action card
2. Upload Status screen shows:
   - Statistics summary card
   - List of all uploads with thumbnails
   - GPS coordinates for each image
   - Color-coded status chips
3. Pull down to refresh list
4. Tap "Clear Synced" to remove completed uploads

## UI Components

### Home Screen (Dashboard)

**Offline Banner:**
```dart
// Shown when ConnectivityService.isOnline == false
Consumer<ConnectivityService>(
  builder: (context, connectivityService, child) {
    if (!connectivityService.isOnline) {
      return OfflineBanner(
        pendingCount: _pendingUploadsCount,
        onTap: () => context.push('/upload-status'),
      );
    }
    return SizedBox.shrink();
  },
)
```

**Upload Status Action Card:**
```dart
_buildActionCardWithBadge(
  'अपलोड स्टेटस',
  'Upload Status',
  Icons.cloud_upload,
  Colors.indigo,
  () => context.push('/upload-status'),
  _pendingUploadsCount, // Red badge count
)
```

### Capture Image Screen

**Modified Upload Flow:**
```dart
Future<void> _uploadImage() async {
  // 1. Show crop type selection dialog
  final cropType = await _showCropTypeDialog();
  
  // 2. Save image locally
  final savedPath = await localStorageService.saveImageLocally(imageFile);
  
  // 3. Create PendingUpload with GPS
  final upload = PendingUpload(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    imagePath: savedPath,
    cropType: cropType,
    latitude: _position.latitude,
    longitude: _position.longitude,
    // ... other fields
  );
  
  // 4. Queue for sync
  await localStorageService.savePendingUpload(upload);
  
  // 5. Show appropriate message
  if (isOnline) {
    showSuccess('Image saved and syncing!');
  } else {
    showSuccess('Image saved! Will sync when online');
  }
}
```

### Upload Status Screen

**Layout:**
```
┌─────────────────────────────────┐
│  ← अपलोड स्टेटस         🔄      │
├─────────────────────────────────┤
│  Statistics Card                │
│  • Pending: 5                   │
│  • Synced: 12                   │
│  • Failed: 1                    │
│  • Total: 2.4 MB                │
│  • Last sync: 2 mins ago        │
├─────────────────────────────────┤
│  Upload List                    │
│  ┌─────┬──────────────────┐    │
│  │[IMG]│ Wheat             │    │
│  │     │ 28.6°N, 77.2°E   │    │
│  │     │ [🟠 Pending]     │    │
│  └─────┴──────────────────┘    │
│  ┌─────┬──────────────────┐    │
│  │[IMG]│ Rice              │    │
│  │     │ 28.6°N, 77.2°E   │    │
│  │     │ [🟢 Synced]      │    │
│  └─────┴──────────────────┘    │
└─────────────────────────────────┘
```

## Configuration Required

### Android (android/app/src/main/AndroidManifest.xml)

Add permissions for background work:
```xml
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.WAKE_LOCK"/>
<uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>

<!-- Inside <application> tag -->
<receiver android:name="androidx.work.impl.background.systemalarm.SystemAlarmService"/>
```

### iOS (ios/Runner/Info.plist)

Add background modes:
```xml
<key>UIBackgroundModes</key>
<array>
  <string>fetch</string>
  <string>processing</string>
</array>
```

## Testing Checklist

- [ ] Capture image while offline
- [ ] Verify image saved locally
- [ ] Check GPS coordinates captured
- [ ] Verify offline banner appears on home
- [ ] Check pending count badge on action card
- [ ] Navigate to Upload Status screen
- [ ] Enable internet connection
- [ ] Verify automatic sync triggers
- [ ] Check notification appears during sync
- [ ] Verify upload status changes to "Synced"
- [ ] Test retry mechanism (simulate server error)
- [ ] Verify background sync works when app closed
- [ ] Test clear synced uploads feature
- [ ] Check storage statistics accuracy

## API Integration (TODO)

The `_uploadToServer()` method in `AutoSyncService` currently has mock implementation:

```dart
Future<void> _uploadToServer(PendingUpload upload) async {
  // TODO: Implement actual upload to Firebase Storage
  // 1. Upload image file
  // 2. Create Firestore document with metadata
  // 3. Handle errors and retry logic
  
  // Current mock:
  await Future.delayed(Duration(seconds: 2));
  if (Random().nextBool()) throw Exception('Upload failed');
}
```

**Replace with:**
```dart
Future<void> _uploadToServer(PendingUpload upload) async {
  final storageRef = FirebaseStorage.instance
      .ref()
      .child('crop_images')
      .child('${upload.id}.jpg');
  
  await storageRef.putFile(File(upload.imagePath));
  final downloadUrl = await storageRef.getDownloadURL();
  
  await FirebaseFirestore.instance
      .collection('crop_images')
      .doc(upload.id)
      .set({
        'imageUrl': downloadUrl,
        'cropType': upload.cropType,
        'description': upload.description,
        'latitude': upload.latitude,
        'longitude': upload.longitude,
        'capturedAt': upload.capturedAt.toIso8601String(),
        'userId': FirebaseAuth.instance.currentUser?.uid,
      });
}
```

## Troubleshooting

### Images not syncing
1. Check internet connectivity
2. Verify WorkManager is initialized in main.dart
3. Check notification permissions granted
4. Review logs for error messages

### High storage usage
1. Use "Clear Synced" button regularly
2. Images stored in app's document directory
3. Cleared when app is uninstalled

### Background sync not working
1. Verify permissions in AndroidManifest.xml
2. Check battery optimization settings
3. Ensure WorkManager constraints met (network available)

### GPS location not captured
1. Check location permissions granted
2. Ensure GPS enabled on device
3. Location services must be "High Accuracy" mode

## Future Enhancements

1. **Compression**: Compress images before local storage
2. **Wi-Fi Only Sync**: Option to sync only on Wi-Fi
3. **Manual Sync**: Button to trigger sync manually
4. **Batch Operations**: Select multiple uploads to delete/retry
5. **Export Data**: Download synced images as ZIP
6. **Cloud Backup**: Backup local storage to cloud periodically
7. **Analytics**: Track sync success rate and average time
8. **Priority Queue**: Allow user to prioritize certain uploads

## Support

For issues or questions:
- Check logs: `flutter logs`
- Review error messages in Upload Status screen
- Contact: support@pmfby-app.com

---

**Version**: 1.0.0  
**Last Updated**: 2024  
**Author**: PMFBY Development Team
