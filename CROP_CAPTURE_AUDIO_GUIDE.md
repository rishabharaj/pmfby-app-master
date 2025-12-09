# Crop Capture Audio Feature

## Overview
This feature adds an audio button inside the crop image capture screen on the farmer dashboard. It allows farmers to listen to guidance audio while capturing crop images.

## Files Created

### 1. **Audio Service**
- **Location:** `lib/src/services/crop_capture_audio_service.dart`
- **Purpose:** Manages audio playback, state, and controls
- **Key Features:**
  - Play/Pause/Stop audio controls
  - Progress tracking (current position and duration)
  - Seek functionality
  - ChangeNotifier for reactive UI updates

### 2. **Audio Player Widget**
- **Location:** `lib/src/widgets/crop_capture_audio_player.dart`
- **Purpose:** UI dialog for displaying audio player controls
- **Features:**
  - Play, Pause, Stop buttons
  - Progress slider with time display
  - Status indicator (Playing/Stopped)
  - Hindi and English labels

### 3. **Audio Asset File**
- **Location:** `assets/audio/crop_capture_audio.mp3`
- **Current Status:** Placeholder file (337 KB)
- **How to Replace:** Replace with your actual guidance audio file

## Integration in Capture Image Screen

### Changes Made to `capture_image_screen.dart`:

1. **Added Imports:**
   ```dart
   import '../../services/crop_capture_audio_service.dart';
   import '../../widgets/crop_capture_audio_player.dart';
   ```

2. **Added Method:**
   ```dart
   void _showAudioPlayer() {
     final audioService = CropCaptureAudioService();
     
     showDialog(
       context: context,
       builder: (context) => CropCaptureAudioPlayer(audioService: audioService),
     );
   }
   ```

3. **Updated UI Layout:**
   - Camera and Gallery buttons now share a row
   - Audio button (🎧) added next to Camera button in blue color
   - Button opens audio player dialog when tapped
   - Tooltip: "गाइडेंस सुनें (Listen to Guidance)"

## How It Works

### User Flow:
1. Farmer opens crop monitoring > capture image screen
2. Sees camera, gallery, and audio buttons
3. Clicks audio button (🎧) before/while capturing
4. Audio player dialog opens with controls:
   - **Play Button:** Start audio playback
   - **Pause Button:** Pause currently playing audio
   - **Stop Button:** Stop and reset audio
   - **Slider:** Seek to any position in the audio
5. Audio plays to guide farmer on proper crop image capture techniques

### Technical Flow:
```
User clicks 🎧 button
         ↓
_showAudioPlayer() method called
         ↓
CropCaptureAudioService instance created
         ↓
CropCaptureAudioPlayer dialog opens
         ↓
User clicks [Play] button
         ↓
audioService.playAudio() called
         ↓
Loads 'assets/audio/crop_capture_audio.mp3'
         ↓
Audio plays with progress tracking
```

## How to Replace the Audio File

### Step 1: Prepare Your Audio
- Format: MP3
- Sample Rate: 44.1 kHz or higher
- Bitrate: 128-192 kbps
- Duration: Any length
- Max Size: 10 MB recommended

### Step 2: Replace the File
1. Locate your audio file
2. Replace `/workspaces/pmfby-app-master/assets/audio/crop_capture_audio.mp3` with your audio
3. Keep the filename exactly as: `crop_capture_audio.mp3`

### Step 3: Run the App
```bash
cd /workspaces/pmfby-app-master
flutter clean
flutter pub get
flutter run
```

## File Path Reference
The audio file path in code is:
```dart
static const String audioFilePath = 'assets/audio/crop_capture_audio.mp3';
```

**Do not change this path in the code.** Instead, replace the file at the location mentioned above.

## Dependencies Added
- **just_audio: ^0.9.37** - For audio playback functionality

## UI Customization

### Button Styling:
- **Color:** Blue (Colors.blue.shade600)
- **Icon:** 🎧 (Icons.headphones)
- **Size:** 24px
- **Position:** Next to Camera button

### Dialog Styling:
- **Title Color:** Green
- **Control Buttons:** Green (Play), Orange (Pause), Red (Stop)
- **Progress Slider:** Green theme
- **Language:** Hindi + English labels

## Status Display
- **Playing:** "▶️ अभी चल रहा है (Now Playing)" - Green background
- **Stopped:** "⏹️ बंद (Stopped)" - Grey background

## Notes
- Audio file must be in MP3 format
- File must be named exactly: `crop_capture_audio.mp3`
- Location must be: `assets/audio/`
- Update `pubspec.yaml` asset configuration if folder changes
- Service uses ChangeNotifier for reactive updates
- Dialog can be opened multiple times without issues

## Testing Checklist
- [ ] Audio button appears next to Camera button
- [ ] Audio button has blue background color
- [ ] Audio button shows 🎧 icon
- [ ] Clicking button opens audio player dialog
- [ ] Play button plays the audio
- [ ] Pause button pauses the audio
- [ ] Stop button stops and resets the audio
- [ ] Progress slider works and shows duration
- [ ] Status indicator shows correct state
- [ ] Dialog can be closed without errors

## Language Support
- Hindi labels: "फसल की गाइडेंस", "अभी चल रहा है", "बंद करें"
- English labels: "Guidance", "Now Playing", "Stopped"
