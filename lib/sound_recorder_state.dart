import 'dart:ffi';

import 'package:equatable/equatable.dart';

sealed class SoundRecorderState extends Equatable {
  const SoundRecorderState();

  @override
  List<Object> get props => [];

  double _currentDbLevel = 0.0;
  double _peakDbLevel = 0.0;

  String get recordButtonText => 'recordnull';
  double get currentDbLevel => _currentDbLevel;
  String get currentDbLevelString => currentDbLevel.toString();
  double get peakDbLevel => _peakDbLevel;
  String get peakDbLevelString => peakDbLevel.toString();

  void SetCurrentDbLevel(double value) {
    _currentDbLevel = value;
  }
  
}


class SoundRecorderInitial extends SoundRecorderState {
  @override
  String get recordButtonText => 'Record';
}

class SoundRecorderRecording extends SoundRecorderState {
  @override
  String get recordButtonText => 'Stop';
  
}

class SoundRecorderStopped extends SoundRecorderState {
  @override
  String get recordButtonText => 'Record';
}
