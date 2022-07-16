import 'dart:async';
import 'package:app_rispar/bloc/screens/simulation_result_screen.dart';
import 'package:app_rispar/bloc/screens/utils/utils_image_rotate.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    startSplashScreenTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Theme.of(context).primaryColor),
            onPressed: () => [Navigator.of(context).pop()],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: UtilsImageRotate(),
            ),
            FittedBox(
              child: Text(
                "Aguarde um momento",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            FittedBox(
              child: Text(
                "Estamos simulando seu pedido de \n crédito Rispar...",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  startSplashScreenTimer() async {
    const Duration duration = Duration(seconds: 4);
    return Timer(duration, navigationToNextPage);
  }

  void navigationToNextPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const SimulationResultScreen()));
  }
}
