import 'package:flutter/material.dart';
import 'package:musik_audiomack/ui/pages/home.page.dart';
import 'package:musik_audiomack/ui/pages/about.page.dart';
import 'package:musik_audiomack/ui/pages/login.page.dart';
import 'package:musik_audiomack/ui/pages/playlist.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Musik App',
      debugShowCheckedModeBanner: false,
      routes: {
        "/home": (context) => const HomePage(),
        "/about": (context) => const AboutPage(),
        "/playlist": (context) => const PlaylistPage()
      },
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, primary: Colors.cyan, secondary: Colors.deepOrange),
        primarySwatch: Colors.deepOrange,
        primaryColor: Colors.cyan,
        useMaterial3: true, 
        primaryColorLight: Colors.deepOrange
      ),
      home: const LoginPage(),
    );
  }
}
