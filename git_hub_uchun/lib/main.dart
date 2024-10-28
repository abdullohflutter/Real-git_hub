import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
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
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _sushiItems = [
    {
      "name": "Salmon Roll",
      "price": "\$22.50",
      "imagePath": "assets/sushi3.jpg",
    },
    {
      "name": "Dragon Roll",
      "price": "\$25.00",
      "imagePath": "assets/sushi4.jpg",
    },
    {
      "name": "Tuna Sashimi",
      "price": "\$30.00",
      "imagePath": "assets/sushi5.jpg",
    },
    {
      "name": "Spicy Tuna Roll",
      "price": "\$23.50",
      "imagePath": "assets/sushi6.jpg",
    },
  ];
  List<Map<String, String>> _filteredSushiItems = [];

  @override
  void initState() {
    super.initState();
    _filteredSushiItems = _sushiItems;
  }

  void _filterSushiItems(String query) {
    setState(() {
      _filteredSushiItems = _sushiItems.where((item) {
        return item["name"]!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  Widget sushiItemCard(
      String imagePath, String name, String price, Map<String, String> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SushiDetailPage(
              imagePath: item['imagePath']!,
              name: item['name']!,
              price: item['price']!,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imagePath,
              width: 160,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(price, style: TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }

  List<String> nom = [
    "assets/sushi.jpg",
    "assets/sushi2.jpg",
    "assets/sushi.jpg",
    "assets/sushi2.jpg",
  ];

  List<String> info = [
    "Get special discount",
    "Get special discount",
    "Get special discount",
    "Get special discount",
  ];

  List<String> discounts = [
    "Up to 85%",
    "Up to 50%",
    "Up to 70%",
    "Up to 30%",
  ];

  Widget carouselCard(String imagePath, String text, String discount) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 50),
          child: Column(
            children: [
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                discount,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Claim Voucher"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.notifications_active_sharp,
              color: Colors.black,
            ),
          )
        ],
        leading: Icon(Icons.more_vert),
        title: Center(
          child: Column(
            children: [
              Text(
                "Location",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.place,
                    color: Colors.red,
                  ),
                  Text(
                    "Uzbekistan",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          CarouselSlider(
            items: List.generate(
              nom.length,
              (index) =>
                  carouselCard(nom[index], info[index], discounts[index]),
            ),
            options: CarouselOptions(
              viewportFraction: 0.8,
              initialPage: 1,
              autoPlay: true,
              scrollDirection: Axis.horizontal,
              autoPlayInterval: Duration(
                seconds: 3,
              ),
              autoPlayCurve: Curves.easeInOutExpo,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: "Search your food...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onChanged: _filterSushiItems,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular Food",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "View all",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: _filteredSushiItems.length,
              itemBuilder: (context, index) {
                final sushi = _filteredSushiItems[index];
                return sushiItemCard(
                  sushi["imagePath"]!,
                  sushi["name"]!,
                  sushi["price"]!,
                  sushi,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SushiDetailPage extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;

  SushiDetailPage(
      {required this.imagePath, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 300,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    Text(
                      "4.8",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/sushi7.jpg",
                      height: 40,
                    ),
                    Text(
                      "Salmon",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Image.asset(
                      "assets/sushi9.jpg",
                      height: 40,
                    ),
                    Text(
                      "Sushi Rice",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 120,
                    ),
                    Image.asset(
                      "assets/sushi8.jpg",
                      height: 40,
                    ),
                    Text(
                      "Pepsi",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              price,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "About Sushi",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              "Sushi is a Japanese dish of prepared vinegared rice, usually served with seafood and vegetables.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Spacer(),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      "\$ 26.00",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("Total price"),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 150),
                  child: Container(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Uchinchi(),
                          ),
                        );
                      },
                      child: Text("Place Order"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: Size(
                          double.infinity,
                          50,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Uchinchi extends StatefulWidget {
  const Uchinchi({super.key});

  @override
  State<Uchinchi> createState() => _UchinchiState();
}

class _UchinchiState extends State<Uchinchi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.more_vert),
          ),
        ],
        title: Text("Your cart food"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 110,
              width: 400,
              child: Card(
                color: Colors.white70,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/sushi10.jpg",
                        height: 50,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Orginal Sushi",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text("1"),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.add,
                                size: 20,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 40,
                              right: 80,
                            ),
                            child: Text(
                              "\$ 26.00",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 110,
              width: 400,
              child: Card(
                color: Colors.white70,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/sushi11.jpg",
                        height: 50,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "California Roll",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text("1"),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.add,
                                size: 20,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 40,
                              right: 80,
                            ),
                            child: Text(
                              "\$ 18.00",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 110,
              width: 400,
              child: Card(
                color: Colors.white70,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/sushi3.jpg",
                        height: 50,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Salmon Roll",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text("1"),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.add,
                                size: 20,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 40,
                              right: 80,
                            ),
                            child: Text(
                              "\$ 22.00",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.ac_unit_sharp),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Promo code",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 300,
                    ),
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: Card(
                        color: Colors.black,
                        child: Center(
                          child: Text(
                            "Apply",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Item total:",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          width: 250,
                        ),
                        Text(
                          "\$70.50",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Delivery:",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          width: 250,
                        ),
                        Text(
                          "Free",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 250,
                        ),
                        Text(
                          "70.50",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: Card(
                        color: Colors.black,
                        child: Center(
                          child: Text(
                            "Payment",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
