import 'package:equatable/equatable.dart';

sealed class SoundRecorderEvent extends Equatable {
  const SoundRecorderEvent(this.dbLevel, this.peakDbLevel);

  @override
  List<Object> get props => [dbLevel, peakDbLevel];

  final double dbLevel;
  final double peakDbLevel;

}

class SoundRecorderInitialEvent extends SoundRecorderEvent {
  const SoundRecorderInitialEvent(super.dbLevel, super.peakDbLevel);
}

class SoundRecorderToggleEvent extends SoundRecorderEvent {
  const SoundRecorderToggleEvent(super.dbLevel, super.peakDbLevel);
}

class SoundRecorderStartEvent extends SoundRecorderEvent {
  const SoundRecorderStartEvent(super.dbLevel, super.peakDbLevel);
}

class SoundRecorderStopEvent extends SoundRecorderEvent {
  const SoundRecorderStopEvent(super.dbLevel, super.peakDbLevel);
}

class SoundRecorderMeanLevelChange extends SoundRecorderEvent {
  const SoundRecorderMeanLevelChange(super.dbLevel, super.peakDbLevel);
}

class SoundRecorderPeakLevelChange extends SoundRecorderEvent {
  const SoundRecorderPeakLevelChange(super.dbLevel, super.peakDbLevel);
}
