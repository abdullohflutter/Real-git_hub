import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: WorldTime(),
    debugShowCheckedModeBanner: false,
  ));
}

class WorldTime extends StatefulWidget {
  const WorldTime({super.key});

  @override
  State<WorldTime> createState() => _WorldTimeState();
}

class _WorldTimeState extends State<WorldTime> {
  String nom = "Asia/Tokyo";
  String day = "";
  String dayof = "";
  String hour = "0";
  String minutes = "0";
  String seconds = "0";
  String microseconds = "0";
  String date = "";
  String datetime = "";
  TextEditingController _controller = TextEditingController();

  List<Map<String, String>> timezones = [
    {'country': 'Uzbekistan', 'timezone': 'Asia/Tashkent'},
    {'country': 'Japan', 'timezone': 'Asia/Tokyo'},
    {'country': 'United States (New York)', 'timezone': 'America/New_York'},
    {'country': 'Germany', 'timezone': 'Europe/Berlin'},
    {'country': 'Australia', 'timezone': 'Australia/Sydney'},
    {'country': 'India', 'timezone': 'Asia/Kolkata'},
    {'country': 'Russia (Moscow)', 'timezone': 'Europe/Moscow'},
    {'country': 'China', 'timezone': 'Asia/Shanghai'},
    {'country': 'Brazil (Sao Paulo)', 'timezone': 'America/Sao_Paulo'},
    {'country': 'South Africa', 'timezone': 'Africa/Johannesburg'},
    {'country': 'United Kingdom', 'timezone': 'Europe/London'},
    {'country': 'Canada (Toronto)', 'timezone': 'America/Toronto'},
    {'country': 'France', 'timezone': 'Europe/Paris'},
    {'country': 'Italy', 'timezone': 'Europe/Rome'},
    {'country': 'Turkey', 'timezone': 'Europe/Istanbul'},
    {'country': 'Saudi Arabia', 'timezone': 'Asia/Riyadh'},
    {'country': 'Argentina', 'timezone': 'America/Argentina/Buenos_Aires'},
    {'country': 'Mexico', 'timezone': 'America/Mexico_City'},
    {'country': 'South Korea', 'timezone': 'Asia/Seoul'},
    {'country': 'New Zealand', 'timezone': 'Pacific/Auckland'},
    {'country': 'Nigeria', 'timezone': 'Africa/Lagos'},
    {'country': 'Spain', 'timezone': 'Europe/Madrid'},
    {'country': 'Portugal', 'timezone': 'Europe/Lisbon'},
    {'country': 'Sweden', 'timezone': 'Europe/Stockholm'},
    {'country': 'Poland', 'timezone': 'Europe/Warsaw'},
    {'country': 'Greece', 'timezone': 'Europe/Athens'},
    {'country': 'Egypt', 'timezone': 'Africa/Cairo'},
    {'country': 'Philippines', 'timezone': 'Asia/Manila'},
    {'country': 'Pakistan', 'timezone': 'Asia/Karachi'},
    {'country': 'Bangladesh', 'timezone': 'Asia/Dhaka'},
    {'country': 'Israel', 'timezone': 'Asia/Jerusalem'},
    {'country': 'Netherlands', 'timezone': 'Europe/Amsterdam'},
    {'country': 'Belgium', 'timezone': 'Europe/Brussels'},
    {'country': 'Switzerland', 'timezone': 'Europe/Zurich'},
    {'country': 'Austria', 'timezone': 'Europe/Vienna'},
    {'country': 'Denmark', 'timezone': 'Europe/Copenhagen'},
    {'country': 'Norway', 'timezone': 'Europe/Oslo'},
    {'country': 'Finland', 'timezone': 'Europe/Helsinki'},
    {'country': 'Ireland', 'timezone': 'Europe/Dublin'},
    {'country': 'Czech Republic', 'timezone': 'Europe/Prague'},
    {'country': 'Hungary', 'timezone': 'Europe/Budapest'},
    {'country': 'Romania', 'timezone': 'Europe/Bucharest'},
    {'country': 'Vietnam', 'timezone': 'Asia/Ho_Chi_Minh'},
    {'country': 'Thailand', 'timezone': 'Asia/Bangkok'},
    {'country': 'Malaysia', 'timezone': 'Asia/Kuala_Lumpur'},
    {'country': 'Singapore', 'timezone': 'Asia/Singapore'},
    {'country': 'Indonesia', 'timezone': 'Asia/Jakarta'},
    {'country': 'Hong Kong', 'timezone': 'Asia/Hong_Kong'},
    {'country': 'Taiwan', 'timezone': 'Asia/Taipei'},
    {'country': 'United Arab Emirates', 'timezone': 'Asia/Dubai'},
    {'country': 'Morocco', 'timezone': 'Africa/Casablanca'},
    {'country': 'Ukraine', 'timezone': 'Europe/Kyiv'},
    {'country': 'South Sudan', 'timezone': 'Africa/Juba'},
    {'country': 'Qatar', 'timezone': 'Asia/Qatar'},
    {'country': 'Oman', 'timezone': 'Asia/Muscat'},
    {'country': 'Iraq', 'timezone': 'Asia/Baghdad'},
    {'country': 'Kuwait', 'timezone': 'Asia/Kuwait'},
    {'country': 'Colombia', 'timezone': 'America/Bogota'},
    {'country': 'Chile', 'timezone': 'America/Santiago'},
    {'country': 'Peru', 'timezone': 'America/Lima'},
    {'country': 'Venezuela', 'timezone': 'America/Caracas'},
    {'country': 'Algeria', 'timezone': 'Africa/Algiers'},
    {'country': 'Ethiopia', 'timezone': 'Africa/Addis_Ababa'},
    {'country': 'Uganda', 'timezone': 'Africa/Kampala'},
    {'country': 'Kenya', 'timezone': 'Africa/Nairobi'},
    {'country': 'Ghana', 'timezone': 'Africa/Accra'},
    {'country': 'Ivory Coast', 'timezone': 'Africa/Abidjan'},
    {'country': 'Angola', 'timezone': 'Africa/Luanda'},
    {'country': 'Zimbabwe', 'timezone': 'Africa/Harare'},
    {'country': 'Portugal (Madeira)', 'timezone': 'Atlantic/Madeira'},
    {'country': 'Gibraltar', 'timezone': 'Europe/Gibraltar'},
    {'country': 'Malta', 'timezone': 'Europe/Malta'},
    {'country': 'Belarus', 'timezone': 'Europe/Minsk'},
    {'country': 'Luxembourg', 'timezone': 'Europe/Luxembourg'},
    {'country': 'Cyprus', 'timezone': 'Asia/Nicosia'},
    {'country': 'Armenia', 'timezone': 'Asia/Yerevan'},
    {'country': 'Azerbaijan', 'timezone': 'Asia/Baku'},
    {'country': 'Kazakhstan', 'timezone': 'Asia/Almaty'},
    {'country': 'Georgia', 'timezone': 'Asia/Tbilisi'},
    {'country': 'Jordan', 'timezone': 'Asia/Amman'},
    {'country': 'Lebanon', 'timezone': 'Asia/Beirut'},
    {'country': 'Yemen', 'timezone': 'Asia/Aden'},
    {'country': 'Syria', 'timezone': 'Asia/Damascus'},
    {'country': 'Sri Lanka', 'timezone': 'Asia/Colombo'},
    {'country': 'Myanmar', 'timezone': 'Asia/Yangon'},
    {'country': 'Mongolia', 'timezone': 'Asia/Ulaanbaatar'},
    {'country': 'Nepal', 'timezone': 'Asia/Kathmandu'},
    {'country': 'Maldives', 'timezone': 'Indian/Maldives'},
    {'country': 'Seychelles', 'timezone': 'Indian/Mahe'},
    {'country': 'Mauritius', 'timezone': 'Indian/Mauritius'},
    {'country': 'Iceland', 'timezone': 'Atlantic/Reykjavik'},
    {'country': 'Greenland', 'timezone': 'America/Godthab'},
    {'country': 'Cuba', 'timezone': 'America/Havana'},
    {'country': 'Panama', 'timezone': 'America/Panama'},
    {'country': 'Costa Rica', 'timezone': 'America/Costa_Rica'},
    {'country': 'Uruguay', 'timezone': 'America/Montevideo'},
    {'country': 'Paraguay', 'timezone': 'America/Asuncion'},
    {'country': 'Bolivia', 'timezone': 'America/La_Paz'},
    {'country': 'Ecuador', 'timezone': 'America/Guayaquil'},
    {'country': 'Jamaica', 'timezone': 'America/Jamaica'},
  ];

  List<String> matchingTimezones = [];
  bool isLoading = false;
  String selectedCountry = "";

  int m = 0;

  final Map<int, Map<String, Color>> colorOptions = {
    1: {
      "oq": Colors.black,
      "biroq": Colors.white,
      "ikkioq": Colors.white,
      "texq": Colors.white,
      "tqx1q": Colors.black,
      "tex2q": Colors.black,
    },
    2: {
      "oq": Colors.white,
      "biroq": Colors.black,
      "ikkioq": Colors.white,
      "texq": Colors.black,
      "tqx1q": Colors.white,
      "tex2q": Colors.black,
    },
    3: {
      "oq": Colors.white,
      "biroq": Colors.white,
      "ikkioq": Colors.black,
      "texq": Colors.black,
      "tqx1q": Colors.black,
      "tex2q": Colors.white,
    },
  };

  void updateColors(int selectedIndex) {
    setState(() {
      m = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTime(nom);
    startUpdatingTime();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchTime(String timeZone) async {
    if (timeZone != selectedCountry) {
      selectedCountry = timeZone;
      setState(() {
        isLoading = true;
      });

      String apilink =
          "https://www.timeapi.io/api/Time/current/zone?timeZone=$timeZone";
      try {
        Response response = await get(Uri.parse(apilink));
        if (response.statusCode == 200) {
          Map alohida = jsonDecode(response.body);
          setState(() {
            nom = alohida["timeZone"];
            hour = alohida["hour"].toString();
            minutes = alohida["minute"].toString();
            seconds = alohida["seconds"].toString();
            microseconds = '0';
            date = alohida["date"].toString();
            datetime = alohida["dateTime"].toString();
            day = alohida["day"].toString();
            dayof = alohida["dayOfWeek"];
            isLoading = false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid timezone: $timeZone')),
          );
          setState(() {
            isLoading = false;
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> startUpdatingTime() async {
    int totalMicroseconds = 0;
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      if (mounted) {
        totalMicroseconds++;
        if (totalMicroseconds >= 1000) {
          totalMicroseconds = 0;
          setState(() {
            int currentSecond = int.parse(seconds);
            int currentMinute = int.parse(minutes);
            int currentHour = int.parse(hour);

            currentSecond++;
            if (currentSecond >= 60) {
              currentSecond = 0;
              currentMinute++;
              if (currentMinute >= 60) {
                currentMinute = 0;
                currentHour++;
                if (currentHour >= 24) {
                  currentHour = 0;
                }
              }
            }

            seconds = currentSecond.toString();
            minutes = currentMinute.toString();
            hour = currentHour.toString();
          });
        }

        setState(() {
          microseconds = totalMicroseconds.toString().padLeft(6, '0');
        });
      } else {
        timer.cancel();
      }
    });
  }

  void searchTimezone(String query) {
    if (query.isNotEmpty) {
      setState(() {
        matchingTimezones = timezones
            .where((timezone) => timezone['country']!
                .toLowerCase()
                .contains(query.toLowerCase()))
            .map((timezone) => timezone['timezone']!)
            .toList();
      });
    } else {
      setState(() {
        matchingTimezones.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            nom,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leading: Icon(Icons.arrow_back),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                size: 28,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.done,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onDoubleTap: () {},
                              child: Icon(
                                Icons.pause,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: Container(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      hour,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Hours",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      minutes,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Minutes",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      seconds,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Seconds",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            )),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      height: 110,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  datetime,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Date",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.blueGrey),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  date,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      height: 110,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Day",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.blueGrey),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  day,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "DayOfWeek",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.blueGrey),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  dayof,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Progress status",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Hours",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colors.orange),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Select Country",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (isLoading)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  if (!isLoading) ...[
                    if (matchingTimezones.isNotEmpty)
                      Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width - 24,
                        child: ListView.builder(
                          itemCount: matchingTimezones.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                fetchTime(matchingTimezones[index]);
                                setState(() {
                                  _controller.text = matchingTimezones[index];
                                  matchingTimezones.clear();
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      matchingTimezones[index],
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TextField(
                      controller: _controller,
                      onChanged: searchTimezone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        hintText: "Search world times",
                        filled: true,
                        fillColor: Colors.grey.shade200,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//



