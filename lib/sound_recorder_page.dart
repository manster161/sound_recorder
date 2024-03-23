import 'package:flutter/material.dart';

class SoundRecorderPage extends StatelessWidget {
  const SoundRecorderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sound Recorder'),
      ),
      body: Center(
        child: Text(
          'Sound Recorder',
        ),
      ),
    );
  }
}