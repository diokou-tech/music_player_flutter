import 'package:musik_audiomack/models/musique.model.dart';

class Faker{
  static List<Musique> listesMusiques = [
    Musique("Dip Doundou Guiss", "Beut", "assets/images/dip_cover.jpeg",
        "audios/dip-beut-tlk.webm"),
    Musique("Freeze Corleone", "Freeze Rael", "assets/images/freeze.jpeg",
        "audios/freeze-rael.webm"),
    Musique("Leys", "Si c'était le premier", "assets/images/leys.jpeg",
        "audios/leys-si-cetait-le-dernier.webm"),
    Musique("Reptyle Music", "Weet", "assets/images/reptyle-music.jpeg",
        "audios/reptyle-music-weet.mp3"),
  ];
  static List<Musique> getMusiques(){
    return listesMusiques;
  }
}   