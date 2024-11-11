import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      home: Birinchi(),
    ),
  );
}

class Birinchi extends StatefulWidget {
  const Birinchi({super.key});

  @override
  State<Birinchi> createState() => _BirinchiState();
}

class _BirinchiState extends State<Birinchi> {
  List<Map<String, dynamic>> surahData = [];

  Future<void> data() async {
    final response = await http.get(
      Uri.parse("https://api.alquran.cloud/v1/quran/uz.sodik"),
    );
    if (response.statusCode == 200) {
      final jsondata = jsonDecode(response.body);
      final surahs = jsondata['data']['surahs']; // List of surahs

      // Extracting each surah name with ayah numbers
      for (var surah in surahs) {
        List<int> ayahNumbers = [];
        for (var ayah in surah['ayahs']) {
          ayahNumbers.add(ayah['number']);
        }
        surahData.add({
          'name': surah['name'],
          'ayahNumbers': ayahNumbers,
        });
      }
      setState(() {});
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  void initState() {
    super.initState();
    data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Qur'on Suralari")),
      body: ListView.builder(
        itemCount: surahData.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sura nomi: ${surahData[index]['name']}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Ayah raqamlari: ${surahData[index]['ayahNumbers'].join(", ")}",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
