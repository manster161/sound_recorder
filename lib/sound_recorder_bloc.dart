import 'package:bloc/bloc.dart';
import 'package:sound_recorder/sound_recorder_event.dart';
import 'package:sound_recorder/sound_recorder_state.dart';
import 'package:logger/logger.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

class SoundRecorderBloc extends Bloc<SoundRecorderEvent, SoundRecorderState> {
  SoundRecorderBloc() : super(SoundRecorderInitial());

  final Logger _logger = Logger();

  NoiseReading? _latestReading;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  NoiseMeter? noiseMeter;

  bool isRecording = false;
  double currentDbLevel = 0.0;
  double peakDbLevel = 0.0;

  Future<bool> checkPermission() async => await Permission.microphone.isGranted;
  Future<void> requestPermission() async =>
      await Permission.microphone.request();

  void onButtonPressed() {
    add(SoundRecorderStart());
    _logger.i('onButtonPressed');
  }

  void onData(NoiseReading event) {
    _latestReading = event;
    currentDbLevel = event.meanDecibel;
    peakDbLevel = event.maxDecibel;

    Logger().i(' Noise Level: $currentDbLevel');
    add(SoundRecorderDbLevelChanged(currentDbLevel));
    add(SoundRecorderPeakLevelChanged(peakDbLevel));
  }

 
  void startRecording() async {
    Logger().i('Recorder Start');
    
    if (await checkPermission()) {
        Logger().i('Permission check done');
        noiseMeter ??= NoiseMeter();
        _noiseSubscription = noiseMeter?.noise.listen((event) => onData(event));
        isRecording = true;
      } else {
       Logger().i('Requesting permission');
      await requestPermission();
    }
  }

  void stopRecording() {
    _noiseSubscription?.cancel();
    isRecording = false;
      _logger.i('Recorder Stop');
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
    }
  }
}
