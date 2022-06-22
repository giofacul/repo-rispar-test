import 'package:app_rispar/bloc/screens/custom_app_bar.dart';
import 'package:app_rispar/bloc/screens/loading_screen.dart';
import 'package:app_rispar/bloc/screens/slider_shape_percent.dart';
import 'package:app_rispar/bloc/screens/slider_shape_quantity.dart';
import 'package:flutter/material.dart';

class SimulationValueSelectedScreen extends StatefulWidget {
  final String? valueSolicited;
  const SimulationValueSelectedScreen({Key? key, this.valueSolicited})
      : super(key: key);

  @override
  State<SimulationValueSelectedScreen> createState() =>
      _SimulationValueSelectedScreenState();
}

class _SimulationValueSelectedScreenState
    extends State<SimulationValueSelectedScreen> {
  int indexSlider = 0;

  @override
  Widget build(BuildContext context) {

  return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomTopAppBar(valueProgressAppBar: 0.66),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textAlign: TextAlign.start,
                'Valor escolhido',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'R\$ ${widget.valueSolicited}',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 24),
              Row(
                children: const [
                  Text(
                    "Escolha a ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "quantidade de parcelas",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 80, child: SliderShapeQuantity()),
              SizedBox(height: 24),
              Row(
                children: const [
                  Text(
                    "Escolha o ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "percentual de garantia",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(height: 80, child: SliderShapePercent()),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Garantia protegida',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.left,
                ),
              ),
              const Text(
                  "Bitcoin caiu? Fique tranquilo! Na garantia protegida,"
                  " você não recebe chamada de margem e não é liquidado",
                  style: TextStyle(color: Colors.black54, fontSize: 18),
                  textAlign: TextAlign.justify),
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Center(
                  child: TextButton(
                    child: Text(
                      'Continuar sem garantia',
                      style: TextStyle(
                          fontSize: 18, color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Não sei oq faz kk')));
                    },
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor, // Background color
                  ),
                  child: Text(
                    "Adicionar garantia",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoadingScreen()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
