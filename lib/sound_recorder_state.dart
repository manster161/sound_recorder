import 'dart:ffi';

import 'package:equatable/equatable.dart';

sealed class SoundRecorderState extends Equatable {
   SoundRecorderState();

  @override
  List<Object> get props => [];

  String get recordButtonText => 'Record';
  double get currentDbLevel => 0.0;
  double get peakDbLevel => 0.0;
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
