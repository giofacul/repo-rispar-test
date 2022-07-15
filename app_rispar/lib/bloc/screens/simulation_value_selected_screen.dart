import 'dart:convert';
import 'package:app_rispar/bloc/helpers/user_solicitation_model.dart';
import 'package:app_rispar/bloc/screens/custom_app_bar.dart';
import 'package:app_rispar/bloc/screens/loading_screen.dart';
import 'package:app_rispar/bloc/screens/slider_shape_percent.dart';
import 'package:app_rispar/bloc/screens/slider_shape_quantity.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
            const Flexible(
              child: Text(
                'Valor escolhido',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            Flexible(
              child: Text(
                valueUserData == null
                    ? ''
                    : 'R\$ ${UtilBrasilFields.obterReal(valueUserData!, moeda: false, decimal: 0)}',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
                textAlign: TextAlign.left,
              ),
            ),
            // const SizedBox(height: 24),
            Flexible(
              child: FittedBox(
                child: Row(
                  children: const [
                    Text(
                      "Escolha a ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "quantidade de parcelas",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
                height: 80,
                child: SliderShapeQuantity(
                  onChangedQuantity: (value) {
                    sliderQuantity = value;
                  },
                )),
            Flexible(
              child: Row(
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
            ),
            SizedBox(
                height: 80,
                child: SliderShapePercent(onChangedPercent: (value) {
                  sliderPercent = value;
                  print('SLIDER PERCENT RETURN $sliderPercent');
                })),
            Flexible(
              child: Text(
                'Garantia protegida',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
                textAlign: TextAlign.left,
              ),
            ),
            const Expanded(
              child: Text(
                  "Bitcoin caiu? Fique tranquilo! Na garantia protegida,"
                  " você não recebe chamada de margem e não é liquidado.",
                  maxLines: 3,
                  style: TextStyle(color: Colors.black54, fontSize: 18),
                  textAlign: TextAlign.justify),
            ),
            Flexible(
              child: Center(
                child: TextButton(
                  child: Text(
                    'Continuar sem garantia',
                    style: TextStyle(
                        fontSize: 18, color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    print('VALOR $valueUserData');
                    simulationProtectedCollateral(false);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const LoadingScreen()));
                  },
                ),
              ),
            ),
            Flexible(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
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
                    print('VALOR $valueUserData');
                    simulationProtectedCollateral(true);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const LoadingScreen()));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  simulationProtectedCollateral(bool protected) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isProtectedValue', protected);
    prefs.setInt('percentValue', sliderPercent ?? (sliderPercent = 20));
    await _navigationToNextPage();
  }

  //   createSimulation(
  //       name: nameUserData,
  //       email: emailUserData,
  //       //PERCENTUAL DE GARANTIA
  //       itv: sliderQuantity ?? (sliderQuantity = 3),
  //       amount: valueUserData,
  //       //PARCELAS
  //       term: sliderPercent ?? (sliderPercent = 20),
  //       hasProtectedCollateral: protected);
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('percentValue', sliderPercent!);
  //
  //   print('dados retornados');
  //   print('NAME $nameUserData');
  //   print('EMAIL $emailUserData');
  //   print('VALOR ${valueUserData?.round()}');
  //   print('GARANTIA $protected');
  //   print('QUANTIDADE $sliderQuantity');
  //   print('PARCELAS $sliderPercent');
  // }
  //
  // Future<UserSolicitationModel> createSimulation({
  //   String? name,
  //   String? email,
  //   int? itv,
  //   double? amount,
  //   int? term,
  //   bool? hasProtectedCollateral,
  // }) async {
  // final response = await http.get(
  //   Uri.parse('https://random-data-api.com/api/omniauth/github_get'),
  // headers: <String, String>{
  //   'Content-Type': 'application/json; charset=UTF-8',
  // },
  // body: jsonEncode(<String, dynamic>{
  //   'name': name,
  //   'email': email,
  //   'itv': int,
  //   'amount': amount,
  //   'term': term,
  //   'has_protected_collateral': hasProtectedCollateral
  // }),
  //   );
  //   print('RETORNO DOS DADOS DO RESPONSE BODI ${response.body}');
  //
  //   if (response.statusCode == 200) {
  //     return UserSolicitationModel.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to create album.');
  //   }
  // }

  getDataUserToSimulation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('nameUser') ?? '';
    final email = prefs.getString('emailUser') ?? '';
    final valueSimulation = prefs.getDouble('valueSelected') ?? '';

    setState(() {
      nameUserData = name;
      emailUserData = email;
      valueUserData = valueSimulation as double;
    });
  }

  _navigationToNextPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const LoadingScreen()));
  }
}
