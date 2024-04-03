import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:sound_recorder/sound_repository.dart';
import 'package:logger/logger.dart';

class OnDataHandler {
  void onNewMaxDbLevel(double max) {}
  void onNewMeanDbLevel(double mean) {}
}

class MockOnDataHandler extends Mock implements OnDataHandler {}

class MockLogger extends Mock implements Logger {}

void main() {
  late SoundRepository soundRepository;
  late MockLogger logger;

  void onNewMaxDbLevel(double max) {
    logger.i('Peak level changed');
  }

  void onNewMeanDbLevel(double mean) {
    logger.i('Mean level changed');
  }

  setUp(() {
    logger = MockLogger();
    soundRepository = SoundRepository(logger);
  });

  test('onData should update mean and max decibel levels correctly', () {
    // Arrange
    final event = NoiseReading([50.0, 60.0]);
    var dataHandler = MockOnDataHandler();
    soundRepository.onNewMaxDbLevel = dataHandler.onNewMaxDbLevel;
    soundRepository.onNewMeanDbLevel = dataHandler.onNewMaxDbLevel;

    // Act
    soundRepository.onData(event);

    // Assert

    verify(() => dataHandler.onNewMaxDbLevel(_)).called(1);
    /*
    verify(() => logger.i(
            'Mean: ${event.meanDecibel}Last Mean null Max: ${event.maxDecibel}'))
        .called(1);
    verify(() => logger.i('First reading received')).called(1);
    verify(() => logger.i('Peak level changed')).called(1);
    verify(() => logger.i('Mean level changed')).called(1);
    verify(() => logger.i(
            'Mean: ${event.meanDecibel}Last Mean ${event.meanDecibel} Max: ${event.maxDecibel}'))
        .called(1);
        */
  });
}
