import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegistrationScreen()),
      );
    });

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Lottie.asset(
              'lottie/dollar.json',
              height: 300,
              width: 300,
            ),
          ),
        ],
      ),
    );
  }
}

class RegistrationScreen extends StatelessWidget {
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF7F00FF),
        elevation: 0,
        title: Text(
          "Ro'yxatdan o'tish",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF7F00FF),
                  Color(0xFFE100FF),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Lottie.asset(
              'lottie/dollar.json',
              height: 400,
              width: 400,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      _buildTextField("Familiya",
                          controller: lastNameController),
                      SizedBox(height: 10),
                      _buildTextField("Ism", controller: firstNameController),
                      SizedBox(height: 10),
                      _buildTextField("Login", controller: loginController),
                      SizedBox(height: 10),
                      _buildTextField("Parol",
                          controller: passwordController, isPassword: true),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (lastNameController.text.isEmpty ||
                        firstNameController.text.isEmpty ||
                        loginController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text("Iltimos, barcha maydonlarni to'ldiring!"),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Ma'lumotlar muvaffaqiyatli saqlandi!"),
                        ),
                      );
                      // Corrected placement of else block
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    "Saqlash",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint,
      {bool isPassword = false, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: hint,
        hintStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final String firstName;
  final String lastName;

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({required this.firstName, required this.lastName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$firstName $lastName"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF4A00E0),
                  Color(0xFF8E2DE2),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      _buildTextField("Login", controller: loginController),
                      SizedBox(height: 10),
                      _buildTextField("Parol",
                          isPassword: true, controller: passwordController),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Check if login and password are correct
                    if (loginController.text == "123" &&
                        passwordController.text == "321") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CurrencyScreen(
                            name: "Abdulloh",
                            surname: "Akramov",
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Login yoki parol xato!"),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    "Kirish",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint,
      {bool isPassword = false, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.black),
    );
  }
}

class CurrencyScreen extends StatefulWidget {
  final String name;
  final String surname;

  CurrencyScreen({required this.name, required this.surname});

  @override
  _CurrencyScreenState createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  List<dynamic> currencies = [];
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCurrencyData();
  }

  Future<void> fetchCurrencyData() async {
    final response = await http.get(
      Uri.parse('https://cbu.uz/uz/arkhiv-kursov-valyut/json/'),
    );
    if (response.statusCode == 200) {
      setState(() {
        currencies = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load currency data');
    }
  }

  void showCurrencyDetails(BuildContext context, dynamic currency) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("${currency['Ccy']}: Malumotlari"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Qiymati: ${currency['Rate']}"),
              Text("Valyutasi: ${currency['CcyNm_UZ']}"),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: "Miqdorni Kiriting",
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  double rate = double.parse(currency['Rate']);
                  double amount = double.tryParse(amountController.text) ?? 0;
                  double result = rate * amount;
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("${currency['Ccy']} Hisobi"),
                        content: Text("Natija: $result ${currency['Ccy']}"),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text("Qaytish"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text("Hisoblash"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${widget.surname} ${widget.name}"),
            Text(
              TimeOfDay.now().format(context),
              style: TextStyle(fontSize: 16),
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
            ),
          ],
        ),
      ),
      body: currencies.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: currencies.length,
              itemBuilder: (context, index) {
                final currency = currencies[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Yaqinlangan kun: ${currency['Date']}",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showCurrencyDetails(context, currency);
                                  },
                                  child: Text(
                                    "1 ${currency['Ccy']} (${currency['CcyNm_UZ']})",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "${currency['Rate']}",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${currency['Diff']}",
                              style: TextStyle(
                                fontSize: 18,
                                color: double.parse(currency['Diff']) > 0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
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
