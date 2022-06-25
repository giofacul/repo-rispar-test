import 'package:app_rispar/bloc/screens/home_screen.dart';
import 'package:app_rispar/bloc/screens/login_screen.dart';
import 'package:app_rispar/bloc/screens/simulation_value_selected_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isLogged = prefs.getBool('isLogged');

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color.fromARGB(255, 0, 145, 145)),
      routes: {
        '/login_screen': (context) => const LoginScreen(),
        '/home_screen': (context) => const HomeScreen(),
        '/simulation_value': (context) => const SimulationValueSelectedScreen(),
        // '/home': (context) => const SimulationValueSelectedScreen(),
      },
      home: isLogged != true ? LoginScreen() : HomeScreen()));
}
