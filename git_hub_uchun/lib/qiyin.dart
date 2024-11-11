import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PrayerTimeScreen(),
    );
  }
}

class PrayerTimeScreen extends StatefulWidget {
  @override
  _PrayerTimeScreenState createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  final List<String> prayerNames = [
    "Bomdod",
    "Peshin",
    "Asr",
    "Shom",
    "Hufton"
  ];
  final List<String> prayerTimes = ["", "", "", "", ""];
  String nextPrayer = "";
  Duration timeLeft = Duration.zero;
  Duration timeUntilNextPrayer = Duration.zero;
  Timer? countdownTimer;
  Timer? autoScrollTimer;
  final PageController _pageController = PageController();
  int currentPrayerIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchPrayerTimes();
    startAutoScroll();
  }

  Future<void> fetchPrayerTimes() async {
    final url = Uri.parse(
        'https://api.aladhan.com/v1/timingsByCity?city=Tashkent&country=Uzbekistan&method=2');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data']['timings'];
        setState(() {
          prayerTimes[0] = data['Fajr'];
          prayerTimes[1] = data['Dhuhr'];
          prayerTimes[2] = data['Asr'];
          prayerTimes[3] = data['Maghrib'];
          prayerTimes[4] = data['Isha'];
          updateNextPrayer();
        });
      } else {
        throw Exception('Failed to load prayer times');
      }
    } catch (error) {
      print('Error fetching prayer times: $error');
    }
  }

  void updateNextPrayer() {
    final now = DateTime.now();
    for (int i = 0; i < prayerTimes.length; i++) {
      final prayerDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(prayerTimes[i].split(':')[0]),
        int.parse(prayerTimes[i].split(':')[1]),
      );

      if (prayerDateTime.isAfter(now)) {
        setState(() {
          currentPrayerIndex = i;
          nextPrayer = prayerNames[i];
          timeLeft = prayerDateTime.difference(now);
          timeUntilNextPrayer = timeLeft;
          startCountdown();
        });
        break;
      }
    }
  }

  void startCountdown() {
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft.inSeconds > 0) {
        setState(() {
          timeLeft -= Duration(seconds: 1);
        });
      } else {
        timer.cancel();
        updateNextPrayer();
      }
    });
  }

  void startAutoScroll() {
    autoScrollTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (currentPrayerIndex + 1) % prayerNames.length;
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        setState(() {
          currentPrayerIndex = nextPage;
          updateNextPrayer();
        });
      }
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  String getBackgroundImage() {
    final hour = DateTime.now().hour;
    if (hour >= 8 && hour < 11) {
      return 'assets/ertalab.jpg';
    } else if (hour >= 11 && hour < 15) {
      return 'assets/abet.jpg';
    } else if (hour >= 15 && hour < 22) {
      return 'assets/kech.jpg';
    } else {
      return 'assets/ertalab.jpg'; // Default image
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Prayer Time')),
      body: Column(
        children: [
          // Countdown Timer Display with Circular Percent Indicator and Background Image
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(getBackgroundImage()),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 10.0,
                percent: timeUntilNextPrayer.inSeconds > 0
                    ? (timeLeft.inSeconds / timeUntilNextPrayer.inSeconds)
                    : 0,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${timeLeft.inHours.toString().padLeft(2, '0')}:${(timeLeft.inMinutes % 60).toString().padLeft(2, '0')}:${(timeLeft.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Before next prayer: $nextPrayer',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                  ],
                ),
                progressColor: Colors.yellow,
                backgroundColor: Colors.white24,
              ),
            ),
          ),

          // Prayer Time Rotating View with PageView and Rounded Corners
          Expanded(
            child: Container(
              width: 200,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPrayerIndex = index;
                      updateNextPrayer();
                    });
                  },
                  itemCount: prayerNames.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.yellow[700],
                      child: Center(
                        child: Text(
                          '${prayerNames[index]}\n${prayerTimes[index]}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Date and Time Zone Information
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Day\n${DateTime.now().toLocal().toString().split(" ")[0]}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  'Time Zone\nGMT+5:30',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
