import 'package:equatable/equatable.dart';

sealed class SoundRecorderState extends Equatable {
  const SoundRecorderState();

  @override
  List<Object> get props => [];

  String get recordButtonText => 'recordnull';
}


class SoundRecorderInitial extends SoundRecorderState {
  @override
  String get recordButtonText => 'Record';
}

class SoundRecorderRecording extends SoundRecorderState {
  @override
  String get recordButtonText => 'Stop';
}

class SoundRecorderStopped extends SoundRecorderState {
  @override
  String get recordButtonText => 'Record';
}
