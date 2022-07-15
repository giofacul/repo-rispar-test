import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UtilsImageRotate extends StatefulWidget {
  const UtilsImageRotate({Key? key}) : super(key: key);

  @override
  State<UtilsImageRotate> createState() => _UtilsImageRotateState();
}

class _UtilsImageRotateState extends State<UtilsImageRotate>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    animationController?.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: AnimatedBuilder(
        animation: animationController!,
        child: Stack(
          children: [
            SizedBox(
              height: 80.0,
              width: 80.0,
              child: Icon(
                Icons.light_mode_sharp,
                color: Theme.of(context).primaryColor,
                size: 40,
              ),
            ),
            const SizedBox(
              height: 80.0,
              width: 80.0,
              child: Icon(
                Icons.circle,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
        builder: (BuildContext context, Widget? widget) {
          return Transform.rotate(
            angle: animationController!.value * 4,
            child: widget,
          );
        },
      ),
    );
  }
}
