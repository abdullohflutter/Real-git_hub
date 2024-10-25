import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Birinchi(),
    ),
  );
}

final still = TextStyle(
  color: Colors.black,
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

class Birinchi extends StatefulWidget {
  const Birinchi({super.key});

  @override
  State<Birinchi> createState() => _BirinchiState();
}

class _BirinchiState extends State<Birinchi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                    left: 150,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/ot.png",
                        height: 40,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "BREED",
                        style: still,
                      ),
                      SizedBox(
                        width: 150,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                          color: const Color.fromARGB(
                            255,
                            255,
                            156,
                            155,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "ABOUT",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "PORTFOLIO",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "PAGES",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "BLOG",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "CONTACT",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 140,
                    left: 150,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "HEY THERE !",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "I AM JO BREED",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 38, 70),
                          fontSize: 60,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "CREATIVE ART DIRECTOR & DESIGNER",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 38, 70),
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.twitter),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(FontAwesomeIcons.skype),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(FontAwesomeIcons.instagram),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(FontAwesomeIcons.dribbble),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(FontAwesomeIcons.vimeo),
                        ],
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Container(
                        width: 200,
                        height: 55,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.pink,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: Text(
                            'SEE MY WORK',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Image.asset("assets/odam.webp"),
          ],
        ),
      ),
    );
  }
}
