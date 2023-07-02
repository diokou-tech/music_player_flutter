import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
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
                              fontSize: 35,
                              // fontStyle: FontStyle.italic
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  child: Icon(
                    Icons.music_note,
                    size: 50,
                    color: Colors.cyan,
                  ),
                ),
                Text(
                  "Vivez la musique autrement !",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Times New Romans"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
