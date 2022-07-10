import 'package:app_rispar/bloc/helpers/lower_case_text_formatter.dart';
import 'package:email_validator/email_validator.dart';
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
  void initState() {
    super.initState();
    getDataInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1.4,
                    child: Image.asset(
                      "assets/images/rispar_login.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
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
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.08),
                              Row(
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
                              TextFormField(
                                textCapitalization: TextCapitalization.words,
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
                                  suffixIcon: nameCTL.text.isEmpty
                                      ? null
                                      : IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          onPressed: () async {
                                            final prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            nameCTL.clear();
                                            prefs.setString('nameUser', '');
                                            setState(() {});
                                          },
                                        ),
                                ),
                                validator: (value) {
                                  if (!value!.contains(RegExp(
                                      r"^([a-zA-Z]{2,}\s[a-zA-z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)"))) {
                                    return 'Preencha o nome corretamente';
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
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              TextFormField(
                                inputFormatters: [
                                  LowerCaseTextFormatter(),
                                ],
                                textCapitalization: TextCapitalization.none,
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
                                  suffixIcon: emailCTL.text.isEmpty
                                      ? null
                                      : IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          onPressed: () async {
                                            final prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            emailCTL.clear();
                                            prefs.setString('emailUser', '');
                                            setState(() {});
                                          },
                                        ),
                                ),
                                validator: (value) {
                                  if (!EmailValidator.validate(emailCTL.text)) {
                                    return 'Preencha o email corretamente';
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
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
                              final prefs =
                                  await SharedPreferences.getInstance();
                              if (_formKey.currentState!.validate()) {
                                prefs.setString('nameUser', nameCTL.text);
                                prefs.setString('emailUser', emailCTL.text);
                                prefs.setBool('isLogged', true);
                                if (!mounted) return;
                                Navigator.pushNamed(context, '/home_screen');
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool? enableButton() {
    if (nameCTL.text.isEmpty ||
        !nameCTL.text.contains(RegExp(
            r"^([a-zA-Z]{2,}\s[a-zA-z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)")) ||
        emailCTL.text.isEmpty ||
        !EmailValidator.validate(emailCTL.text)) {
      return true;
    }
    return false;
  }

  getDataInitialized() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('nameUser') ?? '';
    final email = prefs.getString('emailUser') ?? '';

    setState(() {
      nameCTL = TextEditingController(text: name);
      emailCTL = TextEditingController(text: email);
    });
  }
}
