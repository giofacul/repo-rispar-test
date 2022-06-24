
import 'package:app_rispar/bloc/screens/custom_app_bar.dart';
import 'package:app_rispar/bloc/screens/simulation_value_selected_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textCtrl = TextEditingController();
  final formKeyValue = GlobalKey<FormState>();
  bool enablePrefixText =false;
  bool enableHintText =true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        enableHint();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false, // this is new
        backgroundColor: Colors.white,
        appBar: CustomTopAppBar(valueProgressAppBar: 0.33, navigatorBackScreen: '/login_screen'),
        body: SingleChildScrollView(
          reverse: true, // this is new
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  padding: const EdgeInsets.only(top: 180,bottom: 220),
                  //TODO MASCARA TEXTFORMFIELD
                  child: Form(
                    key: formKeyValue,
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
                      onTap: () {
                        enablePrefix();
                       setState(() {});
                      },
                      textInputAction: TextInputAction.go,
                      onFieldSubmitted: (value) {
                        enableHint();
                      },
                      onChanged: (value){
                        print(value);
                        if(value.length>3){
                          textCtrl.text.toString();
                        }
                        setState(() {});},
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
                        //TODO CENTRALIZAR O HINT
                        hintStyle:
                            const TextStyle(fontSize: 18, color: Colors.grey,),
                       hintText:enableHintText==true?'Digite o valor desejado':'',
                       prefixText: enablePrefixText==true?'R\$':'',
                      ),
                      style: TextStyle(
                          fontSize: 32,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                      controller: textCtrl,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: enableButton() == true?Theme.of(context)
                          .primaryColor.withOpacity(0.3):Theme.of(context)
                          .primaryColor, // Background color
                    ),
                    child: const Text(
                      "Continuar",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    //TODO COLORIR BOTAO
                    onPressed: () {
                      if (formKeyValue.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SimulationValueSelectedScreen(
                                      valueSolicited:
                                          double.parse(textCtrl.text),
                                    )));
                      }
                    },
                  ),
                ),
                Padding( // this is new
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  bool? enableButton() {
    if(textCtrl.text.isEmpty || double.parse(textCtrl.text) <= 500 ||
        double.parse(textCtrl.text) > 300000){
      return true;
    }return false;
  }

  void enableHint() {
    if(textCtrl.text.isEmpty){
      enableHintText = true;
      enablePrefixText = false;
    }
  }

  void enablePrefix() {
    if(textCtrl.text.isEmpty){
      enablePrefixText=true;
      enableHintText=false;
    }
  }
}
