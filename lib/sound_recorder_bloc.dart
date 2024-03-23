import 'package:bloc/bloc.dart';
import 'package:sound_recorder/sound_recorder_event.dart';
import 'package:sound_recorder/sound_recorder_state.dart';


class SoundRecorderBloc extends Bloc<SoundRecorderEvent, SoundRecorderState> {
  SoundRecorderBloc() : super(SoundRecorderInitial());

  @override
  Stream<SoundRecorderState> mapEventToState(
    SoundRecorderEvent event,
  ) async* {
    if (event is SoundRecorderStart) {
      yield SoundRecorderRecording();
    } else if (event is SoundRecorderStop) {
      yield SoundRecorderStopped();
    }
  }
}