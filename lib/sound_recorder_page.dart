import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_recorder/sound_recorder_bloc.dart';
import 'package:sound_recorder/sound_recorder_state.dart';
import 'package:sound_recorder/sound_recorder_event.dart';
import 'package:logger/logger.dart';

class SoundRecorderPage extends StatelessWidget {
  SoundRecorderPage({super.key});

  final Logger _logger = Logger(level: Level.info);

  void onPressed() {
    _logger.i('Setting pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sound Recorder'),
      ),
      body: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Center(
                      child:
                      BlocBuilder<SoundRecorderBloc, SoundRecorderState>(
                          builder: (context, state)  => 
                               Text('Mean db level: ${state.currentDbLevel.toString()}')
                          )),
                ],
              ),
              Row(
                children: [
                  Center(
                      child: 
                      BlocBuilder<SoundRecorderBloc, SoundRecorderState>(
                          builder: (context, state) => 
                              Text('Peak db level: ${state.peakDbLevel.toString()}')
                          )),
                ],
              ),
            ],
          ),
        ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
              child: BlocBuilder<SoundRecorderBloc, SoundRecorderState>(
                builder: (context, state) => Text(state.recordButtonText),
              ),
              onPressed: () => BlocProvider.of<SoundRecorderBloc>(context)
                  .add(const SoundRecorderToggleEvent(0.0, 0.0))),
          const SizedBox(height: 4),
          FloatingActionButton(
              child: const Text('Settings'), onPressed: () => onPressed()),
        ],
      ),
    );
  }
}
