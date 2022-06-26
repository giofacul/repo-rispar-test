import 'dart:convert';

import 'package:app_rispar/bloc/helpers/user_solicitation_helper.dart';
import 'package:app_rispar/bloc/screens/custom_app_bar.dart';
import 'package:app_rispar/bloc/screens/loading_screen.dart';
import 'package:app_rispar/bloc/screens/slider_shape_percent.dart';
import 'package:app_rispar/bloc/screens/slider_shape_quantity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SimulationValueSelectedScreen extends StatefulWidget {
  SimulationValueSelectedScreen({Key? key}) : super(key: key);

  @override
  State<SimulationValueSelectedScreen> createState() =>
      _SimulationValueSelectedScreenState();
}

class _SimulationValueSelectedScreenState
    extends State<SimulationValueSelectedScreen> {
  String? nameUserData;
  String? emailUserData;
  double? valueUserData;
  SliderShapeQuantity? slider;

  @override
  void initState() {
    super.initState();
    getDataUserToSimulation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomTopAppBar(
          valueProgressAppBar: 0.6, navigatorBackScreen: '/home_screen'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Valor escolhido',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                //TODO AJUSTAR AMOSTRA DE NUMERO
                'R\$ ${valueUserData.toString()}',
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
              const SizedBox(
                  height: 80,
                  child: SliderShapeQuantity()),
              const SizedBox(height: 24),
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
              const SizedBox(height: 80, child: SliderShapePercent()),
              const SizedBox(height: 24),
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
                      simulationProtectedCollateral(false);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoadingScreen()));
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
                  child: const Text(
                    "Adicionar garantia",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  onPressed: () {
                    simulationProtectedCollateral(true);
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

  simulationProtectedCollateral(bool protected) {
    createSimulation(
        name: nameUserData,
        email: emailUserData,
        //todo valor percentual 3,6,9
        itv: 2121,
        amount: valueUserData,
        //todo prazo entrega 3,6,9 12
        term: 21,
        hasProtectedCollateral: protected);

    print('dados retornados');
    print('NAME $nameUserData');
    print('EMAIL $emailUserData');
    print('VALOR $valueUserData');
    print('GARANTIA $protected');
    // print('QUANTIDADE ${slider?.indSlider}');
  }

  Future<UserSolicitation> createSimulation({
    String? name,
    String? email,
    int? itv,
    double? amount,
    int? term,
    bool? hasProtectedCollateral,
  }) async {
    final response = await http.post(
      Uri.parse('https://api.rispar.com.br/acquisition/simulation'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'email': email,
        'itv': int,
        'amount': amount,
        'term': term,
        'has_protected_collateral': hasProtectedCollateral
      }),
    );

    if (response.statusCode == 201) {
      return UserSolicitation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }

  getDataUserToSimulation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('nameUser') ?? '';
    final email = prefs.getString('emailUser') ?? '';
    final valueSimulation = prefs.getDouble('valueSelected') ?? '';

    setState(() {
      nameUserData = name;
      emailUserData = email;
      valueUserData = valueSimulation as double?;
    });
  }
}
