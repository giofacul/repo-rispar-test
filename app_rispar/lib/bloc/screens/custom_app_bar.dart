import 'package:app_rispar/bloc/screens/simulation_value_selected_screen.dart';
import 'package:flutter/material.dart';

class CustomTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double valueProgressAppBar;
  final bool? isResultPageReturn;
  final String? navigatorBackScreen;

  CustomTopAppBar(
      {Key? key, required this.valueProgressAppBar, this.isResultPageReturn, this.navigatorBackScreen})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  State<CustomTopAppBar> createState() => _CustomTopAppBarState();
}

class _CustomTopAppBarState extends State<CustomTopAppBar> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon:
              //TODO RETORNAR DADOS DO SHARED P/ LOGIN QUANDO FAZER LOGOF NO VOLTAR
              //TODO INSERIR MODAL PARA FAZER LOGOFF NA SETA
              Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
              onPressed: () {
                if (widget.isResultPageReturn == true) {
                  Navigator.pushNamed(context, '/simulation_value');
                } else {
                  Navigator.pushNamed(context, widget.navigatorBackScreen!);
                }
              },
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 10, right: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  minHeight: 6,
                  value: widget.valueProgressAppBar,
                  color: Theme.of(context).primaryColor,
                  backgroundColor: Colors.grey,
                ),
              ),
            )),
      ),
    );
  }
}
