import 'package:app_rispar/bloc/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameCTL = TextEditingController();
  TextEditingController emailCTL = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false, // this is new
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          reverse: true, // this is new
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.5,
                child: Image.asset(
                  "images/rispar_login.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                    const SizedBox(height: 16),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Crédito rápido, fácil e seguro! :)",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: const [
                              Text(
                                "Qual seu ",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "nome completo?",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: nameCTL,
                            onChanged: (value) {
                              setState(() {});
                            },
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
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: const [
                              Text(
                                "E seu ",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "e-mail?",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: emailCTL,
                            onChanged: (value) {
                              setState(() {});
                            },
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
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
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
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            if (_formKey.currentState!.validate()) {
                              //TODO SALVAR NOME E EMAIL NO SHARED PREFERENCES
                              prefs.setString('nameUser', nameCTL.text);
                              prefs.setString('emailUser', emailCTL.text);
                              prefs.setBool('isLogged', true);
                              Navigator.pushNamed(context, '/home_screen');
                            }
                          }),
                    ),
                    Padding(
                        // this is new
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom)),
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
