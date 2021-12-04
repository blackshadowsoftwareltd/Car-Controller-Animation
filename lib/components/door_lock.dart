import 'package:animationzz/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoorLock extends StatelessWidget {
  const DoorLock({
    Key? key,
    required this.onPressed,
    required this.isLocked,
  }) : super(key: key);

  final VoidCallback onPressed;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: AnimatedSwitcher(
            duration: defaultDuration,
            switchInCurve: Curves.easeInOutBack,
            transitionBuilder: (chaid, animation) =>
                ScaleTransition(scale: animation, child: chaid),
            child: isLocked
                ? SvgPicture.asset('assets/icons/door_lock.svg',
                    key: const ValueKey('lock'))
                : SvgPicture.asset('assets/icons/door_unlock.svg',
                    key: const ValueKey('unlock'))));
  }
}
