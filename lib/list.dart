import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharedPreferences List Example',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> favoriteFruits = [

  ];

  @override
  void initState() {
    super.initState();
    _getFavoriteFruits();
  }

  Future<void> _getFavoriteFruits() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> storedFruits = prefs.getStringList('favorite_fruits') ?? [];
    setState(() {
      favoriteFruits = storedFruits;
    });
  }

  Future<void> _saveFavoriteFruits() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorite_fruits', favoriteFruits);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SharedPreferences List Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Favorite Fruits:'),
            for (var fruit in favoriteFruits) Text(fruit),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  favoriteFruits.add('New Fruit');
                  _saveFavoriteFruits();
                });
              },
              child: Text('Add New Fruit'),
            ),
          ],
        ),
      ),
    );
  }
}
