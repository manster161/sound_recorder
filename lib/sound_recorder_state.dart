import 'package:equatable/equatable.dart';

sealed class SoundRecorderState extends Equatable {
  const SoundRecorderState(this.currentDbLevel, this.peakDbLevel);

  @override
  List<Object> get props => [recordButtonText, currentDbLevel, peakDbLevel];

  String get recordButtonText => 'Record';
  final double currentDbLevel;
  final double peakDbLevel;
}

class SoundRecorderInitiated extends SoundRecorderState {
  const SoundRecorderInitiated(super.currentDbLevel, super.peakDbLevel);

  @override
  String get recordButtonText => 'Initial';
}

class SoundRecorderRecording extends SoundRecorderState {
  const SoundRecorderRecording(super.currentDbLevel, super.peakDbLevel);

  @override
  String get recordButtonText => 'Stop';
}

class SoundRecorderStopped extends SoundRecorderState {
  const SoundRecorderStopped(super.currentDbLevel, super.peakDbLevel);

  @override
  String get recordButtonText => 'Record';
}

class SoundRecorderLevelChanged extends SoundRecorderState {

  const SoundRecorderLevelChanged(super.currentDbLevel, super.peakDbLevel);
}

class SoundRecorderPeakDbLevelChanged extends SoundRecorderState {
  
 const SoundRecorderPeakDbLevelChanged(super.currentDbLevel, super.peakDbLevel);
}
