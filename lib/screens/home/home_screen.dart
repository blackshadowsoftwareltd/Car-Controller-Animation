import 'package:animationzz/components/door_lock.dart';
import 'package:animationzz/constants/constants.dart';
import 'package:animationzz/controller/home_controller.dart';
import 'package:animationzz/models/tyre_psi.dart';
import 'package:animationzz/screens/home/components/tyars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/battery_status.dart';
import 'components/bottom_nav_bar.dart';
import 'components/temp_details.dart';
import 'components/tyre_psi_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// SingleTickerProviderStateMixin for single animation.
/// TickerProviderStateMixin for multiple animation.
class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _controller = HomeController();

  late AnimationController _batteryAnimationController;
  late AnimationController _tempAnimationController;
  late AnimationController _tyreAnimationController;

  late Animation<double> _batteryAnimation;
  late Animation<double> _batteryStatusAnimation;
  late Animation<double> _carShiftAnimation;
  late Animation<double> _tempInfoShowAnimation;
  late Animation<double> _tempGlowAnimation;

  /// tyre
  late Animation<double> _tyre1PsiAnimation;
  late Animation<double> _tyre2PsiAnimation;
  late Animation<double> _tyre3PsiAnimation;
  late Animation<double> _tyre4PsiAnimation;
  late List<Animation<double>> _tyreAnimations;

  @override
  void initState() {
    super.initState();
    setupBatteryAnimation();
    setupTempAnimation();
    setupTyreAnimation();
    _tyreAnimations = [
      _tyre1PsiAnimation,
      _tyre2PsiAnimation,
      _tyre3PsiAnimation,
      _tyre4PsiAnimation,
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    _tyreAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([
          _controller,
          _batteryAnimationController,
          _tempAnimationController,
          _tyreAnimationController
        ]),
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
                    if (index == 2) {
                      _tempAnimationController.forward();
                    } else if (_controller.selectedBottomTab == 2 &&
                        index != 2) {
                      _tempAnimationController.reverse(from: .4);
                    }
                    if (index == 3) {
                      _tyreAnimationController.forward();
                    } else if (_controller.selectedBottomTab == 3 &&
                        index != 3) {
                      _tyreAnimationController.reverse();
                    }

                    _controller.showTyreController(index);
                    _controller.tyreStatusController(index);

                    /// this line must be bottom from the conditions
                    _controller.setSelectedBottomTab(index);
                  },
                  selectedTab: _controller.selectedBottomTab),

              /// body
              body: SafeArea(
                  child: LayoutBuilder(builder: (context, constraints) {
                return Stack(alignment: Alignment.center, children: [
                  SizedBox(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                  ),

                  /// Car
                  Positioned(
                    left: constraints.maxWidth / 2 * _carShiftAnimation.value,
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: constraints.maxHeight * 0.1),
                        child: SvgPicture.asset('assets/icons/Car.svg',
                            width: double.infinity)),
                  ),

                  /// right doorlock
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

                  /// left doorlock
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

                  /// top doorlock
                  AnimatedPositioned(
                      duration: defaultDuration,
                      top: _controller.selectedBottomTab == 0
                          ? constraints.maxHeight * 0.17
                          : constraints.maxHeight / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                            isLocked: _controller.isTopDoorLock,
                            onPressed: _controller.updateTopDoorLock),
                      )),

                  /// bottom doorlock
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

                  /// Battery
                  AnimatedOpacity(
                      duration: defaultDuration,
                      opacity: _batteryAnimation.value,
                      child: SvgPicture.asset('assets/icons/Battery.svg',
                          width: constraints.maxWidth * .4)),

                  /// Battery status
                  AnimatedPositioned(
                      top: 50 * (1 - _batteryStatusAnimation.value),
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      duration: defaultDuration,
                      child: Opacity(
                          opacity: _batteryStatusAnimation.value,
                          child: BatteryStatus(constraints: constraints))),

                  /// Temp Details
                  Positioned(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      top: 100 * (1 - _tempInfoShowAnimation.value),
                      child: Opacity(
                          opacity: _tempInfoShowAnimation.value,
                          child: TempDetails(controller: _controller))),

                  /// Glow effects
                  Positioned(
                      right: -180 * (1 - _tempGlowAnimation.value),
                      child: AnimatedSwitcher(
                          duration: defaultDuration,
                          child: _controller.isCoolSelected
                              ? Image.asset('assets/images/Cool_glow_2.png',
                                  key: UniqueKey(), width: 200)
                              : Image.asset('assets/images/Hot_glow_4.png',
                                  key: UniqueKey(), width: 200))),

                  /// Tyeres
                  if (_controller.isShowTyre) ...tyres(constraints),

                  /// Tyre Psi Card
                  if (_controller.isShowTyreStatus)
                    GridView.builder(
                        itemCount: demoPsiList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: defaultPadding,
                            crossAxisSpacing: defaultPadding,
                            childAspectRatio:
                                constraints.maxWidth / constraints.maxHeight),
                        itemBuilder: (context, index) => ScaleTransition(
                              scale: _tyreAnimations[index],
                              child: TyrePsiCard(
                                  tyrePsi: demoPsiList[index],
                                  isBottomTwoTyre: index > 1),
                            ))
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

  void setupTempAnimation() {
    _tempAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _carShiftAnimation = CurvedAnimation(
        parent: _tempAnimationController, curve: const Interval(.2, .4));
    _tempInfoShowAnimation = CurvedAnimation(
        parent: _tempAnimationController, curve: const Interval(.45, .7));
    _tempGlowAnimation = CurvedAnimation(
        parent: _tempAnimationController, curve: const Interval(.2, 1));
  }

  void setupTyreAnimation() {
    _tyreAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _tyre1PsiAnimation = CurvedAnimation(
        parent: _tyreAnimationController, curve: const Interval(.34, .5));
    _tyre2PsiAnimation = CurvedAnimation(
        parent: _tyreAnimationController, curve: const Interval(.5, .66));
    _tyre3PsiAnimation = CurvedAnimation(
        parent: _tyreAnimationController, curve: const Interval(.66, .82));
    _tyre4PsiAnimation = CurvedAnimation(
        parent: _tyreAnimationController, curve: const Interval(.82, 1));
  }
}
