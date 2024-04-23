import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_recorder/settings_bloc.dart';
import 'package:sound_recorder/settings_state.dart';
import 'package:sound_recorder/settings_event.dart';
import 'package:sound_recorder/sound_recorder_bloc.dart';
import 'package:sound_recorder/sound_recorder_state.dart';
import 'package:sound_recorder/sound_recorder_event.dart';
import 'package:logger/logger.dart';

class SoundRecorderPage extends StatefulWidget {
  SoundRecorderPage({super.key});

  @override
  _SoundRecorderPageState createState() => _SoundRecorderPageState();
}

class _SoundRecorderPageState extends State<SoundRecorderPage> {
  double _sliderValue = 0.0;

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
                  child: BlocBuilder<SoundRecorderBloc, SoundRecorderState>(
                      builder: (context, state) => Text(
                          'Mean db level: ${state.currentDbLevel.toString()}')),
                ),
              ],
            ),
            Row(
              children: [
                Center(
                  child: BlocBuilder<SoundRecorderBloc, SoundRecorderState>(
                      builder: (context, state) => Text(
                          'Peak db level: ${state.peakDbLevel.toString()}')),
                ),
              ],
            ),
            Row(
              children: [
                Center(
                  child: BlocBuilder<SettingsBloc, SettingsState>(
                    builder: (context, state) => 
                    Slider(
                        value: state.thresholdLevel,
                        min: 0.0,
                        max: 120.0,
                        divisions: 120,
                        onChanged: (value) {
                         // BlocProvider.of<SettingsBloc>(context)
                        //      .add(ThresholdChangeEvent(value));
                        }),
                  ),
                )
              ],
            )
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
                .add(const SoundRecorderToggleEvent(0.0, 0.0)),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
