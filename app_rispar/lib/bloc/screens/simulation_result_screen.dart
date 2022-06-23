import 'package:app_rispar/bloc/screens/custom_app_bar.dart';
import 'package:app_rispar/bloc/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SimulationResultScreen extends StatefulWidget {
  const SimulationResultScreen({Key? key}) : super(key: key);

  @override
  State<SimulationResultScreen> createState() => _SimulationResultScreenState();
}

class _SimulationResultScreenState extends State<SimulationResultScreen> {
  //TODO TRAZER DADOS DE RETORNO DA API
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomTopAppBar(
        valueProgressAppBar: 1,
        isResultPageReturn: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: Text(
                "Resultado da simulação",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Valor Escolhido',
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
                  Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                  Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                  Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Percentual de garantia',
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
                  Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                  Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                  Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                  Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                  Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                  Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                  Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                  Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor, // Background color
                        ),
                        child: Text(
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
