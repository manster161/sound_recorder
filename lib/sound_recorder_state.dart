import 'dart:ffi';

import 'package:equatable/equatable.dart';

sealed class SoundRecorderState extends Equatable {
   SoundRecorderState();

  @override
  List<Object> get props => [];

  String get recordButtonText => 'Record';
  double get currentDbLevel => 0.0;
  double get peakDbLevel => 0.0;
}


class SoundRecorderInitial extends SoundRecorderState {
  @override
  String get recordButtonText => 'Intial';
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
  final double _currentDbLevel;

  SoundRecorderDbLevelChanged(double val) : _currentDbLevel = val;

  @override
  double get currentDbLevel => _currentDbLevel;
}

class SoundRecorderPeakLevelChanged extends SoundRecorderState {
  final double _peakDbLevel;

  SoundRecorderPeakLevelChanged(double val) : _peakDbLevel = val;

  @override
  double get peakDbLevel => _peakDbLevel;
}
