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
  final double dbLevel;

  const SoundRecorderLevelChange(this.dbLevel);

   @override
  List<Object> get props => [dbLevel];
}

class SoundRecorderMaxLevelChange extends SoundRecorderEvent {
  final double maxDbLevel;

  const SoundRecorderMaxLevelChange(this.maxDbLevel);

   @override
  List<Object> get props => [maxDbLevel];
}
