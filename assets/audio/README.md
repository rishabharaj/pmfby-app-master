# 🎵 Audio Files Directory

This directory contains audio help guides for the PMFBY Farmer Dashboard.

## 📁 Audio Files to Add

The following audio files should be placed in this directory:

### 1. **PMFBY Introduction (Hindi)**
- **File:** `pmfby_intro_hi.mp3`
- **Description:** Introduction to Pradhan Mantri Fasal Bima Yojana in Hindi
- **Duration:** ~2-3 minutes recommended

### 2. **PMFBY Introduction (English)**
- **File:** `pmfby_intro_en.mp3`
- **Description:** Introduction to Pradhan Mantri Fasal Bima Yojana in English
- **Duration:** ~2-3 minutes recommended

### 3. **How to File Claim (Hindi)**
- **File:** `how_to_claim_hi.mp3`
- **Description:** Step-by-step guide to file a crop insurance claim in Hindi
- **Duration:** ~3-4 minutes recommended

### 4. **How to File Claim (English)**
- **File:** `how_to_claim_en.mp3`
- **Description:** Step-by-step guide to file a crop insurance claim in English
- **Duration:** ~3-4 minutes recommended

### 5. **Crop Insurance Tips (Hindi)**
- **File:** `insurance_tips_hi.mp3`
- **Description:** Tips for maximizing crop insurance benefits in Hindi
- **Duration:** ~2-3 minutes recommended

### 6. **Crop Insurance Tips (English)**
- **File:** `insurance_tips_en.mp3`
- **Description:** Tips for maximizing crop insurance benefits in English
- **Duration:** ~2-3 minutes recommended

## 🎤 How to Record Audio Files

### Option 1: Use Your Phone
1. Download a voice recording app (e.g., Voice Memo, Google Recorder)
2. Record your audio content
3. Export as MP3
4. Add to this directory

### Option 2: Use Online Tools
- **Audacity** (Free, Open Source): https://www.audacityteam.org/
- **Voice.ai**: https://voice.ai/
- **Google Text-to-Speech**: https://translate.google.com/ (with download option)

### Option 3: Professional Recording
- Hire a professional voice artist
- Use a recording studio
- Ensure clear audio quality (44.1kHz, 128-192 kbps)

## 📋 Audio Format Requirements

- **Format:** MP3 or WAV
- **Sample Rate:** 44.1 kHz or higher
- **Bitrate:** 128-192 kbps (MP3)
- **Channels:** Mono or Stereo
- **Size:** Keep under 10MB per file for optimal performance

## 🔗 How Audio Files Are Linked

The audio files are automatically linked to the audio button in the Farmer Dashboard:

1. **Location:** Top-right corner of the Dashboard home page
2. **Button:** Headset icon (🎧)
3. **Interface:** Bottom sheet modal with audio list
4. **Playback:** Click any audio to play

### Code Reference:
- **Audio Service:** `lib/src/services/audio_service.dart`
- **Audio Player Dialog:** `lib/src/widgets/audio_player_dialog.dart`
- **Dashboard Integration:** `lib/src/features/dashboard/presentation/dashboard_screen.dart`

## ✅ Testing Audio Playback

After adding audio files:

1. Run the Flutter app: `flutter run`
2. Navigate to the Farmer Dashboard
3. Click the 🎧 icon in the top-right corner
4. Select an audio file to play
5. Verify audio plays correctly

## 🛠️ Customization

To add more audio files or change existing ones:

1. **Add new audio** to this directory
2. **Update the list** in `audio_service.dart`:
   ```dart
   static const List<Map<String, String>> availableAudios = [
     {
       'name': 'Your Audio Name',
       'file': 'assets/audio/your_file.mp3',
       'language': 'Your Language',
     },
     // ... add more
   ];
   ```

3. **Rebuild the app** to include the new audio files

## 📝 Notes

- Audio files are embedded in the app APK/IPA
- Ensure all audio files are in this directory
- Use clear, professional-quality recordings
- Test audio playback on both Android and iOS devices
- Consider accessibility: provide clear audio content for farmers

---

**Need help?** Check the main project documentation or contact the development team.
