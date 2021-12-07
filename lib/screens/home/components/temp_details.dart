import 'package:animationzz/constants/constants.dart';
import 'package:animationzz/controller/home_controller.dart';
import 'package:animationzz/screens/home/components/temp_button.dart';
import 'package:flutter/material.dart';

class TempDetails extends StatelessWidget {
  const TempDetails({
    Key? key,
    required HomeController controller,
  })  : _controller = controller,
        super(key: key);

  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          /// Buttons
          const Spacer(flex: 1),
          Row(children: [
            TempButton(
                title: 'Cool',
                svgSrc: 'assets/icons/coolShape.svg',
                isActive: _controller.isCoolSelected,
                onPressed: _controller.updateCoolSelectedTab),
            const SizedBox(width: 5),
            TempButton(
              title: 'Heat',
              svgSrc: 'assets/icons/heatShape.svg',
              isActive: !_controller.isCoolSelected,
              onPressed: _controller.updateCoolSelectedTab,
              activeColor: Colors.red,
            )
          ]),

          /// Temp up & down
          const Spacer(flex: 3),
          Column(children: [
            IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.keyboard_arrow_up,
                    color: Colors.white, size: 50)),
            const Text('29\u2103', style: extraLargeStyle),
            IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.keyboard_arrow_down,
                    color: Colors.white, size: 50))
          ]),

          const Spacer(flex: 3),

          /// Info
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('CURRENT TEMPARATURE', style: extraSmallStyle),
            const SizedBox(height: 10),
            Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Inside'.toUpperCase(), style: extraSmallStyle),
                const Text('20\u2103', style: smallStyle)
              ]),
              const SizedBox(width: defaultPadding * 2),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Inside'.toUpperCase(), style: extraSmallStyle),
                const Text('20\u2103', style: smallStyle)
              ])
            ])
          ]),
          const Spacer(flex: 1)
        ]));
  }
}
