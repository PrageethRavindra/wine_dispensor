import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wine_dispensor/redWine.dart';
import 'package:wine_dispensor/roseWine.dart';
import 'package:wine_dispensor/whiteWine.dart';
import 'package:wine_dispensor/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WineApp(),
      routes: {
        "/first": (context) => First(),
        "/home": (context) => WineApp(),
        "/redWine": (context) => RedWine(),
        "/roseWine": (context) => RoseWine(),
      },
    );
  }
}
