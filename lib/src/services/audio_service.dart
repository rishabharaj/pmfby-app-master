import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Audio Service for managing audio playback
/// Handles playing audio files from assets and managing playback state
class AudioService extends ChangeNotifier {
  bool _isPlaying = false;
  String? _currentAudio;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  bool get isPlaying => _isPlaying;
  String? get currentAudio => _currentAudio;
  Duration get currentPosition => _currentPosition;
  Duration get totalDuration => _totalDuration;

  /// Play audio file from assets
  /// Example: playAudio('audio/pmfby_intro_hi.mp3')
  Future<void> playAudio(String assetPath) async {
    try {
      // Load audio from assets
      final audioData = await rootBundle.load(assetPath);
      
      // Simulate playback (in production, use a proper audio player like just_audio or audioplayers)
      _isPlaying = true;
      _currentAudio = assetPath;
      _totalDuration = const Duration(seconds: 30); // Default duration - update based on actual file
      
      notifyListeners();
      
      // Simulate playback completion
      await Future.delayed(const Duration(seconds: 30));
      
      if (_isPlaying) {
        stopAudio();
      }
    } catch (e) {
      debugPrint('Error playing audio: $e');
      _isPlaying = false;
      notifyListeners();
    }
  }

  /// Stop audio playback
  void stopAudio() {
    _isPlaying = false;
    _currentAudio = null;
    _currentPosition = Duration.zero;
    notifyListeners();
  }

  /// Pause audio playback
  void pauseAudio() {
    _isPlaying = false;
    notifyListeners();
  }

  /// Resume audio playback
  void resumeAudio() {
    if (_currentAudio != null) {
      _isPlaying = true;
      notifyListeners();
    }
  }

  /// Get list of available audio files
  /// These should match the audio files in assets/audio/
  static const List<Map<String, String>> availableAudios = [
    {
      'name': 'PMFBY Introduction (Hindi)',
      'file': 'assets/audio/pmfby_intro_hi.mp3',
      'language': 'Hindi',
    },
    {
      'name': 'PMFBY Introduction (English)',
      'file': 'assets/audio/pmfby_intro_en.mp3',
      'language': 'English',
    },
    {
      'name': 'How to File Claim (Hindi)',
      'file': 'assets/audio/how_to_claim_hi.mp3',
      'language': 'Hindi',
    },
    {
      'name': 'How to File Claim (English)',
      'file': 'assets/audio/how_to_claim_en.mp3',
      'language': 'English',
    },
    {
      'name': 'Crop Insurance Tips (Hindi)',
      'file': 'assets/audio/insurance_tips_hi.mp3',
      'language': 'Hindi',
    },
    {
      'name': 'Crop Insurance Tips (English)',
      'file': 'assets/audio/insurance_tips_en.mp3',
      'language': 'English',
    },
  ];

  @override
  void dispose() {
    stopAudio();
    super.dispose();
  }
}
