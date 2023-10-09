import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:record/record.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  late Record audioRecorder;
  late AudioPlayer audioPlayer;
  bool isRecording = false;
  String audioPath = "";
  @override
  void initState() {
    audioRecorder = Record();
    audioPlayer = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    audioRecorder.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecorder.hasPermission()) {
        await audioRecorder.start();
        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      print("Error Starting recording: ${e.toString()}");
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecorder.stop();

      setState(() {
        isRecording = false;
        audioPath = path!;
      });
    } catch (e) {
      print("Error stop recording: ${e.toString()}");
    }
  }

  Future<void> playRecording() async {
    try {
      Source? audioSource = UrlSource(audioPath);
      await audioPlayer.play(audioSource);
    } catch (e) {
      print("Error play recording: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("record voice"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (isRecording)
              const Text(
                "Recording...",
                style: TextStyle(fontSize: 24, color: Colors.red),
              ),
            ElevatedButton(
                onPressed: () async {
                  if (isRecording) {
                    await stopRecording();
                  } else {
                    await startRecording();
                  }
                },
                child: isRecording
                    ? const Text("Stop recording")
                    : const Text("Start recording")),
            if (!isRecording && audioPath.isNotEmpty)
              ElevatedButton(
                  onPressed: playRecording,
                  child: const Text("Play recording")),
          ],
        ),
      ),
    );
  }
}
