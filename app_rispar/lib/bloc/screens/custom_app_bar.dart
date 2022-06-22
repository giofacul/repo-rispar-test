import 'package:flutter/material.dart';

class CustomTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomTopAppBar({Key? key, required this.valueProgressAppBar}) : super(key: key);

  double valueProgressAppBar;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  State<CustomTopAppBar> createState() => _CustomTopAppBarState();
}

class _CustomTopAppBarState extends State<CustomTopAppBar> {
  double? valueProgressAppBar;

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
                  Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 10, right: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  minHeight: 6,
                  value: valueProgressAppBar,
                  color: Theme.of(context).primaryColor,
                  backgroundColor: Colors.grey,
                ),
              ),
            )),
      ),
    );
  }
}
