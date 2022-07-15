import 'dart:convert';

import 'package:app_rispar/bloc/screens/custom_app_bar.dart';
import 'package:app_rispar/bloc/screens/home_screen.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../helpers/user_solicitation_model.dart';

class SimulationResultScreen extends StatefulWidget {
  const SimulationResultScreen({Key? key}) : super(key: key);

  @override
  State<SimulationResultScreen> createState() => _SimulationResultScreenState();
}

class _SimulationResultScreenState extends State<SimulationResultScreen> {
  // UserSolicitationModel? userSolicitationModel;

  String valueSelectedReturn = '000.000';
  String? percentSelectedReturn;
  String? isEmailReturn;
  String? isNameReturn;
  bool? isWarrantyResult;
  String? dataValidateResult;

 late Future<UserSolicitationModel>? futureAlbum;

  @override
  void initState() {
    super.initState();
    getDataValueSelected();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomTopAppBar(
        valueProgressAppBar: 1,
        isResultPageReturn: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const FittedBox(
                child: Text(
                  "Resultado da simulação",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Valor Escolhido',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'R\$ $valueSelectedReturn',
                          style: const TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Garantia',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          //TODO DADOS GARANTIA WARRANTY
                          'R\$ [344343]',
                          style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Taxa de juros',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        FutureBuilder<UserSolicitationModel>(
                          future: futureAlbum,
                          builder: (context, snapshot) {
                          print('FUTURE juros RETORNO ${snapshot.data!.valueWarranty}');
                            if (snapshot.hasData) {
                              return Text(snapshot.data!.valueWarranty ?? 'Não Retornado',
                                style: const TextStyle(fontSize: 12, color: Colors.black38, fontWeight: FontWeight.bold),
                              );
                            } else if (snapshot.hasError) {
                              return const Text('ERROU');
                            }

                            return const CircularProgressIndicator();
                          },
                        ),
                        // Text(
                        //   //TODO TAXA DE JUROS E DIVIDIR POR 100, PORCENTAGEM
                        //   userSolicitationModel != null
                        //       ? '${userSolicitationModel?.fees}%'
                        //       : '',
                        //   style: const TextStyle(
                        //       color: Colors.black38,
                        //       fontWeight: FontWeight.bold),
                        // )
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Percentual de garantia',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$percentSelectedReturn%',
                          style: const TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Quantidade de parcelas',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          //TODO QUANTIDADE SHARED
                          'R\$ [344343]',
                          style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        const Text(
                          'Primeiro vencimento',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          dataValidateResult != null ?
                          '$dataValidateResult' : 'Data inválida',
                          style: const TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'IOF',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          //TODO VALOR DE FOLOWERS
                          'R\$ [344343]',
                          style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Nome do usuário',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(isNameReturn != null ?
                        '$isNameReturn' : 'Nome Inválido',
                          style: const TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Email do usuário',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text( isEmailReturn != null ?
                          '$isEmailReturn' : 'Email Inválido',
                          style: const TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'CET anual',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'R\$ [344343]',
                          style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tipo da Simulação',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          isWarrantyResult == true ? "Com Garantia" :
                          'Sem Garantia',
                          style: const TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:
                          Theme.of(context).primaryColor, // Background color
                    ),
                    child: const Text(
                      "Nova simulação",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getDataValueSelected() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double valueSelected = prefs.getDouble('valueSelected') ?? 000.000;
    int? percentValueSelected = prefs.getInt('percentValue');
    bool? isWarrantySelected = prefs.getBool('isProtectedValue');
    String? emailValue = prefs.getString('emailUser');
    String? nameValue = prefs.getString('nameUser');

    var now = DateTime.now();
    var monthDate = DateTime.now().month + 2;
    var formatter = DateFormat('d/$monthDate/yy');
    String formattedDate = formatter.format(now);

    String valor =
        UtilBrasilFields.obterReal(valueSelected, moeda: false, decimal: 0)
            .toString();

    setState(() {
      valueSelectedReturn = valor;
      percentSelectedReturn = percentValueSelected.toString();
      isWarrantyResult = isWarrantySelected;
      isEmailReturn = emailValue.toString();
      isNameReturn = nameValue.toString();
      dataValidateResult = formattedDate;
      print("VALOR PROTEGIDO? $isWarrantyResult");
    });
  }

  Future<UserSolicitationModel> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://random-data-api.com/api/omniauth/github_get'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("RETORNO DO BODY NA TELA DE RESULTADOS ${response.body}");
      return UserSolicitationModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
