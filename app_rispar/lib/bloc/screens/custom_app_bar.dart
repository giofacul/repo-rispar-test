import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double valueProgressAppBar;
  final bool? isResultPageReturn;
  final String? navigatorBackScreen;

  const CustomTopAppBar(
      {Key? key,
      required this.valueProgressAppBar,
      this.isResultPageReturn,
      this.navigatorBackScreen})
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
            icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
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
          ),
          actions: widget.isResultPageReturn == true
              ? [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      icon: const Icon(Icons.logout_rounded),
                      color: Theme.of(context).primaryColor,
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString('nameUser', '');
                        prefs.setString('emailUser', '');
                        prefs.setDouble('emailUser', 000.000);
                        Navigator.pushNamed(context, '/login_screen');
                      },
                    ),
                  )
                ]
              : null,
        ),
      ),
    );
  }
}
