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
  List<AudioInfo> audioList = List.generate(7,
        (index) => AudioInfo("assets/audios/note${index + 1}.mp3",
        false),
  );

  @override
  void initState() {
    super.initState();

    // Load the audio file
    for (var audioInfo in audioList) {
      assetsAudioPlayer.open(Audio(audioInfo.filename));
    }

    // Listen to player state changes
    assetsAudioPlayer.playlistAudioFinished.listen((finished) {
      setState(() {
        for (var audioInfo in audioList) {
          audioInfo.isPlaying = false;
        }
      });
    });
  }

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

  // void togglePlayPause() {
  //   if (isPlaying) {
  //     assetsAudioPlayer.pause();
  //   } else {
  //     assetsAudioPlayer.play();
  //   }
  //
  //   setState(() {
  //     isPlaying = !isPlaying;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
          ),
        ),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            const SizedBox(height: 20),
            for (int i = 0; i < audioList.length; i++)
            ElevatedButton(
              onPressed: audioList[i].isPlaying ? pauseAudio : () => playAudio(i),
              child: Text(audioList[i].isPlaying ? 'Pause' : 'Play Note ${i + 1}'),
            ),
          ]),
        ),
      ),
    );
  }
}
