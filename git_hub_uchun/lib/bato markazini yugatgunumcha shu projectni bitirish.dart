import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WidgetSearchScreen(),
    );
  }
}

class WidgetSearchScreen extends StatefulWidget {
  @override
  _WidgetSearchScreenState createState() => _WidgetSearchScreenState();
}

class _WidgetSearchScreenState extends State<WidgetSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _flutterElements = [
    {
      "name": "Column",
      "description": "Farzandlarini vertikal yo'nalishda joylashtiradi."
    },
    {
      "name": "Row",
      "description": "Farzandlarini gorizontal yo'nalishda joylashtiradi."
    },
    {
      "name": "Container",
      "description": "Ichidagi elementni sozlash imkonini beradi."
    },
    {"name": "Text", "description": "Matn chiqaradi."},
    {
      "name": "Stack",
      "description": "Farzandlarni boxning chetlariga nisbatan joylashtiradi."
    },
    {
      "name": "Padding",
      "description": "Ichidagi element atrofida bo'sh joy qo'shadi."
    },
    {
      "name": "Scaffold",
      "description": "Asosiy material dizaynli vizual tuzilmani yaratadi."
    },
    {"name": "AppBar", "description": "Material dizaynli dastur sarlavhasi."},
    {"name": "ListView", "description": "O'tkaziladigan widgetlar ro'yxati."},
    {
      "name": "GridView",
      "description": "Tartiblangan grid ko'rinishdagi widgetlar ro'yxati."
    },
    {"name": "Drawer", "description": "Yon panelda menyu ko'rsatadi."},
    {
      "name": "IconButton",
      "description": "Ikonka ko'rinishida bosiladigan tugma."
    },
    {
      "name": "FloatingActionButton",
      "description": "Qo'shimcha amal uchun ishlatiladigan tugma."
    },
    {
      "name": "GestureDetector",
      "description": "Imo-ishoralarni, masalan, bosishlarni aniqlaydi."
    },
    {
      "name": "Form",
      "description": "Kiritish maydonlarini guruhlash imkonini beradi."
    },
    {
      "name": "TextFormField",
      "description": "Kiritish maydoni, validator bilan."
    },
    {
      "name": "Checkbox",
      "description": "Sathlash mumkin bo'lgan belgi maydoni."
    },
    {
      "name": "Radio",
      "description": "Variant tanlash uchun ishlatiladigan belgi."
    },
    {"name": "Switch", "description": "Ha yoki Yo'q tanlash uchun kalit."},
    {
      "name": "Slider",
      "description": "Tanlash uchun slayder ko'rinishidagi kalit."
    },
    {"name": "AlertDialog", "description": "Dialog oynasini ko'rsatadi."},
    {"name": "BottomNavigationBar", "description": "Quyi navigatsiya paneli."},
    {
      "name": "TabBar",
      "description": "Tab orqali navigatsiyani boshqarish uchun."
    },
    {"name": "Expanded", "description": "Bo'sh joyni to'ldiradigan widget."},
    {"name": "Flexible", "description": "Moslashuvchan joy bilan o'rnatiladi."},
  ];

  List<Map<String, String>> _filteredElements = [];

  @override
  void initState() {
    super.initState();
    _filteredElements = _flutterElements;
  }

  void _filterElements(String query) {
    setState(() {
      _filteredElements = _flutterElements.where((element) {
        return element["name"]!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutterda barcha widjetlar ma'lumotlari"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Element nomini kiriting",
                border: OutlineInputBorder(),
              ),
              onChanged: _filterElements,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredElements.length,
              itemBuilder: (context, index) {
                final elementInfo = _filteredElements[index];
                return ListTile(
                  title: Text(elementInfo["name"]!),
                  onTap: () => _showElementDetails(context, elementInfo),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showElementDetails(
      BuildContext context, Map<String, String> elementInfo) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(elementInfo["name"]!),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(elementInfo["description"]!),
              SizedBox(height: 10),
              Text("Namuna kod:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text(elementInfo["example"]!,
                  style: TextStyle(fontFamily: 'monospace')),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Yopish"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
