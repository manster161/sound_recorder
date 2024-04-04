import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_recorder/settings_bloc.dart';
import 'package:sound_recorder/settings_state.dart';
import 'package:sound_recorder/settings_event.dart';
import 'package:sound_recorder/sound_recorder_bloc.dart';
import 'package:sound_recorder/sound_recorder_state.dart';
import 'package:sound_recorder/sound_recorder_event.dart';
import 'package:logger/logger.dart';

class SoundRecorderPage extends StatelessWidget {
  SoundRecorderPage({super.key});

  final Logger _logger = Logger(level: Level.info);

  void onPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Settings'),
          content: const Text('This is the settings dialog.'),
          actions: <Widget>[
            Column(
              children: [
                BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, state) => 
                    Text('Threshold level: ${state.thresholdLevel.toString()}')
                ),
                 TextField(
                  decoration: const InputDecoration (
                    border: OutlineInputBorder(),
                    labelText: 'Enter dB threshold',
                    ),
                    onChanged: (value) {
                      BlocProvider.of<SettingsBloc>(context)
                        .add(ThresholdChangeEvent(double.parse(value)));
                    },
                ),
                TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )],
            )
            ,
          ],
        );
      },
    );
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
                  child: BlocBuilder<SoundRecorderBloc, SoundRecorderState>(
                    builder: (context, state) => 
                      Text('Mean db level: ${state.currentDbLevel.toString()}')
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Center(
                  child: BlocBuilder<SoundRecorderBloc, SoundRecorderState>(
                    builder: (context, state) => 
                      Text('Peak db level: ${state.peakDbLevel.toString()}')
                  ),
                ),
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
              .add(const SoundRecorderToggleEvent(0.0, 0.0)),
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            child: const Text('Settings'),
            onPressed: () => onPressed(context),
          ),
        ],
      ),
    );
  }
}
