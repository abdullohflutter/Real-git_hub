import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prayer Times & Cars',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCity = 'Qo\'qon';

  final Map<String, Map<String, String>> cityData = {
    'Qo\'qon': {
      'hijri': 'Hijriy 1445',
      'date': '2024-11-05',
      'day': 'Seshanba',
      'bomdod': '05:31',
      'quyosh': '06:51',
      'peshin': '12:00',
    },
    'Buxoro': {
      'hijri': 'Hijriy 1445',
      'date': '2024-11-05',
      'day': 'Seshanba',
      'bomdod': '05:45',
      'quyosh': '07:05',
      'peshin': '12:30',
    },
    'Toshkent': {
      'hijri': 'Hijriy 1445',
      'date': '2024-11-05',
      'day': 'Seshanba',
      'bomdod': '05:40',
      'quyosh': '07:00',
      'peshin': '12:20',
    },
  };

  final List<Car> cars = [
    Car(
      name: "M A L I B U",
      imageUrl: "assets/malibu.png",
      details: "A great family car with modern design and comfort.",
      engine: "2.0L Turbo",
      fuel: "Gasoline",
      topSpeed: "240 km/h",
      price: "\$25,000",
    ),
    Car(
      name: "B Y D",
      imageUrl: "assets/byd.jpg",
      details: "Known for electric vehicles with advanced features.",
      engine: "Electric Motor",
      fuel: "Electric",
      topSpeed: "180 km/h",
      price: "\$30,000",
    ),
    Car(
      name: "K I A",
      imageUrl: "assets/kia.png",
      details: "Offers a variety of models with great features.",
      engine: "1.6L Turbo",
      fuel: "Gasoline",
      topSpeed: "210 km/h",
      price: "\$20,000",
    ),
    Car(
      name: "O N I X",
      imageUrl: "assets/onix.png",
      details: "Popular in many markets with affordable price.",
      engine: "1.8L",
      fuel: "Gasoline",
      topSpeed: "200 km/h",
      price: "\$18,000",
    ),
    Car(
      name: "BMW X5",
      imageUrl: "assets/BMW.jpg",
      details: "Luxury SUV with high performance and comfort.",
      engine: "3.0L Turbo",
      fuel: "Gasoline",
      topSpeed: "250 km/h",
      price: "\$60,000",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentData = cityData[selectedCity]!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            DropdownButton<String>(
              value: selectedCity,
              items: cityData.keys.map((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(
                    city,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: (newCity) {
                setState(() {
                  selectedCity = newCity!;
                });
              },
              dropdownColor: Colors.blue,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(currentData['hijri']!, style: TextStyle(fontSize: 18)),
                    Icon(Icons.circle, size: 24),
                  ],
                ),
                Column(
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(currentData['day']!,
                          style: TextStyle(fontSize: 18)),
                    ),
                    Text(currentData['date']!, style: TextStyle(fontSize: 18)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PrayerTimeWidget(name: "Bomdod", time: currentData['bomdod']!),
                PrayerTimeWidget(name: "Quyosh", time: currentData['quyosh']!),
                PrayerTimeWidget(name: "Peshin", time: currentData['peshin']!),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  return CarListTile(
                    car: cars[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CarDetailScreen(car: cars[index]),
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

class PrayerTimeWidget extends StatelessWidget {
  final String name;
  final String time;

  const PrayerTimeWidget({required this.name, required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name, style: TextStyle(fontSize: 18)),
        Text(time, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class CarListTile extends StatelessWidget {
  final Car car;
  final VoidCallback onTap;

  const CarListTile({
    required this.car,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: ListTile(
          leading: Image.asset(car.imageUrl, width: 60, fit: BoxFit.cover),
          title: Text(car.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          subtitle:
              Text(car.details, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}

class CarDetailScreen extends StatelessWidget {
  final Car car;

  const CarDetailScreen({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(car.imageUrl,
                  width: 250, height: 200, fit: BoxFit.cover),
            ),
            SizedBox(height: 16),
            Text(car.details, style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Divider(),
            buildCarDetailRow("Engine", car.engine),
            buildCarDetailRow("Fuel Type", car.fuel),
            buildCarDetailRow("Top Speed", car.topSpeed),
            buildCarDetailRow("Price", car.price),
          ],
        ),
      ),
    );
  }

  Widget buildCarDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class Car {
  final String name;
  final String imageUrl;
  final String details;
  final String engine;
  final String fuel;
  final String topSpeed;
  final String price;

  Car({
    required this.name,
    required this.imageUrl,
    required this.details,
    required this.engine,
    required this.fuel,
    required this.topSpeed,
    required this.price,
  });
}
