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
        child: SizedBox(
          height: 80.0,
          width: 80.0,
          child: Icon(
            Icons.light_mode_outlined,
            color: Theme.of(context).primaryColor,
            size: 40,
          ),
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
