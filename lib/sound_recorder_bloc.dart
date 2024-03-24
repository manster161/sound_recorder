import 'package:bloc/bloc.dart';
import 'package:sound_recorder/sound_recorder_event.dart';
import 'package:sound_recorder/sound_recorder_state.dart';
import 'package:logger/logger.dart';
import 'dart:async';

import 'package:sound_recorder/sound_repository.dart';

class SoundRecorderBloc extends Bloc<SoundRecorderEvent, SoundRecorderState> {
  final Logger logger;
  final SoundRepository soundRepository;

  SoundRecorderBloc(this.soundRepository, this.logger)
      : super(SoundRecorderInitiated());

  SoundRecorderState get initialState => SoundRecorderInitiated();

  void init(Function onNewMaxDbLevel, Function onNewMeanDbLevel) {
    logger.i('Recorder Init');
    soundRepository.onNewMaxDbLevel = onNewMaxDbLevel;
    soundRepository.onNewMeanDbLevel = onNewMeanDbLevel;
  }

  void startRecording() async {
    logger.i('Recorder Start');
    soundRepository.startRecording();
  }

  void stopRecording() {
    logger.i('Recorder Stop');
    soundRepository.stopRecording();
  }

  void onNewMaxDbLevel(double val) {
    logger.i('Max db level: $val');
    add(SoundRecorderPeakLevelChange(val));
  }

  void onNewMeanDbLevel(double val) {
    logger.i('Mean db level: $val');
    add(SoundRecorderDbLevelChange(val));
  }

  @override
  Stream<SoundRecorderState> mapEventToState(
    SoundRecorderEvent event,
  ) async* {
    if (event is SoundRecorderInitialEvent) {
      init(onNewMaxDbLevel, onNewMeanDbLevel);
      yield SoundRecorderInitiated();
    } else if (event is SoundRecorderStartEvent) {
      startRecording();
      yield SoundRecorderRecording();
    } else if (event is SoundRecorderStopEvent) {
      stopRecording();
      yield SoundRecorderStopped();
    } else if (event is SoundRecorderToggleEvent) {
      if (soundRepository.isRecording) {
        add(SoundRecorderStopEvent());
      } else {
        add(SoundRecorderStartEvent());
      }
    } else if (event is SoundRecorderDbLevelChange) {
      yield SoundRecorderDbLevelChanged(event.currentDbLevel);
    } else if (event is SoundRecorderPeakLevelChange) {
      yield SoundRecorderPeakLevelChanged(event.peakDbLevel);
    }
  }
}

