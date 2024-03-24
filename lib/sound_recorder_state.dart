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

class SoundRecorderLevelChanged extends SoundRecorderState {
  final double _currentDbLevel;
  final double _peakDbLevel;

  const SoundRecorderLevelChanged(this._currentDbLevel, this._peakDbLevel);

  @override
  double get currentDbLevel => _currentDbLevel;
  @override
  double get peakDbLevel => _peakDbLevel;
}

class SoundRecorderPeakDbLevelChanged extends SoundRecorderState {
  final double _peakDbLevel;

  const SoundRecorderPeakDbLevelChanged(this._peakDbLevel);
  @override
  double get peakDbLevel => _peakDbLevel;
}
