import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

/// Audio Service for Crop Capture Screen
/// Plays guidance audio file for farmer during crop image capture
class CropCaptureAudioService extends ChangeNotifier {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  // Path to the audio file
  static const String audioFilePath = 'assets/audio/crop_capture_audio.mp3';

  bool get isPlaying => _isPlaying;
  Duration get duration => _duration;
  Duration get position => _position;
  
  double get progress => _duration.inMilliseconds > 0
      ? _position.inMilliseconds / _duration.inMilliseconds
      : 0.0;

  CropCaptureAudioService() {
    _audioPlayer = AudioPlayer();
    _setupListeners();
  }

  void _setupListeners() {
    _audioPlayer.playerStateStream.listen((playerState) {
      _isPlaying = playerState.playing;
      notifyListeners();
    });

    _audioPlayer.durationStream.listen((duration) {
      _duration = duration ?? Duration.zero;
      notifyListeners();
    });

    _audioPlayer.positionStream.listen((position) {
      _position = position;
      notifyListeners();
    });
  }

  Future<void> playAudio() async {
    try {
      if (_audioPlayer.playing) {
        await _audioPlayer.pause();
      } else {
        // Try to resume if paused
        if (_duration == Duration.zero) {
          // File not loaded yet, load it first
          await _audioPlayer.setAsset(audioFilePath);
        }
        await _audioPlayer.play();
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error playing audio: $e');
      rethrow;
    }
  }

  Future<void> pauseAudio() async {
    try {
      await _audioPlayer.pause();
      notifyListeners();
    } catch (e) {
      debugPrint('Error pausing audio: $e');
    }
  }

  Future<void> stopAudio() async {
    try {
      await _audioPlayer.stop();
      _position = Duration.zero;
      notifyListeners();
    } catch (e) {
      debugPrint('Error stopping audio: $e');
    }
  }

  Future<void> seekToPosition(Duration position) async {
    try {
      await _audioPlayer.seek(position);
    } catch (e) {
      debugPrint('Error seeking: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  String get durationText => _formatDuration(_duration);
  String get positionText => _formatDuration(_position);
}
