import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<Widget> tyres(BoxConstraints constraints) {
  return [
    Positioned(
        left: constraints.maxWidth * .22,
        top: constraints.maxHeight * .22,
        child: SvgPicture.asset('assets/icons/FL_Tyre.svg')),
    Positioned(
        right: constraints.maxWidth * .22,
        top: constraints.maxHeight * .22,
        child: SvgPicture.asset('assets/icons/FL_Tyre.svg')),
    Positioned(
        left: constraints.maxWidth * .23,
        bottom: constraints.maxHeight * .22,
        child: SvgPicture.asset('assets/icons/FL_Tyre.svg')),
    Positioned(
        right: constraints.maxWidth * .23,
        bottom: constraints.maxHeight * .22,
        child: SvgPicture.asset('assets/icons/FL_Tyre.svg')),
  ];
}
