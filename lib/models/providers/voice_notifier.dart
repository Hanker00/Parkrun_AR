import 'package:flutter/material.dart';

class VoiceNotifier extends ChangeNotifier {
  bool _voiceOn = true;
  bool get voiceOn => _voiceOn;

  VoiceNotifier(this._voiceOn);

  void toggleVoice() {
    _voiceOn = !voiceOn;
    notifyListeners();
  }
}
