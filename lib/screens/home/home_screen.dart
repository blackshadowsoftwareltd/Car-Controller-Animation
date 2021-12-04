import 'package:animationzz/components/door_lock.dart';
import 'package:animationzz/constants/constants.dart';
import 'package:animationzz/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeController _controller = HomeController();
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, snapshot) {
          return Scaffold(

              /// bottom navigation bar
              bottomNavigationBar:
                  BottomNavBar(onPressed: (index) {}, selectedTab: 0),

              /// body
              body: SafeArea(
                  child: LayoutBuilder(builder: (context, constraints) {
                return Stack(alignment: Alignment.center, children: [
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: constraints.maxHeight * 0.1),
                      child: SvgPicture.asset('assets/icons/Car.svg',
                          width: double.infinity)),
                  Positioned(
                      right: constraints.maxWidth * 0.03,
                      child: DoorLock(
                          isLocked: _controller.isRightDoorLock,
                          onPressed: _controller.updateRightDoorLock)),
                  Positioned(
                      left: constraints.maxWidth * 0.03,
                      child: DoorLock(
                          isLocked: _controller.isLeftDoorLock,
                          onPressed: _controller.updateLeftDoorLock)),
                  Positioned(
                      top: constraints.maxHeight * 0.13,
                      child: DoorLock(
                          isLocked: _controller.isTopDoorLock,
                          onPressed: _controller.updateTopDoorLock)),
                  Positioned(
                      bottom: constraints.maxHeight * 0.17,
                      child: DoorLock(
                          isLocked: _controller.isBottomDoorLock,
                          onPressed: _controller.updateBottomDoorLock)),
                ]);
              })));
        });
  }
}
