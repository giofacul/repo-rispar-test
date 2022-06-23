import 'package:flutter/material.dart';

class CustomSliderTheme extends StatelessWidget {
  final Widget child;

  const CustomSliderTheme({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double thumbRadius = 14;
    final double marksRadius = 8;

    final activeColor = Theme.of(context).primaryColor;
    final inactiveCoolor = Colors.grey;

    return SliderTheme(
        data: SliderThemeData(
          trackHeight: 4,

          //thumb
          thumbShape: RoundSliderThumbShape(
            disabledThumbRadius: thumbRadius,
            enabledThumbRadius: thumbRadius,
          ),
          rangeThumbShape: RoundRangeSliderThumbShape(
              disabledThumbRadius: thumbRadius,
              enabledThumbRadius: thumbRadius),

          //marks
          tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: marksRadius),

          //inactive
          inactiveTickMarkColor: inactiveCoolor,
          inactiveTrackColor: inactiveCoolor,

          //active
          activeTickMarkColor: activeColor,
          activeTrackColor: activeColor,
          thumbColor: activeColor,
        ),
        child: child);
  }
}