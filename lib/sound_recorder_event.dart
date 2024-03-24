import 'package:equatable/equatable.dart';

sealed class SoundRecorderEvent extends Equatable {
  const SoundRecorderEvent();

  @override
  List<Object> get props => [];
}

class SoundRecorderInitialEvent extends SoundRecorderEvent {}

class SoundRecorderToggleEvent extends SoundRecorderEvent {}

class SoundRecorderStartEvent extends SoundRecorderEvent {}

class SoundRecorderStopEvent extends SoundRecorderEvent {}

class SoundRecorderDbLevelChange extends SoundRecorderEvent {
  late final double _currentDbLevel;

  SoundRecorderDbLevelChange(double currentDbLevel) {
    _currentDbLevel = currentDbLevel;
  }

  double get currentDbLevel => _currentDbLevel;
}

class SoundRecorderPeakLevelChange extends SoundRecorderEvent {
  late final double _peakDbLevel;
  SoundRecorderPeakLevelChange(double peakDbLevel) {
    _peakDbLevel = peakDbLevel;
  }

  double get peakDbLevel => _peakDbLevel;
}
