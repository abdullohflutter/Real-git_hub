import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PrayerTimeScreen extends StatefulWidget {
  @override
  _PrayerTimeScreenState createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  Map<String, dynamic>? prayerData;

  @override
  void initState() {
    super.initState();
    fetchPrayerData();
  }

  Future<void> fetchPrayerData() async {
    final response = await http.get(Uri.parse('YOUR_API_ENDPOINT_HERE'));

    if (response.statusCode == 200) {
      setState(() {
        prayerData = json.decode(response.body);
      });
    } else {
      print("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: prayerData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Container(
                width: 300,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      prayerData!['timezone'],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      prayerData!['islamic_month'],
                      style:
                          TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 20),
                    Text(
                        "Gregorian Date: ${prayerData!['gregorian_date']}, Weekday: ${prayerData!['weekday']}"),
                    Text("Month: ${prayerData!['month']}"),
                    Text("kun: ${prayerData!['kun']}"),
                    SizedBox(height: 20),
                    ...prayerData!['times'].entries.map((entry) {
                      return Text("${entry.key}: ${entry.value}");
                    }).toList(),
                  ],
                ),
              ),
            ),
    );
  }
}
