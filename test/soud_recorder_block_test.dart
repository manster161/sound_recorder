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

    when(() => soundRepository.startRecording()).thenAnswer((_) {});
    when(() => soundRepository.stopRecording()).thenAnswer((_) {});

    logger = Logger();
  });

  test('Initial state is SoundRecorderInitial', () {
    final bloc = SoundRecorderBloc(soundRepository, logger);
    expect(bloc.state, SoundRecorderInitial());  
  });

  test('When starting the recording it emits, initial and recording', () {
    final bloc = SoundRecorderBloc(soundRepository, logger);
    bloc.add(SoundRecorderStart());

    verify(() => soundRepository.startRecording()).called(1);

    emitsInOrder(
      [
        SoundRecorderInitial(),
        SoundRecorderRecording()
      ],
    );
  });

  test('When starting and stopping [SoundRecorderInitial, SoundRecorderRecording, SoundRecorderStopped]', () {
    final bloc = SoundRecorderBloc(soundRepository, logger);
    bloc.add(SoundRecorderStart());
    bloc.add(SoundRecorderStop());

    emitsInOrder(
      [
        SoundRecorderInitial(),
        SoundRecorderRecording(),
        SoundRecorderStopped()
      ],
    );
  });
}
