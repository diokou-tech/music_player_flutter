import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:musik_audiomack/enums/actionMusic.enum.dart';
import 'package:musik_audiomack/models/musique.model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isPlayed;
  late double positionPlay;
  var logger = Logger(
    printer: PrettyPrinter(
      printTime: true,
    ),
  );
  List<Musique> listesMusiques = [
    Musique("Dip Doundou Guiss", "Beut", "assets/images/dip_cover.jpeg",
        "assets/audios/dip-beut-tlk.webm"),
    Musique("Freeze Corleone", "Freeze Rael", "assets/images/dip_cover.jpeg",
        "assets/audios/freeze-rael.webm"),
    Musique(
        "Leys", "Si c'était le premier", "assets/images/dip_cover.jpeg", "assets/audios/leys-si-cetait-le-dernier.webm"),
    Musique("Reptyle Music", "Weet", "assets/images/dip_cover.jpeg",
        "assets/audios/reptyle-music-weet.mp3"),
  ];
  var player = AudioPlayer();
  late Musique _playing;
  @override
  void initState() {
    super.initState();
    positionPlay = 5.0;
    isPlayed = false;
    _playing = listesMusiques[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: const IconThemeData(
          color: Colors.cyan
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Ma Musique",
          style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedItemColor: Colors.white,
        currentIndex: 0,
        elevation: 0.0,
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.deepOrange,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
            color: Colors.deepOrange,
            ),
            label: "Home",  
            ),
          BottomNavigationBarItem(
            tooltip: "Feed",
            icon: Icon(Icons.feed,
            color: Colors.deepOrange,
            ),
            label: "Feed"),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music,
            color: Colors.deepOrange,
            ),
            label: "My Library",
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.music_note,
            color: Colors.deepOrange,
            ),
            label: "Playlist",
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
                elevation: 0.8,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: MediaQuery.of(context).size.height / 2.5,
                    child: Image.asset(
                      _playing.imagePath,
                      fit: BoxFit.fitHeight,
                    ))),
            textWithStyle(_playing.titre, 2, true),
            textWithStyle(_playing.artiste, 1.5, true),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWithStyle("0:0", 1),
                  Expanded(
                    child: Slider(
                      activeColor: Colors.deepOrange,
                      value: positionPlay,
                      onChanged: (value) {
                        setState(() {
                          positionPlay = value;
                        });
                        logger.d("$value playing");
                      },
                      max: 5,
                      min: 0,
                    ),
                  ),
                  textWithStyle("0:22", 1),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                bouton(Icons.fast_rewind, 35, ActionMusic.rewind),
                bouton(isPlayed == true ? Icons.pause : Icons.play_arrow, 35,
                    isPlayed == true ? ActionMusic.pause : ActionMusic.play),
                bouton(Icons.fast_forward, 35, ActionMusic.forward),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text textWithStyle(String data, double scal, [bool isBold = false]) {
    return Text(
      data,
      textAlign: TextAlign.center,
      textScaleFactor: scal,
      style: TextStyle(
        fontFamily: "Cambria",
        color: Colors.cyan,
        fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  IconButton bouton (IconData icone, double taille, ActionMusic actionMusic) {
    return IconButton(
        iconSize: taille,
        color: Colors.deepOrange,
        onPressed: () {
          switch (actionMusic) {
            case ActionMusic.play:
              {
                setState(() {
                  isPlayed = !isPlayed;
                });
                player.setSourceUrl(_playing.urlSong);
                logger.i("play ${_playing.urlSong}");
                break;
              }
            case ActionMusic.pause:
              {
                setState(() {
                  isPlayed = !isPlayed;
                });
                logger.i("pause");
                break;
              }
            case ActionMusic.rewind:
              {
                logger.i("rewind");
                break;
              }
            case ActionMusic.forward:
              {
                logger.i("forward");
                break;
              }
          }
        },
        icon: Icon(icone));
  }
}
