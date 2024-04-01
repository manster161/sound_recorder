import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sound_recorder/sound_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sound_recorder/sound_recorder_bloc.dart';
import 'package:sound_recorder/sound_recorder_state.dart';
import 'package:logger/logger.dart';
import 'package:sound_recorder/sound_recorder_event.dart';

class MockSoundRepository extends Mock implements SoundRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockSoundRepository soundRepository;
  late Logger logger;

  setUp(() {
    soundRepository = MockSoundRepository();

    when(() => soundRepository.startRecording()).thenAnswer((_) async {});
    when(() => soundRepository.stopRecording()).thenAnswer((_) {});
    when(() => soundRepository.isRecording).thenAnswer((_) { return true;});

    logger = Logger();
  });

 blocTest('Emits [SoundRecorderInitated] when created',
      build: () {
        return SoundRecorderBloc(soundRepository, logger);
      },
      act: (bloc) => bloc.add(const SoundRecorderInitialEvent(0.0,0.0)),
      expect: () => <SoundRecorderState>[const SoundRecorderInitiated(0.0,0.0)]);

  blocTest('Emits [SoundRecorderRecording] when successful start',
      build: () {
        return SoundRecorderBloc(soundRepository, logger);
      },
      act: (bloc) => bloc.add(const SoundRecorderStartEvent(0.0, 0.0)) ,
      expect: () => <SoundRecorderState>[const SoundRecorderRecording(0.0,0.0)]);

  blocTest('Emits [SoundRecorderStopped] when successful stop',
      build: () {
        return SoundRecorderBloc(soundRepository, logger);
      },
      act: (bloc) => bloc.add(const SoundRecorderStopEvent(0.0,0.0)),
      expect: () => <SoundRecorderState>[const SoundRecorderStopped(0.0,0.0)]);
}
