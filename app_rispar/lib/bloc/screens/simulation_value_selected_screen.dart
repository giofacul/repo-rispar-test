import 'package:app_rispar/bloc/screens/custom_app_bar.dart';
import 'package:app_rispar/bloc/screens/loading_screen.dart';
import 'package:app_rispar/bloc/screens/simulation_result_screen.dart';
import 'package:app_rispar/bloc/screens/slider_shape_percent.dart';
import 'package:app_rispar/bloc/screens/slider_shape_quantity.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SimulationValueSelectedScreen extends StatefulWidget {
  const SimulationValueSelectedScreen({Key? key}) : super(key: key);

  @override
  State<SimulationValueSelectedScreen> createState() =>
      _SimulationValueSelectedScreenState();
}

class _SimulationValueSelectedScreenState
    extends State<SimulationValueSelectedScreen> {
  String? nameUserData;
  String? emailUserData;
  double? valueUserData;
  int? valueQuantityData;
  int? valuePercentData;
  SliderShapeQuantity? slider;
  int? sliderQuantity;
  int? sliderPercent;

  @override
  void initState() {
    super.initState();
    getDataUserToSimulation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomTopAppBar(
            valueProgressAppBar: 0.6, navigatorBackScreen: '/home_screen'),
        body: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Valor escolhido',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        valueUserData != null
                            ? ' R\$ ${UtilBrasilFields.obterReal(valueUserData!, moeda: false, decimal: 0)}'
                            : 'Vazio',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                          child: Row(
                        children: const [
                          Text(
                            "Escolha a ",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "quantidade de parcelas",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                      SliderShapeQuantity(
                        onChangedQuantity: (value) {
                          sliderQuantity = value;
                        },
                      ),
                      const SizedBox(height: 10),
                      FittedBox(
                        child: Row(
                          children: const [
                            Text(
                              "Escolha o ",
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              "percentual de garantia",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SliderShapePercent(onChangedPercent: (value) {
                        sliderPercent = value;
                        print('SLIDER PERCENT RETURN $sliderPercent');
                      }),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Garantia protegida',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                          "Bitcoin caiu? Fique tranquilo! Na garantia protegida,"
                          " você não recebe chamada de margem e não é liquidado.",
                          maxLines: 3,
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                          textAlign: TextAlign.justify),
                    ],
                  ),
                  Column(children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            child: Text(
                              'Continuar sem garantia',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColor),
                            ),
                            onPressed: () {
                              simulationProtectedCollateral(false);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoadingScreen()));
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context)
                              .primaryColor, // Background color
                        ),
                        child: const Text(
                          "Adicionar garantia",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        onPressed: () {
                          simulationProtectedCollateral(true);
                        },
                      ),
                    ),
                  ]),
                ])));
  }

  simulationProtectedCollateral(bool protected) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isProtectedValue', protected);
    prefs.setInt('percentValue', sliderPercent!);
    prefs.setInt('quantityValue', sliderQuantity!);
    await _navigationToNextPage();
  }

  _navigationToNextPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const SimulationResultScreen()));
  }

  getDataUserToSimulation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final valueSimulation = prefs.getDouble('valueSelected') ?? '';
    final valueQuantitySimulation = prefs.getInt('quantityValue');
    final valuePercentSimulation = prefs.getInt('percentValue');

    setState(() {
      valueUserData = valueSimulation as double;
      valueQuantityData = valueQuantitySimulation;
      valuePercentData = valuePercentSimulation;
    });
  }
}
