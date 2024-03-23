import 'dart:ui';
import 'package:equatable/equatable.dart';

sealed class SoundRecorderEvent extends Equatable {
  const SoundRecorderEvent();

  @override
  List<Object> get props => [];

  double get _currentDbLevel => 0.0;
  double get _peakDbLevel => 0.0;
}

class SoundRecorderToggleEvent extends SoundRecorderEvent {}

class SoundRecorderStart extends SoundRecorderEvent {}

class SoundRecorderStop extends SoundRecorderEvent {}


class SoundRecorderDbLevelChange extends SoundRecorderEvent {
  
  @override
  double _currentDbLevel = 0.0;

  SoundRecorderDbLevelChange(double currentDbLevel) {
    _currentDbLevel = currentDbLevel;
  }

  double get currentDbLevel => _currentDbLevel;
}

class SoundRecorderPeakLevelChange extends SoundRecorderEvent {
   
   @override
  double _peakDbLevel = 0.0;
  SoundRecorderPeakLevelChange(double peakDbLevel) {
   _peakDbLevel = peakDbLevel;
  }

  double get peakDbLevel => _peakDbLevel;
}

