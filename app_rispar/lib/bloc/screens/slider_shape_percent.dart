import 'package:app_rispar/bloc/screens/custom_slider_theme.dart';
import 'package:app_rispar/bloc/screens/utils/utils.dart';
import 'package:flutter/material.dart';

class SliderShapePercent extends StatefulWidget {
  final ValueChanged<int> onChangedPercent;

  const SliderShapePercent({Key? key, required this.onChangedPercent})
      : super(key: key);

  @override
  State<SliderShapePercent> createState() => _SliderShapePercentState();
}

class _SliderShapePercentState extends State<SliderShapePercent> {
  int indexSlider = 0;

  @override
  Widget build(BuildContext context) => CustomSliderTheme(child: buildSlider());

  Widget buildSlider() {
    final labels = ['20%', '35%', '50%'];
    const double min = 0;
    final double max = labels.length - 1.0;
    final divisions = labels.length - 1;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Slider(
          value: indexSlider.toDouble(),
          min: min,
          max: max,
          divisions: divisions,
          label: labels[indexSlider],
          onChanged: (value) => setState(() {
            indexSlider = value.toInt();
            widget.onChangedPercent(indexSlider);
            switch (indexSlider) {
              case 1:
                widget.onChangedPercent(35);
                break;
              case 2:
                widget.onChangedPercent(50);
                break;
              default:
                widget.onChangedPercent(20);
                break;
            }
          }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: Utils.modelBuilder(
            labels,
            (index, model) {
              const selectedColor = Colors.black;
              final unselectedColor = Colors.black.withOpacity(0.3);
              final isSelected = index <= indexSlider;
              final color = isSelected ? selectedColor : unselectedColor;

              return buildLabel(
                  label: model.toString(), color: color, width: 40);
            },
          ),
        ),
      ],
    );
  }

  Widget buildLabel({
    required String label,
    required double width,
    required Color color,
  }) =>
      SizedBox(
        width: width,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ).copyWith(color: color),
        ),
      );
}
