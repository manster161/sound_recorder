import 'package:bloc/bloc.dart';
import 'package:sound_recorder/sound_recorder_event.dart';
import 'package:sound_recorder/sound_recorder_state.dart';
import 'package:logger/logger.dart';

class SoundRecorderBloc extends Bloc<SoundRecorderEvent, SoundRecorderState> {
  SoundRecorderBloc() : super(SoundRecorderInitial());

  final Logger _logger = Logger();

  bool isRecording = false;
  double currentDbLevel = 0.0;
  double peakDbLevel = 0.0;

  void onButtonPressed() {
    add(SoundRecorderStart());
    _logger.i('onButtonPressed');
  }


  @override
  Stream<SoundRecorderState> mapEventToState(
    SoundRecorderEvent event,
  ) async* {
    if (event is SoundRecorderStart) {
      _logger.i('Recorder Start');
      isRecording = true;
      yield SoundRecorderRecording();
    } else if (event is SoundRecorderStop) {
      isRecording = false;
      _logger.i('Recorder Stop');
      yield SoundRecorderStopped();
    } else if (event is SoundRecorderToggleEvent) {
      if (isRecording) {
        add(SoundRecorderStop());
      } else {
        add(SoundRecorderStart());
      }
      _logger.i('ToggleEvent');
    }
  }
}
