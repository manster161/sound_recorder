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
 
  Future<bool> checkPermission() async => await Permission.microphone.isGranted;
  Future<void> requestPermission() async =>
      await Permission.microphone.request();

  void onData(NoiseReading event) {
     _logger.d('On data called. Mean: ${event.meanDecibel}');
    if(_latestReading == null){
      add(SoundRecorderDbLevelChange(event.meanDecibel));
      add(SoundRecorderPeakLevelChange(event.maxDecibel));
    }
    else{
      if(event.meanDecibel != _latestReading!.meanDecibel){
        add(SoundRecorderDbLevelChange(event.meanDecibel));
      }
      if(event.maxDecibel < _latestReading!.maxDecibel){
        _logger.i('Peak level changed');
        add(SoundRecorderPeakLevelChange(event.maxDecibel));
      }
    }

    _latestReading = event;
  }

  void startRecording() async {
    Logger().i('Recorder Start');
    
    if (await checkPermission()) {
        isRecording = true;
        noiseMeter ??= NoiseMeter();
        _noiseSubscription = noiseMeter?.noise.listen(onData, onError: onError);
      } else 
      {
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
    if (event is SoundRecorderStart) 
    {
      startRecording();
      yield SoundRecorderRecording();
    } 
    else if (event is SoundRecorderStop) 
    {
      stopRecording();
      yield SoundRecorderStopped();
    } 
    else if (event is SoundRecorderToggleEvent) 
    {
      if (isRecording) 
      {
        add(SoundRecorderStop());
      } 
      else 
      {
        add(SoundRecorderStart());
      }
    } 
    else if (event is SoundRecorderDbLevelChange) 
    {
      yield SoundRecorderDbLevelChanged(event.currentDbLevel);
    } 
    else if (event is SoundRecorderPeakLevelChange) 
    {
      yield SoundRecorderPeakLevelChanged(event.peakDbLevel);
    }
  }
}
