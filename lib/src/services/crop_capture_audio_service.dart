import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;

/// Simple Audio Service - Play/Stop Toggle
/// Just click to play, click again to stop
class CropCaptureAudioService extends ChangeNotifier {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  static const String audioFilePath = 'assets/audio/crop_capture_audio.mp3';

  bool get isPlaying => _isPlaying;

  CropCaptureAudioService() {
    _audioPlayer = AudioPlayer();
    _setupListeners();
  }

  void _setupListeners() {
    _audioPlayer.playerStateStream.listen((playerState) {
      _isPlaying = playerState.playing;
      notifyListeners();
    });
  }

  /// Request audio permissions
  Future<bool> _requestPermissions() async {
    try {
      if (Platform.isAndroid) {
        // Request storage permissions for Android
        final storageStatus = await Permission.storage.request();
        final mediaStatus = await Permission.audio.request();
        
        debugPrint('Storage Permission: $storageStatus');
        debugPrint('Audio Permission: $mediaStatus');
        
        return storageStatus.isGranted || mediaStatus.isGranted;
      } else if (Platform.isIOS) {
        // Request microphone permission for iOS
        final status = await Permission.microphone.request();
        debugPrint('Microphone Permission: $status');
        return status.isGranted;
      }
      return true;
    } catch (e) {
      debugPrint('❌ Error requesting permissions: $e');
      return false;
    }
  }

  /// Toggle: Click to play, click again to stop
  Future<void> toggleAudio() async {
    try {
      if (_isPlaying) {
        // Stop if playing
        await _audioPlayer.stop();
        _isPlaying = false;
        debugPrint('⏹️ Audio stopped');
      } else {
        // Request permissions before playing
        final hasPermission = await _requestPermissions();
        
        if (!hasPermission) {
          debugPrint('❌ Audio permission not granted');
          _isPlaying = false;
          notifyListeners();
          throw Exception('Audio permission required');
        }
        
        // Play if stopped
        await _audioPlayer.setAsset(audioFilePath);
        await _audioPlayer.play();
        _isPlaying = true;
        debugPrint('▶️ Audio playing from: $audioFilePath');
      }
      notifyListeners();
    } catch (e) {
      debugPrint('❌ Error toggling audio: $e');
      _isPlaying = false;
      notifyListeners();
      rethrow;
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
