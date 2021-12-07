import 'package:animationzz/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TempButton extends StatelessWidget {
  const TempButton({
    Key? key,
    required this.svgSrc,
    this.isActive = false,
    this.activeColor = primaryColor,
    required this.onPressed,
    required this.title,
  }) : super(key: key);
  final String title, svgSrc;
  final bool isActive;
  final VoidCallback onPressed;
  final Color activeColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Column(children: [
          AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutBack,
              height: isActive ? 70 : 50,
              width: isActive ? 70 : 50,
              child: SvgPicture.asset(svgSrc,
                  color: isActive ? activeColor : Colors.white54)),
          const SizedBox(height: defaultPadding / 2),
          AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 500),
              style: TextStyle(
                  color: isActive ? activeColor : Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1),
              child: Text(title.toUpperCase()))
        ]));
  }
}
