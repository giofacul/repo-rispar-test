import 'package:app_rispar/bloc/screens/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SimulationValueSelected extends StatelessWidget {
  const SimulationValueSelected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomTopAppBar(valueProgressAppBar: 0.66),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textAlign: TextAlign.start,
              'Valor escolhido',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12,),
            Text(
              'R\$ 324343',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 24,),
            Row(
              children: const [
                Text(
                  "Escolha a ",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "quantidade de parcelas",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
