import 'package:bloc/bloc.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:sound_recorder/sound_recorder_event.dart';
import 'package:sound_recorder/sound_recorder_state.dart';
import 'package:logger/logger.dart';
import 'dart:async';

import 'package:sound_recorder/sound_repository.dart';

class SoundRecorderBloc extends Bloc<SoundRecorderEvent, SoundRecorderState> {
  final Logger logger;
  final SoundRepository soundRepository;

  SoundRecorderBloc(this.soundRepository, this.logger)
      : super(SoundRecorderInitiated()) {
    soundRepository.onNewMaxDbLevel = onNewMaxDbLevel;
    soundRepository.onNewMeanDbLevel = onNewMaxDbLevel;
  }

  SoundRecorderState get initialState => SoundRecorderInitiated();

  void onNewMaxDbLevel(NoiseReading reading) {
    add(SoundRecorderLevelChange(reading.meanDecibel, reading.maxDecibel));
  }

  void onNewMeanDbLevel(NoiseReading reading) {
    add(SoundRecorderLevelChange(
        reading.meanDecibel, soundRepository.maxDbLevel));
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
      yield SoundRecorderInitiated();
    } else if (event is SoundRecorderStartEvent) {
      await startRecording();
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
    } else if (event is SoundRecorderLevelChange) {
      yield SoundRecorderLevelChanged(event.meanDbLevel, event.peakDbLevel);
    }
  }
}
