import 'package:equatable/equatable.dart';

sealed class SoundRecorderState extends Equatable {
  const SoundRecorderState();

  @override
  List<Object> get props => [];
}


class SoundRecorderInitial extends SoundRecorderState {}

class SoundRecorderRecording extends SoundRecorderState {}

class SoundRecorderStopped extends SoundRecorderState {}
