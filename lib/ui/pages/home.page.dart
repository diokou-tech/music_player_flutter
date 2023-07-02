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
    printer: PrettyPrinter(),
  );
  List<Musique> listesMusiques = [
    Musique("Dip Doundou Guiss", "Damako Khar", "images/dip_cover.jpeg",
        "assets/sons/dip/damako-khar.mp3"),
    Musique(
        "Ninho", "Jefe", "images/ninhojefe.png", "assets/sons/ninho/jefe.mp3"),
    Musique("Dip Doundou Guiss", "Beut", "images/dip_tlk.png",
        "assets/sons/dip/beut.mp3"),
  ];
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
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Ma Musique",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      backgroundColor: Colors.cyan,
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       tooltip: "Home",
      //       icon: Icon(Icons.home,
      //       color: Colors.deepOrange,
      //       ),
      //       label: "Home",
      //       ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.feed,
      //       color: Colors.deepOrange,
      //       ),
      //       label: "Feed"),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.library_music,
      //       color: Colors.deepOrange,
      //       ),
      //       label: "My Library",
      //       ),
      //       BottomNavigationBarItem(
      //       icon: Icon(Icons.music_note,
      //       color: Colors.deepOrange,
      //       ),
      //       label: "Playlist",
      //       ),
      //   ],
      // ),
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
            textWithStyle(_playing.titre, 1.5, true),
            textWithStyle(_playing.artiste, 1.0, true),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWithStyle("0:0", 1),
                  Expanded(
                    child: Slider(
                      activeColor: Colors.orange,
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
                bouton(isPlayed == true ? Icons.pause : Icons.play_arrow, 35, ActionMusic.pause),
                bouton(isPlayed == true ? Icons.pause : Icons.play_arrow, 35, isPlayed == true ActionMusic.pause),
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
        color: Colors.white,
        fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  IconButton bouton(IconData icone, double taille, ActionMusic actionMusic) {
    return IconButton(
        iconSize: taille,
        color: Colors.orange,
        onPressed: () {
          switch (actionMusic) {
            case ActionMusic.play:
              {
                logger.i("play");
                break;
              }
            case ActionMusic.pause:
              {
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
