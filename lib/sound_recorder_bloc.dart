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
      : super(const SoundRecorderInitiated(0.0, 0.0)) {
    soundRepository.onNewMaxDbLevel = onNewMaxDbLevel;
    soundRepository.onNewMeanDbLevel = onNewMaxDbLevel;
  }

  SoundRecorderState get initialState => const SoundRecorderInitiated(0.0, 0.0);

  void onNewMaxDbLevel(double max) {
    add(SoundRecorderPeakLevelChange(soundRepository.latestReading?.meanDecibel ?? 0.0, max));
  }

  void onNewMeanDbLevel(double mean) {
    add(SoundRecorderMeanLevelChange(mean, soundRepository.maxDbLevel));
  }

  void init(Function onNewMaxDbLevel, Function onNewMeanDbLevel) {
    logger.i('Recorder Init');
    soundRepository.onNewMaxDbLevel = onNewMaxDbLevel;
    soundRepository.onNewMeanDbLevel = onNewMeanDbLevel;
  }

  Future startRecording() async {
    await soundRepository.startRecording();
  }

  void stopRecording() {
    soundRepository.stopRecording();
  }

  bool isRecording() {
    return soundRepository.isRecording;
  }

  @override
  Stream<SoundRecorderState> mapEventToState(
    SoundRecorderEvent event,
  ) async* {
    if (event is SoundRecorderInitialEvent) {
      init(onNewMaxDbLevel, onNewMeanDbLevel);
      yield const SoundRecorderInitiated(0.0, 0.0);
    } else if (event is SoundRecorderStartEvent) {
      await startRecording();
      yield SoundRecorderRecording(event.dbLevel, event.peakDbLevel);
    } else if (event is SoundRecorderStopEvent) {
      stopRecording();
      yield SoundRecorderStopped(event.dbLevel, event.peakDbLevel);
    } else if (event is SoundRecorderToggleEvent) {
      if (soundRepository.isRecording) {
        add(SoundRecorderStopEvent(event.dbLevel, event.peakDbLevel));
      } else {
        add(SoundRecorderStartEvent(event.dbLevel, event.peakDbLevel));
      }
    } else if (event is SoundRecorderMeanLevelChange) {
      yield SoundRecorderLevelChanged(event.dbLevel, event.peakDbLevel);
    } else if (event is SoundRecorderPeakLevelChange) {
      yield SoundRecorderPeakDbLevelChanged(event.dbLevel, event.peakDbLevel);
    }
  }
}
