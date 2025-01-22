import 'package:audioplayers/audioplayers.dart';
import 'package:breathin/core/logger_customizations/custom_logger.dart';
import 'package:breathin/core/services/auth_services.dart';
import 'package:breathin/core/services/database_service.dart';
import 'package:breathin/core/view_models/base_view_model.dart';
import 'package:breathin/locator.dart';

class BottomNavigationViewModel extends BaseViewModel {
  final log = CustomLogger(className: 'HomeViewModel');
  final auth = locator<AuthServices>();
  final database = locator<DataBaseService>();
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentlyPlaying;

  // List of sound files
  final List<String> soundFiles = [
    "assets/sound/trek_listening_1.mp3",
    "assets/sound/trek_listening_2.mp3",
    "assets/sound/trek_listening_3.mp3",
  ];

  String? get currentlyPlaying => _currentlyPlaying;

  Future<void> playAudio(String assetPath) async {
    if (_currentlyPlaying == assetPath) {
      await _audioPlayer.stop();
      _currentlyPlaying = null;
    } else {
      await _audioPlayer.stop();
      await _audioPlayer
          .play(AssetSource(assetPath.replaceFirst("assets/", "")));
      _currentlyPlaying = assetPath;
    }
    notifyListeners();
  }

  void stopAudio() async {
    await _audioPlayer.stop();
    _currentlyPlaying = null;
    notifyListeners();
  }
}
