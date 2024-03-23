import 'dart:ffi';

import 'package:equatable/equatable.dart';

sealed class SoundRecorderState extends Equatable {
   SoundRecorderState();

  @override
  List<Object> get props => [];

  double _currentDbLevel = 0.0;
  double _peakDbLevel = 0.0;

  String get recordButtonText => 'Record';
  double get currentDbLevel => _currentDbLevel;
  double get peakDbLevel => _peakDbLevel;
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


class SoundRecorderDbLevelChanged extends SoundRecorderState {
  SoundRecorderDbLevelChanged(double currentDbLevel) {
    _currentDbLevel = currentDbLevel;
  }
}

class SoundRecorderPeakLevelChanged extends SoundRecorderState {
  SoundRecorderPeakLevelChanged(double peakDbLevel) {
   _peakDbLevel = peakDbLevel;
  }
}