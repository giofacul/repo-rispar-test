import 'package:app_rispar/bloc/screens/custom_app_bar.dart';
import 'package:app_rispar/bloc/screens/simulation_value_selected_screen.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final _formKeyValue = GlobalKey<FormState>();
  final text_ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CustomTopAppBar(valueProgressAppBar: 0.33),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "De quanto ",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "você precisa?",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text("Insira um valor entre ",
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    Text("R\$500",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(" a ",
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    Text("R\$300.000",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 80),
                child: Form(
                  key: _formKeyValue,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Preencha o campo';
                      } else if (double.parse(value) <= 500 ||
                          double.parse(value) > 300000) {
                        return 'Valor inválido';
                      }
                      return null;
                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      prefixStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                      prefixText: 'R\$ ',
                      hintStyle:
                          const TextStyle(fontSize: 18, color: Colors.grey),
                      hintText: 'Digite o valor desejado',
                    ),
                    style: TextStyle(
                        fontSize: 32,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                    controller: text_ctrl,
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
                    "Continuar",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  onPressed: () {
                    if (_formKeyValue.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SimulationValueSelectedScreen(
                                    valueSolicited: text_ctrl.text,
                                  )));
                    }
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
