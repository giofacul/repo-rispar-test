import 'package:app_rispar/bloc/screens/custom_app_bar.dart';
import 'package:app_rispar/bloc/screens/home_screen.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SimulationResultScreen extends StatefulWidget {
  const SimulationResultScreen({Key? key}) : super(key: key);

  @override
  State<SimulationResultScreen> createState() => _SimulationResultScreenState();
}

class _SimulationResultScreenState extends State<SimulationResultScreen> {
  String valueSelectedReturn = '000.000';
  String percentSelectedReturn = '20';

  //TODO TRAZER DADOS DE RETORNO DA API

  @override
  void initState() {
    super.initState();
    getDataValueSelected();
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
                          style:  const TextStyle(
                              color: Colors.black38, fontWeight: FontWeight.bold),
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
                          'R\$ [344343]',
                          style: TextStyle(
                              color: Colors.black38, fontWeight: FontWeight.bold),
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
                          'Taxa de juros',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'R\$ [344343]',
                          style: TextStyle(
                              color: Colors.black38, fontWeight: FontWeight.bold),
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
                          'Percentual de garantia',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$percentSelectedReturn%',
                          style: const TextStyle(
                              color: Colors.black38, fontWeight: FontWeight.bold),
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
                          'Primeiro vencimento',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'R\$ [344343]',
                          style: TextStyle(
                              color: Colors.black38, fontWeight: FontWeight.bold),
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
                          'R\$ [344343]',
                          style: TextStyle(
                              color: Colors.black38, fontWeight: FontWeight.bold),
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
                          'Tarifa da plataforma',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'R\$ [344343]',
                          style: TextStyle(
                              color: Colors.black38, fontWeight: FontWeight.bold),
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
                          'Total financiado',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'R\$ [344343]',
                          style: TextStyle(
                              color: Colors.black38, fontWeight: FontWeight.bold),
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
                          'CET mensal',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'R\$ [344343]',
                          style: TextStyle(
                              color: Colors.black38, fontWeight: FontWeight.bold),
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
                              color: Colors.black38, fontWeight: FontWeight.bold),
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
                          'Cotação do BTC',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'R\$ [344343]',
                          style: TextStyle(
                              color: Colors.black38, fontWeight: FontWeight.bold),
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
                      primary: Theme.of(context).primaryColor, // Background color
                    ),
                    child: const Text(
                      "Nova simulação",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
    String valor =
    UtilBrasilFields.obterReal(valueSelected, moeda: false, decimal: 0)
        .toString();
    int percentValueSelected = prefs.getInt('percentValue') ?? 20;


    setState(() {
      valueSelectedReturn = valor;
      percentSelectedReturn = percentValueSelected.toString();
    });
  }
}
