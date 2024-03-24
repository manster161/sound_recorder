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
      : super(SoundRecorderInitial())
      {
        soundRepository.onNewMaxDbLevel = onNewMaxDbLevel;
        soundRepository.onNewMeanDbLevel = onNewMeanDbLevel;
      }
      
  
  SoundRecorderState get initialState => SoundRecorderInitial();


  bool isRecording = false;

  void startRecording() async {
    Logger().i('Recorder Start');
    soundRepository.startRecording();
  }

  void stopRecording() {
    logger.i('Recorder Stop');
    soundRepository.stopRecording();
  }

  void onNewMaxDbLevel(double val) {
    add(SoundRecorderPeakLevelChange(val));
  }
void onNewMeanDbLevel(double val) {
    add(SoundRecorderDbLevelChange(val));
  }

  @override
  Stream<SoundRecorderState> mapEventToState(
    SoundRecorderEvent event,
  ) async* {
    if (event is SoundRecorderStart) {
      startRecording();
      yield SoundRecorderRecording();
    } else if (event is SoundRecorderStop) {
      stopRecording();
      yield SoundRecorderStopped();
    } else if (event is SoundRecorderToggleEvent) {
      if (isRecording) {
        add(SoundRecorderStop());
      } else {
        add(SoundRecorderStart());
      }
    } else if (event is SoundRecorderDbLevelChange) {
      yield SoundRecorderDbLevelChanged(event.currentDbLevel);
    } else if (event is SoundRecorderPeakLevelChange) {
      yield SoundRecorderPeakLevelChanged(event.peakDbLevel);
    }
  }
}
