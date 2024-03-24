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

class SoundRecorderLevelChange extends SoundRecorderEvent {
  late final double _meanDecibel;
  late final double _peakDecibel;

  SoundRecorderLevelChange(double meanDecibel, double peakDecibel) {
    _meanDecibel = meanDecibel;
    _peakDecibel = peakDecibel;
  }

  double get meanDbLevel => _meanDecibel;
  double get peakDbLevel => _peakDecibel;
}
