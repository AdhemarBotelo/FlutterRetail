import 'dart:io';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retail_app/ui/product_list.dart';

import 'data/API/api_helper.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

final ThemeData hardwareStoreTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
  // Primary colors
  primaryColor: Colors.orange, // Base orange color
  primaryColorDark: Colors.orange[800], // Darker shade for accents
  primaryColorLight: Colors.orange[200], // Lighter shade for backgrounds
  primarySwatch: Colors.orange, // Material swatch for derivatives

  // Accent color
  indicatorColor: Colors.teal, // Contrasting accent color

  // Text theme
  textTheme: const TextTheme(
    titleMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 16.0),
    bodySmall: TextStyle(fontSize: 14.0),
  ),

  // Button theme
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.orange, // Primary button color
  ),

  scaffoldBackgroundColor: Colors.white, // Background color
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white), // White icons in app bar
  ),
  
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Retail App',
        theme: hardwareStoreTheme,
        home: Scaffold(
          body: ProductList(),
        ),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column(
        children: [
          Text('A random AWESOME idea:'),
          Text(appState.current.asPascalCase),
          // ↓ Add this.
          ElevatedButton(
            onPressed: () {
              print('button pressed!');
              appState.getNext();
            },
            child: Text('Get Next'),
          ),
        ],
      ),
    );
  }
}
