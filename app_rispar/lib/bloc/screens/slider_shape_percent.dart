import 'package:app_rispar/bloc/screens/custom_slider_theme.dart';
import 'package:app_rispar/bloc/screens/utils/utils.dart';
import 'package:flutter/material.dart';

class SliderShapePercent extends StatefulWidget {
  const SliderShapePercent({Key? key}) : super(key: key);

  @override
  State<SliderShapePercent> createState() => _SliderShapePercentState();
}

class _SliderShapePercentState extends State<SliderShapePercent> {
  int indexSlider = 0;

  @override
  Widget build(BuildContext context) => CustomSliderTheme(child: buildSlider());

  Widget buildSlider() {
    final labels = ['20%', '35%', '50%'];
    final double min = 0;
    final double max = labels.length - 1.0;
    final divisions = labels.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Slider(
            value: indexSlider.toDouble(),
            min: min,
            max: max,
            divisions: divisions,
            label: labels[indexSlider],
            onChanged: (value) =>
                setState(() => this.indexSlider = value.toInt()),

          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: Utils.modelBuilder(labels, (index, model){
                  final selectedColor = Colors.black;
                  final unselectedColor = Colors.black.withOpacity(0.3);
                  //TODO PEGAR VALOR SELECIONADO PARA PARCELA
                  final isSelected = index <= indexSlider;
                  final color = isSelected ? selectedColor : unselectedColor;

                  return buildLabel(label: model.toString(), color: color, width: 40);
                })),
          ),
        ],
      ),
    );
  }

  Widget buildLabel({
    required String label,
    required double width,
    required Color color,
  }) =>
      Container(
        width: width,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ).copyWith(color: color),
        ),
      );
}
