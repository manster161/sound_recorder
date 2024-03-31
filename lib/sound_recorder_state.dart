import 'package:equatable/equatable.dart';

sealed class SoundRecorderState extends Equatable {
  const SoundRecorderState();

  @override
  List<Object> get props => [recordButtonText, currentDbLevel, peakDbLevel];

  String get recordButtonText => 'Record';
  final double currentDbLevel = 0.0;
  final double peakDbLevel = 0.0;
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
  @override
  final double currentDbLevel;

  const SoundRecorderLevelChanged(this.currentDbLevel);
}

class SoundRecorderPeakDbLevelChanged extends SoundRecorderState {
  @override
  final double peakDbLevel;
  const SoundRecorderPeakDbLevelChanged(this.peakDbLevel);
}
