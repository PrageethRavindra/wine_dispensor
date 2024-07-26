import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class RoseWine extends StatefulWidget {
  const RoseWine({Key? key}) : super(key: key);

  @override
  _RoseWineState createState() => _RoseWineState();
}

class _RoseWineState extends State<RoseWine> {
  int _buttonPressCount = 0;
  bool _isStat = true;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  void _updateCountInDatabase(int count) {
    _databaseReference.child('RoseWine').update({
      'RoseWineCount': count,
      'RoseWineStat': _isStat,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Rose Wine'),
        ),
        backgroundColor: Color.fromARGB(255, 250, 249, 248),
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
                  image: AssetImage('images/roseWine.jpg'),
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
