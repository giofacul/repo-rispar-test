import 'package:app_rispar/bloc/screens/home_page_screen.dart';
import 'package:app_rispar/bloc/screens/login_screen.dart';
import 'package:app_rispar/bloc/screens/simulation_result_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 0, 145, 145)
      ),
      home: const SimulationResultScreen(),
    );
  }
}
