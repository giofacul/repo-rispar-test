import 'package:app_rispar/bloc/screens/custom_app_bar.dart';
import 'package:app_rispar/bloc/screens/simulation_value_selected_screen.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textCtrl = TextEditingController();

  final formKeyValue = GlobalKey<FormState>();
  bool enablePrefixText = false;
  bool enableHintText = true;

  @override
  void initState() {
    super.initState();
    getDataValueSelected();
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return GestureDetector(
      onTap: () {
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        enableHint();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomTopAppBar(
            valueProgressAppBar: 0.33, navigatorBackScreen: '/login_screen'),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "De quanto ",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "voc?? precisa?",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  FittedBox(
                    child: Row(
                      children: const [
                        Text(
                          "Insira um valor entre ",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text("R\$500",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(" a ",
                            style: TextStyle(
                              fontSize: 14,
                            )),
                        Text(
                          "R\$300.000",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Form(
                key: formKeyValue,
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(7),
                    FilteringTextInputFormatter.digitsOnly,
                    RealInputFormatter(),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Preencha o campo';
                    } else if (double.parse(
                                value.replaceAll(RegExp(r"[^\s\w]"), '')) <
                            500 ||
                        double.parse(value.replaceAll(RegExp(r"[^\s\w]"), '')) >
                            300000) {
                      return 'Valor inv??lido';
                    }
                    return null;
                  },
                  onTap: () {
                    enablePrefix();
                    setState(() {});
                  },
                  textInputAction: TextInputAction.go,
                  onFieldSubmitted: (value) {
                    enableHint();
                  },
                  onChanged: (value) {
                    print(textCtrl.text.replaceAll(RegExp(r"[^\s\w]"), ''));
                    setState(() {});
                  },
                  textAlign: TextAlign.left,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      contentPadding: EdgeInsets.zero,
                      prefixStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                      hintStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                      hintText: textCtrl.text.isEmpty
                          ? 'Digite o valor desejado'
                          : '',
                      prefixText: enablePrefixText == true ? 'R\$' : '',
                      suffixIcon: textCtrl.text.isEmpty
                          ? null
                          : IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                textCtrl.clear();
                                setState(() {});
                              },
                            )),
                  style: TextStyle(
                      fontSize: 32,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                  controller: textCtrl,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: enableButton() == true
                        ? Theme.of(context).primaryColor.withOpacity(0.3)
                        : Theme.of(context).primaryColor,
                  ),
                  child: const Text(
                    "Continuar",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  onPressed: () async {
                    if (formKeyValue.currentState!.validate()) {
                      final prefs = await SharedPreferences.getInstance();

                      textCtrl.text.toString();
                      prefs.setDouble(
                          'valueSelected',
                          double.parse(textCtrl.text
                              .replaceAll(RegExp(r"[^\s\w]"), '')));

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }

                      if (!mounted) return;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SimulationValueSelectedScreen()));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool? enableButton() {
    if (textCtrl.text.isEmpty ||
        double.parse(textCtrl.text.replaceAll(RegExp(r"[^\s\w]"), '')) < 500 ||
        double.parse(textCtrl.text.replaceAll(RegExp(r"[^\s\w]"), '')) >
            300000) {
      return true;
    }
    return false;
  }

  enableHint() {
    if (textCtrl.text.isEmpty) {
      enableHintText = true;
      enablePrefixText = false;
    }
  }

  enablePrefix() {
    if (textCtrl.text.isEmpty) {
      enablePrefixText = true;
      enableHintText = false;
    }
  }

  getDataValueSelected() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double valueSelected = prefs.getDouble('valueSelected') ?? 0.0;
    String valor =
        UtilBrasilFields.obterReal(valueSelected, moeda: false, decimal: 0)
            .toString();

    if (valor.isNotEmpty) {
      enablePrefix();
    } else {
      enableHint();
    }

    setState(() {
      textCtrl = TextEditingController(text: valor);
    });
  }
}
