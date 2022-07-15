import 'package:flutter/material.dart';

class CustomSliderTheme extends StatelessWidget {
  final Widget child;

  const CustomSliderTheme({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double thumbRadius = 10;
    const double marksRadius = 6;

    final activeColor = Theme.of(context).primaryColor;
    const inactiveCoolor = Colors.grey;

    return SliderTheme(
        data: SliderThemeData(
          trackHeight: 4,

          //thumb
          thumbShape: const RoundSliderThumbShape(
            disabledThumbRadius: thumbRadius,
            enabledThumbRadius: thumbRadius,
          ),
          rangeThumbShape: const RoundRangeSliderThumbShape(
              disabledThumbRadius: thumbRadius,
              enabledThumbRadius: thumbRadius),

          //marks
          tickMarkShape:
              const RoundSliderTickMarkShape(tickMarkRadius: marksRadius),

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
