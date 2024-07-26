import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart'; // Import Firebase database

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wine Dispenser',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: First(),
      routes: {
        '/home': (context) => HomeScreen(), // Define your home screen here
      },
    );
  }
}

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  int _buttonPressCount = 0;
  bool _isStat = true;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance
      .ref()
      .child('WhiteWine'); // Reference to the specific path

  @override
  void initState() {
    super.initState();
    _databaseReference.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        _buttonPressCount = data['WhiteWineCount'] ?? 0;
        _isStat = data['WhiteWineStat'] ?? true;
      });
    });
  }

  void _updateCountInDatabase(int count) {
    _databaseReference.update({
      'WhiteWineCount': count,
      'WhiteWineStat': _isStat,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('White Wine'),
        ),
        backgroundColor: Color.fromARGB(255, 253, 253, 253),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/home");
          },
          icon: Icon(Icons.home),
        ),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _buttonPressCount++;
                _isStat = true; // update WineStat to true
                _updateCountInDatabase(_buttonPressCount);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/whiteWine.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Text(
              'Wine Pour Count: $_buttonPressCount',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _buttonPressCount++;
                      _isStat = true; // update WineStat to true
                      _updateCountInDatabase(_buttonPressCount);
                    });
                  },
                  child: Text('Pour'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _buttonPressCount = 0;
                      _isStat = false; // reset WineStat to false
                      _updateCountInDatabase(_buttonPressCount);
                    });
                  },
                  child: Text('Reset'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
