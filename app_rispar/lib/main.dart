import 'package:app_rispar/bloc/screens/home_screen.dart';
import 'package:app_rispar/bloc/screens/login_screen.dart';
import 'package:app_rispar/bloc/screens/simulation_value_selected_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color.fromARGB(255, 0, 145, 145)),
      home: const LoginScreen(),
      initialRoute: '/login_screen',
      routes: {
        '/login_screen': (context) => const LoginScreen(),
        '/home_screen': (context) => const HomeScreen(),
        '/simulation_value': (context) => SimulationValueSelectedScreen(),
      },
    );
  }

}
