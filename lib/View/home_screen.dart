import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:media_player/Repo/AudioInfo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  List<AudioInfo> audioList = List.generate(
    7,
    (index) => AudioInfo("assets/audios/note${index + 1}.mp3", false),
  );

  @override
  void playAudio(int index) {
    assetsAudioPlayer.stop();
    assetsAudioPlayer.open(Audio(audioList[index].filename));
    assetsAudioPlayer.play();
    setState(() {
      for (var audioInfo in audioList) {
        audioInfo.isPlaying = false;
      }
      audioList[index].isPlaying = true;
    });
  }

  void pauseAudio() {
    assetsAudioPlayer.pause();
    setState(() {
      for (var audioInfo in audioList) {
        audioInfo.isPlaying = false;
      }
    });
  }

  final List<Color> rainbowColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: Column(
            children: List.generate(
              audioList.length,
              (index) => Expanded(
                child: GestureDetector(
                  onTap: () => audioList[index].isPlaying
                      ? pauseAudio()
                      : playAudio(index),
                  child: Container(
                    color: rainbowColors[index % rainbowColors.length],
                    child: Center(
                      child: ElevatedButton(
                          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.transparent)),

                              onPressed: audioList[index].isPlaying
                            ? pauseAudio
                            : () => playAudio(index),
                        child: Icon(
                          audioList[index].isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: rainbowColors[index % rainbowColors.length],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
