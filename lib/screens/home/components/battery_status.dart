import 'package:animationzz/constants/constants.dart';
import 'package:flutter/material.dart';

class BatteryStatus extends StatelessWidget {
  const BatteryStatus({
    Key? key,
    required this.constraints,
  }) : super(key: key);
  final BoxConstraints constraints;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text('220 mi', style: largeStyle),
      const Text('62 %', style: mediumStyle),
      const Spacer(),
      const Text('CHARGING', style: smallStyle),
      const Text('18 min remaining', style: smallStyle),
      SizedBox(height: constraints.maxHeight * .15),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
        Text('22 mi/hr', style: smallStyle),
        Text('243v', style: smallStyle)
      ]),
      const SizedBox(height: defaultPadding)
    ]);
  }
}
