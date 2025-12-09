import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/audio_service.dart';

/// Audio Player Dialog Widget
/// Displays available audio files in a modal bottom sheet
class AudioPlayerDialog extends StatefulWidget {
  final AudioService audioService;

  const AudioPlayerDialog({
    super.key,
    required this.audioService,
  });

  @override
  State<AudioPlayerDialog> createState() => _AudioPlayerDialogState();
}

class _AudioPlayerDialogState extends State<AudioPlayerDialog> {
  String? _selectedAudio;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade700, Colors.green.shade600],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '🎵 Audio Help Guide',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white),
                      splashRadius: 24,
                    ),
                  ],
                ),
                Text(
                  'Listen to PMFBY guidance in your preferred language',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          // Audio List
          Expanded(
            child: ListView.builder(
              itemCount: AudioService.availableAudios.length,
              itemBuilder: (context, index) {
                final audio = AudioService.availableAudios[index];
                final isPlaying = widget.audioService.isPlaying &&
                    widget.audioService.currentAudio == audio['file'];

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isPlaying
                          ? Colors.green.shade700
                          : Colors.grey.shade300,
                      width: isPlaying ? 2 : 1,
                    ),
                    color: isPlaying
                        ? Colors.green.shade50
                        : Colors.grey.shade50,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.music_note,
                        color: Colors.green.shade700,
                        size: 24,
                      ),
                    ),
                    title: Text(
                      audio['name'] ?? '',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    subtitle: Text(
                      audio['language'] ?? '',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    trailing: isPlaying
                        ? SizedBox(
                            width: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      widget.audioService.stopAudio(),
                                  icon: const Icon(
                                    Icons.stop_circle,
                                    color: Colors.red,
                                    size: 28,
                                  ),
                                  splashRadius: 20,
                                ),
                              ],
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              widget.audioService.playAudio(audio['file']!);
                              setState(() => _selectedAudio = audio['file']);
                            },
                            icon: Icon(
                              Icons.play_circle_fill,
                              color: Colors.green.shade700,
                              size: 28,
                            ),
                            splashRadius: 20,
                          ),
                    onTap: !isPlaying
                        ? () {
                            widget.audioService.playAudio(audio['file']!);
                            setState(() => _selectedAudio = audio['file']);
                          }
                        : null,
                  ),
                );
              },
            ),
          ),
          // Playing Now Indicator
          if (widget.audioService.isPlaying)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                border: Border(
                  top: BorderSide(
                    color: Colors.green.shade300,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.volume_up,
                        color: Colors.green.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Now Playing',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Colors.green.shade700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: widget.audioService.totalDuration.inSeconds > 0
                          ? widget.audioService.currentPosition.inSeconds /
                              widget.audioService.totalDuration.inSeconds
                          : 0,
                      minHeight: 4,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.green.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
