import 'package:app_rispar/bloc/screens/custom_slider_theme.dart';
import 'package:app_rispar/bloc/screens/utils/utils.dart';
import 'package:flutter/material.dart';

class SliderShapeQuantity extends StatefulWidget {
  const SliderShapeQuantity({Key? key}) : super(key: key);

  @override
  State<SliderShapeQuantity> createState() => _SliderShapeQuantityState();
}

class _SliderShapeQuantityState extends State<SliderShapeQuantity> {
  int indexSlider = 0;

  @override
  Widget build(BuildContext context) => CustomSliderTheme(child: buildSlider());

  Widget buildSlider() {
    final labels = ['3', '6', '9', '12'];
    const double min = 0;
    final double max = labels.length - 1.0;
    final divisions = labels.length - 1;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Slider(
          value: indexSlider.toDouble(),
          min: min,
          max: max,
          divisions: divisions,
          label: labels[indexSlider],
          onChanged: (value) => setState(() {
            indexSlider = value.toInt();
            print('alterado p $indexSlider');
          }),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: Utils.modelBuilder(labels, (index, model) {
              const selectedColor = Colors.black;
              final unselectedColor = Colors.black.withOpacity(0.3);
              //TODO PEGAR VALOR SELECIONADO PARA PARCELA
              final isSelected = index <= indexSlider;
              final color = isSelected ? selectedColor : unselectedColor;

              return buildLabel(
                  label: model.toString(), color: color, width: 30);
            })),
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
