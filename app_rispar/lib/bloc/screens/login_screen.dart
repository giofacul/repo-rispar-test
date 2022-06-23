import 'package:app_rispar/bloc/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameCTL = TextEditingController();
  TextEditingController emailCTL = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("images/rispar_login.png")),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        children: [
                          const Text(
                            "Simule ",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "agora ",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Crédito rápido, fácil e seguro! :)",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Row(
                              children: const [
                                Text(
                                  "Qual seu ",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "nome completo?",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          TextFormField(
                            controller: nameCTL,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                              prefixStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold),
                              hintStyle: const TextStyle(
                                  fontSize: 18, color: Colors.grey),
                              hintText: 'Nome Completo',
                            ),
                            validator: (value) {
                              if (value!.isEmpty || !value.contains(' ')) {
                                return 'Preencha o nome';
                              }
                              return null;
                            },
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Row(
                              children: const [
                                Text(
                                  "E seu ",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "e-mail?",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          TextFormField(
                            controller: emailCTL,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                              prefixStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold),
                              hintStyle: const TextStyle(
                                  fontSize: 18, color: Colors.grey),
                              hintText: 'seuemail@email.com',
                            ),
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Preencha o email';
                              }
                              return null;
                            },
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        height: 60,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: enableButton() == true
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.3)
                                  : Theme.of(context)
                                      .primaryColor, // Background color
                            ),
                            child: const Text(
                              "Continuar",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                //TODO SALVAR NOME E EMAIL NO SHARED PREFERENCES

                                Navigator.pushNamed(context, '/home_screen');
                              }
                            }),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool? enableButton() {
    if (nameCTL.text.isEmpty ||
        !nameCTL.text.contains(' ') ||
        emailCTL.text.isEmpty ||
        !emailCTL.text.contains('@')) {
      return true;
    }
    return false;
  }
}
