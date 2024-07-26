import 'package:flutter/material.dart';

class WineApp extends StatelessWidget {
  const WineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Select Your Wine',
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: Color.fromARGB(255, 34, 25, 2),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/redWine");
                    },
                    child: Text('Red Wine'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/first");
                    },
                    child: Text('White Wine'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/roseWine");
                    },
                    child: Text('Rose Wine'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
