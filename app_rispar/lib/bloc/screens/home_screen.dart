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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 30.0, top: 10.0),
                child: Column(
                  children: [
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    FittedBox(
                      child: Row(
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
                          Text(
                            "R\$300.000",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                      return 'Valor inválido';
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
                        fontSize: 18,
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
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: enableButton() == true
                        ? Theme.of(context).primaryColor.withOpacity(0.3)
                        : Theme.of(context).primaryColor, // Background color
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

  void enableHint() {
    if (textCtrl.text.isEmpty) {
      enableHintText = true;
      enablePrefixText = false;
    }
  }

  void enablePrefix() {
    if (textCtrl.text.isEmpty) {
      enablePrefixText = true;
      enableHintText = false;
    }
  }
}
