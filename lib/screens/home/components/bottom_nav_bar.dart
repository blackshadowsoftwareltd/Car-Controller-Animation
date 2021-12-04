import 'package:animationzz/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.selectedTab,
    required this.onPressed,
  }) : super(key: key);
  final int selectedTab;
  final ValueChanged<int> onPressed;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: onPressed,
        currentIndex: selectedTab,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: List.generate(
            navIconSrc.length,
            (index) => BottomNavigationBarItem(
                label: '',
                icon: SvgPicture.asset(navIconSrc[index],
                    height: 30,
                    color: index == selectedTab
                        ? primaryColor
                        : Colors.white54))));
  }
}
