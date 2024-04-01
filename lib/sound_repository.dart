import 'dart:async';

import 'package:logger/logger.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:permission_handler/permission_handler.dart';

class SoundRepository {
  late final Logger logger;

  NoiseReading? get latestReading => _latestReading;

  NoiseReading? _latestReading;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  NoiseMeter? noiseMeter;
  double maxDbLevel = 0.0;

  bool isRecording = false;
  late Function onNewMaxDbLevel;
  late Function onNewMeanDbLevel;

  SoundRepository(this.logger);

  Future<bool> checkPermission() async => await Permission.microphone.isGranted;

  Future<void> requestPermission() async =>
      await Permission.microphone.request();

  Future startRecording() async {
    logger.i('Recorder Start');

    if (isRecording) {
      logger.i('Already started');
      return;
    }

    if (await checkPermission()) {
      isRecording = true;
      noiseMeter ??= NoiseMeter();
      _noiseSubscription = noiseMeter?.noise.listen(onData, onError: onError);
    } else {
      logger.i('Requesting permission');
      await requestPermission();
    }
  }

  void stopRecording() {
    logger.i('Recorder Stop');

    if (!isRecording) {
      logger.i('Already stopped');
      return;
    }

    isRecording = false;
    _noiseSubscription?.cancel(); 
    _noiseSubscription = null;
    noiseMeter = null;
    _latestReading = null;
  }

  void reset() {
    _latestReading = null;
    onNewMaxDbLevel(0.0);
  }

  void onError(Object error) {
    maxDbLevel = 0.0;
    logger.e('Error: $error');
  }


  void onData(NoiseReading event) {
    logger.i('Mean: ${event.meanDecibel}Last Mean ${_latestReading?.meanDecibel} Max: ${event.maxDecibel}');
    if (_latestReading == null) {
      logger.i('First reading received');
      onNewMeanDbLevel(event.meanDecibel);
      onNewMaxDbLevel(event.maxDecibel);
    } else {
      if (event.meanDecibel != _latestReading!.meanDecibel) {
        logger.i('Mean level changed');
        onNewMeanDbLevel(event.meanDecibel);
      }
      if (event.maxDecibel > maxDbLevel) {
        maxDbLevel = event.maxDecibel;
        logger.i('Peak level changed');
        onNewMaxDbLevel(maxDbLevel);
      }
    }
    _latestReading = event;
  }
}
