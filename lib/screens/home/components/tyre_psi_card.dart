import 'package:animationzz/constants/constants.dart';
import 'package:animationzz/models/tyre_psi.dart';
import 'package:flutter/material.dart';

class TyrePsiCard extends StatelessWidget {
  const TyrePsiCard({
    Key? key,
    required this.isBottomTwoTyre,
    required this.tyrePsi,
  }) : super(key: key);
  final TyrePsi tyrePsi;
  final bool isBottomTwoTyre;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: tyrePsi.isLowPressure
                ? Colors.red.withOpacity(.15)
                : Colors.white12,
            border: Border.all(
                color: tyrePsi.isLowPressure ? Colors.red : primaryColor,
                width: 2),
            borderRadius: BorderRadius.circular(8)),
        child: !isBottomTwoTyre
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                psiText(psi: tyrePsi.psi, temp: tyrePsi.temp),
                const Spacer(flex: 1),
                pressureText(isLow: tyrePsi.isLowPressure)
              ])
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                pressureText(isLow: tyrePsi.isLowPressure),
                const Spacer(flex: 1),
                psiText(psi: tyrePsi.psi, temp: tyrePsi.temp)
              ]));
  }

  Widget psiText({required double psi, required int temp}) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text.rich(TextSpan(
            text: psi.toString(),
            style: mediumStyle,
            children: const [TextSpan(text: ' psi', style: smallStyle)])),
        const SizedBox(height: 20),
        Text('$temp\u2103', style: smallStyle),
      ]);

  Widget pressureText({required bool isLow}) => Column(children: [
        Text(isLow ? 'Low' : 'High'.toUpperCase(), style: largeStyle),
        Text('Pressure'.toUpperCase(), style: smallStyle)
      ]);
}
