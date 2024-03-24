
import 'package:equatable/equatable.dart';

sealed class SoundRecorderEvent extends Equatable {
  const SoundRecorderEvent();

  @override
  List<Object> get props => [];

 // double get _currentDbLevel => 0.0;
  
//double get _peakDbLevel => 0.0;
}

class SoundRecorderToggleEvent extends SoundRecorderEvent {}

class SoundRecorderStart extends SoundRecorderEvent {}

class SoundRecorderStop extends SoundRecorderEvent {}


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

