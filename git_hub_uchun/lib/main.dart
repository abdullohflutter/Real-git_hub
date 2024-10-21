import 'package:flutter/material.dart';

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
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

class Birinchi extends StatefulWidget {
  const Birinchi({super.key});

  @override
  State<Birinchi> createState() => _BirinchiState();
}

class _BirinchiState extends State<Birinchi> {
  void snackbar() {
    final s = SnackBar(
      action: SnackBarAction(
        label: "return",
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      duration: Duration(
        seconds: 2,
      ),
      content: Text(
        "Salom",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.yellow
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(s);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            snackbar();
          },
          child: Text(
            "zor",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
