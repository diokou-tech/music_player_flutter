import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:musik_audiomack/datas/faker.dart';
import 'package:musik_audiomack/enums/actionMusic.enum.dart';
import 'package:musik_audiomack/models/musique.model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isPlayed;
  late Duration positionPlay;
  var logger = Logger(
    printer: PrettyPrinter(
      printTime: true,
    ),
  );
  late AudioPlayer player;
  late Musique _playing;
  late double currentVolume;
  late int currentMusiqueIndex;
  List<Musique> listesMusiques = Faker.getMusiques();
  @override
  void initState() {
    super.initState();
    configurePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: const IconThemeData(color: Colors.cyan),
        iconTheme: const IconThemeData(color: Colors.cyan),
        title: const Text(
          "Ma Musique",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        // showSelectedLabels: false,
        selectedItemColor: Colors.cyan,
        currentIndex: 0,
        elevation: 0.0,
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.cyan,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.cyan,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
              tooltip: "Feed",
              icon: Icon(
                Icons.feed,
                color: Colors.cyan,
              ),
              label: "Feed"),
          BottomNavigationBarItem(
              tooltip: "search",
              icon: Icon(
                Icons.search,
                color: Colors.cyan,
              ),
              label: "Feed"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_music,
              color: Colors.cyan,
            ),
            label: "My Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.music_note,
              color: Colors.cyan,
            ),
            label: "Playlist",
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                  elevation: 0.8,
                  child: Container(
                      padding: const EdgeInsets.all(3),
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
                        inactiveColor: Colors.cyan,
                        value: positionPlay.inSeconds.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            positionPlay = Duration(seconds: value.toInt());
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  bouton(Icons.volume_down, 30, ActionMusic.volumeDown),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      bouton(Icons.fast_rewind, 35, ActionMusic.rewind),
                      bouton(
                          isPlayed == true ? Icons.pause : Icons.play_arrow,
                          35,
                          isPlayed == true
                              ? ActionMusic.pause
                              : ActionMusic.play),
                      bouton(Icons.fast_forward, 35, ActionMusic.forward),
                    ],
                  ),
                  bouton(Icons.volume_up, 30, ActionMusic.volumeUp),
                ],
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: Image.asset(
                            _playing.imagePath,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        textWithStyle(_playing.artiste, 1.2, true),
                      ],
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                        alignment: Alignment.center,
                      ),
                    onPressed: (){},
                    child: textWithStyle("Suivre", 1)) 
                                  ],
                                ),
                  ))
            ],
          ),
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
        color: Colors.black87,
        fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  void configurePlayer() {
    player = AudioPlayer();
    currentMusiqueIndex = 0;
    positionPlay = const Duration(seconds: 0);
    isPlayed = false;
    _playing = listesMusiques[currentMusiqueIndex];
    currentVolume = 0.8;
    player.setVolume(currentVolume);
  }

  void play() {
    isPlayed = !isPlayed;
    player.setSource(AssetSource(_playing.urlSong));
    player.resume();
    logger.i("play ${_playing.urlSong}");
  }

  void pause() {
    isPlayed = !isPlayed;
    player.pause();
  }

  void forward() {
    if (listesMusiques.length > currentMusiqueIndex) {
      currentMusiqueIndex = currentMusiqueIndex + 1;
      _playing = listesMusiques[currentMusiqueIndex];
      play();
    }
  }

  void rewind() {
    if (currentMusiqueIndex != 0) {
      currentMusiqueIndex = currentMusiqueIndex - 1;
      _playing = listesMusiques[currentMusiqueIndex];
      play();
    }
  }

  IconButton bouton(IconData icone, double taille, ActionMusic actionMusic) {
    return IconButton(
        iconSize: taille,
        color: Colors.deepOrange,
        onPressed: () {
          switch (actionMusic) {
            case ActionMusic.play:
              {
                setState(() {
                  play();
                });
                break;
              }
            case ActionMusic.pause:
              {
                setState(() {
                  pause();
                });
                break;
              }
            case ActionMusic.rewind:
              {
                logger.i("rewind");
                setState(() {
                  rewind();
                });
                break;
              }
            case ActionMusic.forward:
              {
                setState(() {
                  forward();
                });
                logger.i("forward");
                break;
              }
            case ActionMusic.volumeUp:
              {
                setState(() {
                  double newVolume = currentVolume + 0.2;
                  currentVolume = newVolume;
                  player.setVolume(newVolume);
                  logger.i("volume up ! $newVolume");
                });
                break;
              }
            case ActionMusic.volumeDown:
              {
                setState(() {
                  if (currentVolume > 0.1) {
                    double newVolume = currentVolume - 0.2;
                    currentVolume = newVolume;
                    player.setVolume(newVolume);
                    logger.i("volume down ! $newVolume");
                  }
                });
                break;
              }
          }
        },
        icon: Icon(icone));
  }
}
