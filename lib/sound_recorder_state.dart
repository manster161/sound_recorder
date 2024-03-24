import 'package:equatable/equatable.dart';

sealed class SoundRecorderState extends Equatable {
  const SoundRecorderState();

  @override
  List<Object> get props => [];

  String get recordButtonText => 'Record';
  double get currentDbLevel => 0.0;
  double get peakDbLevel => 0.0;
}

class SoundRecorderInitiated extends SoundRecorderState {
  @override
  String get recordButtonText => 'Initial';
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

  const SoundRecorderDbLevelChanged(this._currentDbLevel);

  @override
  double get currentDbLevel => _currentDbLevel;
}

class SoundRecorderPeakLevelChanged extends SoundRecorderState {
  final double _peakDbLevel;

  const SoundRecorderPeakLevelChanged(this._peakDbLevel);

  @override
  double get peakDbLevel => _peakDbLevel;
}
