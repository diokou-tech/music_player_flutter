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
  late int currentIndexNavBar;
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
    currentIndexNavBar = 0;
    super.initState();
    configurePlayer();
  }

  void changeIndexNavBar(int index) {
    setState(() {
      currentIndexNavBar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var homeSection = SingleChildScrollView(
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              image:  DecorationImage(
                image :  AssetImage("assets/images/wall-texture-background.jpg"),
                fit: BoxFit.cover,
                opacity: 0.3
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                    elevation: 0.8,
                    child: Container(
                        padding: const EdgeInsets.all(3),
                        width: MediaQuery.of(context).size.height / 2.5,
                        child: imageorDefault(_playing.imagePath))),
                textWithStyle(_playing.titre, 2, true),
                textWithStyle(_playing.artiste, 1.5, true),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textWithStyle("0:00", 1.05),
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
                      textWithStyle("0:22", 1.05),
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
                      padding: const EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    getImageorDefault(_playing.imagePath),
                              ),
                              textWithStyle(_playing.artiste, 1.2, true),
                            ],
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.cyan
                            ),
                            label: textWithStyle("Suivre", 1.1),
                            onPressed: () {},
                            icon: const Icon(Icons.add_circle),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      );
    var feedSection = Center(
      child: Text("Feed", style: Theme.of(context).textTheme.headlineLarge,),
    );
    var searchSection = Center(
      child: Text("Search", style: Theme.of(context).textTheme.headlineLarge,),
    );
    var librarySection = Center(
      child: Text("library", style: Theme.of(context).textTheme.headlineLarge,),
    );
    var meSection = Center(
      child: Text("Me", style: Theme.of(context).textTheme.headlineLarge,),
    );
    List<Widget> listesWidgets = [homeSection,feedSection,searchSection,librarySection,meSection];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "MUSIK",
              style: TextStyle(
                color: Colors.cyan,
                fontFamily: "Cambria",
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "SN",
              style: TextStyle(
                color: Colors.deepOrange,
                fontFamily: "Cambria",
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      // backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.cyan,
        currentIndex: currentIndexNavBar,
        elevation: 0.0,
        onTap: changeIndexNavBar,
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
              label: "Search"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_music,
              color: Colors.cyan,
            ),
            label: "My Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.cyan,
            ),
            label: "Me",
          ),
        ],
      ),
      body: listesWidgets[currentIndexNavBar],
    );
  }

  Widget imageorDefault(String path) {
    try {
      return Image.asset(
        path,
        fit: BoxFit.contain,
        height: MediaQuery.of(context).size.height / 2.5,
      );
    } on Exception catch (e) {
      logger.d(e);
      return Image.asset(
        "images/defaultImage.webp",
        fit: BoxFit.contain,
        height: MediaQuery.of(context).size.height / 2.5,
      );
    }
  }

  AssetImage getImageorDefault(String path) {
    try {
      return AssetImage(path);
    } catch (e) {
      logger.d(e);
      return const AssetImage("images/defaultImage.webp");
    }
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
