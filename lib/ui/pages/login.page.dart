import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "Next",
        child: IconButton(
          icon: const Icon(Icons.navigate_next_outlined),
          tooltip: "Next",
          iconSize: 50,
          color: Colors.cyan,
          onPressed: () {
            // Navigator.pop(context);
            Navigator.pushNamed(context, "/home");
          },
        ),
        onPressed: () {},
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                    height: 100,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "MUSIK",
                            style: TextStyle(
                              color: Colors.cyan,
                              fontFamily: "Cambria",
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              // fontStyle: FontStyle.italic
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
                              fontWeight: FontWeight.bold,
                              // fontStyle: FontStyle.italic
                            ),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(
                  child: Icon(
                    Icons.music_note,
                    size: 50,
                    color: Colors.cyan,
                  ),
                ),
                const Text(
                  "Vivez la musique autrement !",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Times New Romans"),
                ),
                AnimatedTextKit(
                  totalRepeatCount: 5,
                  animatedTexts: [
                    TypewriterAnimatedText('Plaisir'),
                    TypewriterAnimatedText('Voyage', cursor: '|'),
                    TypewriterAnimatedText('Découverte', cursor: '<|>'),
                    TypewriterAnimatedText('Vibrez', cursor: '💡'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
