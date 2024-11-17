import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Qur\'on',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const QuranScreen(),
    );
  }
}

class QuranScreen extends StatefulWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  bool _isDarkMode = false;
  List<dynamic> uzSurahs = [];
  List<dynamic> arSurahs = [];
  List<dynamic> filteredUzSurahs = [];
  List<dynamic> filteredArSurahs = [];

  @override
  void initState() {
    super.initState();
    fetchUzSurahs();
    fetchArSurahs();
  }

  Future<void> fetchUzSurahs() async {
    final response = await http.get(
      Uri.parse('https://api.alquran.cloud/v1/quran/uz.sodik'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        uzSurahs = data['data']['surahs'];
        filteredUzSurahs = uzSurahs;
      });
    }
  }

  Future<void> fetchArSurahs() async {
    final response = await http.get(
      Uri.parse('https://api.alquran.cloud/v1/quran/quran-simple'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        arSurahs = data['data']['surahs'];
        filteredArSurahs = arSurahs;
      });
    }
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Qur\'on Suralari'),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: _toggleDarkMode,
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: filteredUzSurahs.isEmpty || filteredArSurahs.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: filteredUzSurahs.length,
                      itemBuilder: (context, index) {
                        final uzSurah = filteredUzSurahs[index];
                        final arSurah = filteredArSurahs[index];
                        return ListTile(
                          title: Text(
                            '${index + 1}. ${uzSurah['englishName']}',
                            style: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            uzSurah['name'],
                            style: TextStyle(
                              color:
                                  _isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SurahDetailScreen(
                                  uzSurah: uzSurah,
                                  arSurah: arSurah,
                                  isDarkMode: _isDarkMode,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class SurahDetailScreen extends StatefulWidget {
  final dynamic uzSurah;
  final dynamic arSurah;
  final bool isDarkMode;

  const SurahDetailScreen({
    Key? key,
    required this.uzSurah,
    required this.arSurah,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  bool _isUzbek = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.uzSurah['englishName']),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _isUzbek = true;
              });
            },
            child: Text(
              'O\'zbek',
              style: TextStyle(color: _isUzbek ? Colors.amber : Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _isUzbek = false;
              });
            },
            child: Text(
              'Arab',
              style: TextStyle(
                color: !_isUzbek ? Colors.amber : Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.uzSurah['ayahs'].length,
        itemBuilder: (context, index) {
          final uzAyah = widget.uzSurah['ayahs'][index];
          final arAyah = widget.arSurah['ayahs'][index];

          final text = _isUzbek
              ? uzAyah['text'] ?? 'O\'zbekcha matn mavjud emas'
              : arAyah['text'] ?? 'Arabcha matn mavjud emas';

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${index + 1}. $text',
              style: TextStyle(
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }
}
