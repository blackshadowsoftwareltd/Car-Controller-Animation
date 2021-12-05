import 'package:animationzz/components/door_lock.dart';
import 'package:animationzz/constants/constants.dart';
import 'package:animationzz/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/battery_status.dart';
import 'components/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final HomeController _controller = HomeController();
  late AnimationController _batteryAnimationController;
  late Animation<double> _batteryAnimation;
  late Animation<double> _batteryStatusAnimation;
  @override
  void initState() {
    super.initState();
    setupBatteryAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    _batteryAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([_controller, _batteryAnimationController]),
        builder: (context, snapshot) {
          return Scaffold(

              /// bottom navigation bar
              bottomNavigationBar: BottomNavBar(
                  onPressed: (index) {
                    if (index == 1) {
                      _batteryAnimationController.forward();
                    } else if (_controller.selectedBottomTab == 1 &&
                        index != 1) {
                      _batteryAnimationController.reverse();
                    }

                    /// this line must be bottom from the conditions
                    _controller.setSelectedBottomTab(index);
                  },
                  selectedTab: _controller.selectedBottomTab),

              /// body
              body: SafeArea(
                  child: LayoutBuilder(builder: (context, constraints) {
                return Stack(alignment: Alignment.center, children: [
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: constraints.maxHeight * 0.1),
                      child: SvgPicture.asset('assets/icons/Car.svg',
                          width: double.infinity)),
                  AnimatedPositioned(
                      duration: defaultDuration,
                      right: _controller.selectedBottomTab == 0
                          ? constraints.maxWidth * 0.03
                          : constraints.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                            isLocked: _controller.isRightDoorLock,
                            onPressed: _controller.updateRightDoorLock),
                      )),
                  AnimatedPositioned(
                      duration: defaultDuration,
                      left: _controller.selectedBottomTab == 0
                          ? constraints.maxWidth * 0.03
                          : constraints.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                            isLocked: _controller.isLeftDoorLock,
                            onPressed: _controller.updateLeftDoorLock),
                      )),
                  AnimatedPositioned(
                      duration: defaultDuration,
                      top: _controller.selectedBottomTab == 0
                          ? constraints.maxHeight * 0.13
                          : constraints.maxHeight / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                            isLocked: _controller.isTopDoorLock,
                            onPressed: _controller.updateTopDoorLock),
                      )),
                  AnimatedPositioned(
                      duration: defaultDuration,
                      bottom: _controller.selectedBottomTab == 0
                          ? constraints.maxHeight * 0.17
                          : constraints.maxHeight / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                            isLocked: _controller.isBottomDoorLock,
                            onPressed: _controller.updateBottomDoorLock),
                      )),
                  AnimatedOpacity(
                      duration: defaultDuration,
                      opacity: _batteryAnimation.value,
                      child: SvgPicture.asset('assets/icons/Battery.svg',
                          width: constraints.maxWidth * .4)),
                  AnimatedPositioned(
                      top: 50 * (1 - _batteryStatusAnimation.value),
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      duration: defaultDuration,
                      child: Opacity(
                          opacity: _batteryStatusAnimation.value,
                          child: BatteryStatus(constraints: constraints)))
                ]);
              })));
        });
  }

  void setupBatteryAnimation() {
    _batteryAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _batteryAnimation = CurvedAnimation(
        parent: _batteryAnimationController, curve: const Interval(0, .5));
    _batteryStatusAnimation = CurvedAnimation(
        parent: _batteryAnimationController, curve: const Interval(.6, 1));
  }
}
