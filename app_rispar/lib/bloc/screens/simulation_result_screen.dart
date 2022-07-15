import 'dart:convert';

import 'package:app_rispar/bloc/screens/custom_app_bar.dart';
import 'package:app_rispar/bloc/screens/home_screen.dart';
import 'package:app_rispar/bloc/screens/loading_screen.dart';
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

  String valueSelectedReturn = '000.000';
  String? percentSelectedReturn;
  String? quantitySelectedReturn;
  String? isEmailReturn;
  String? isNameReturn;
  bool? isWarrantyResult;
  String? dataValidateResult;

  late Future<UserSolicitationModel>? futureApi;

  @override
  void initState() {
    super.initState();
    getDataValueSelected();
    futureApi = fetchApi();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureApi,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: const CustomTopAppBar(
              valueProgressAppBar: 1,
              isResultPageReturn: true,
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 32.0, right: 32, bottom: 32, top: 8),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const FittedBox(
                      child: Text(
                        "Resultado da simulação",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight
                            .bold),
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
                            children: [
                              const Text(
                                'Garantia',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              FutureBuilder<UserSolicitationModel>(
                                future: futureApi,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data!.valueIOF != null
                                          ? 'β ${(int.parse(
                                          snapshot.data!.valueWarranty!) /
                                          10000000).toString().replaceAll(
                                          '.', ',')}'
                                          : 'Não Retornado',
                                      style: const TextStyle(
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold),
                                    );
                                  } else if (snapshot.hasError) {
                                    return const Text('ERROU');
                                  }

                                  return const CircularProgressIndicator();
                                },
                              ),
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
                                future: futureApi,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data!.valueFees != null
                                          ? '${(snapshot.data!.valueFees! /
                                          1000).toString().replaceAll(
                                          '.', ',')}% a.m'
                                          : 'Não Retornado',
                                      style: const TextStyle(
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold),
                                    );
                                  } else if (snapshot.hasError) {
                                    return const Text('ERROU');
                                  }

                                  return const CircularProgressIndicator();
                                },
                              ),
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
                                'CET anual',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              FutureBuilder<UserSolicitationModel>(
                                future: futureApi,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data!.valueCET != null
                                          ? 'R\$ ${(int.parse((
                                          snapshot.data!.valueCET!).toString()))
                                          .toString()
                                          .replaceAll('.', ',')}'
                                          : 'Não Retornado',
                                      style: const TextStyle(
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold),
                                    );
                                  } else if (snapshot.hasError) {
                                    return const Text('ERROU');
                                  }
                                  return const CircularProgressIndicator();
                                },
                              ),
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
                            children: [
                              const Text(
                                'Quantidade de parcelas',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '$quantitySelectedReturn',
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
                                'Primeiro vencimento',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                dataValidateResult != null
                                    ? '$dataValidateResult'
                                    : 'Data inválida',
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
                                'IOF',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              FutureBuilder<UserSolicitationModel>(
                                future: futureApi,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data!.valueIOF != null
                                          ? 'R\$ ${snapshot.data!.valueIOF!}'
                                          : 'Não Retornado',
                                      style: const TextStyle(
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold),
                                    );
                                  } else if (snapshot.hasError) {
                                    return const Text('ERROU');
                                  }

                                  return const CircularProgressIndicator();
                                },
                              ),
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
                              Text(
                                isNameReturn != null
                                    ? '$isNameReturn'
                                    : 'Nome Inválido',
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
                              Text(
                                isEmailReturn != null
                                    ? '$isEmailReturn'
                                    : 'Email Inválido',
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
                                'Tipo da Simulação',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                isWarrantyResult == true
                                    ? "Com Garantia"
                                    : 'Sem Garantia',
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
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 1,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:
                            Theme
                                .of(context)
                                .primaryColor, // Background color
                          ),
                          child: const Text(
                            "Nova simulação",
                            style:
                            TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
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
        } else if (snapshot.hasError) {
          return const Text('ERROU');
        }  else {
          return const LoadingScreen();
        }
        },
    );
  }

  getDataValueSelected() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double valueSelected = prefs.getDouble('valueSelected') ?? 000.000;
    int? percentValueSelected = prefs.getInt('percentValue');
    int? quantityValueSelected = prefs.getInt('quantityValue');
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
      quantitySelectedReturn = quantityValueSelected.toString();
      isWarrantyResult = isWarrantySelected;
      isEmailReturn = emailValue.toString();
      isNameReturn = nameValue.toString();
      dataValidateResult = formattedDate;
    });
  }

  Future<UserSolicitationModel> fetchApi() async {
    final response = await http
        .get(Uri.parse('https://random-data-api.com/api/omniauth/github_get'));
    if (response.statusCode == 200) {
      print('response ${response.body}');
      return UserSolicitationModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
