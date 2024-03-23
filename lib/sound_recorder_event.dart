import 'dart:ui';
import 'package:equatable/equatable.dart';

sealed class SoundRecorderEvent extends Equatable {
  const SoundRecorderEvent();

  @override
  List<Object> get props => [];
}

class SoundRecorderToggleEvent extends SoundRecorderEvent {}

class SoundRecorderStart extends SoundRecorderEvent {}

class SoundRecorderStop extends SoundRecorderEvent {}



