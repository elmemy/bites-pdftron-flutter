import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceRecorder {
  FlutterSoundRecorder? _recorder;
  bool _isRecorderInitialized = false;

  Future<void> initRecorder() async {
    _recorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    await _recorder!.openRecorder();
    _isRecorderInitialized = true;
  }

  Future<void> startRecording(String path) async {
    if (!_isRecorderInitialized) return;
    await _recorder!.startRecorder(toFile: path);
  }

  Future<void> stopRecording() async {
    if (!_isRecorderInitialized) return;
    await _recorder!.stopRecorder();
  }

  void dispose() {
    if (!_isRecorderInitialized) return;
    _recorder!.closeRecorder();
    _isRecorderInitialized = false;
  }
}
