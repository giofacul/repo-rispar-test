import 'package:app_rispar/bloc/screens/simulation_result_screen.dart';
import 'package:app_rispar/bloc/screens/utils/utils_image_rotate.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

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
            onPressed: () {
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text('Aguarde um momento...'),
              // ));

              //TODO REMOVER ACESSO A PAGINA
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SimulationResultScreen()));

            },
          ),
        ],
      ),
      //TODO TIMER LOADING
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: UtilsImageRotate(),
          ),
          Text(
            "Aguarde um momento",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "Estamos simulando seu pedido de \n crédito Rispar...",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      )),
    );
  }
}