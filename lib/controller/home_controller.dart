import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier {
  int selectedBottomTab = 0;

  bool isRightDoorLock = true;
  bool isLeftDoorLock = true;
  bool isTopDoorLock = true;
  bool isBottomDoorLock = true;

  bool isCoolSelected = true;

  bool isShowTyre = false;

  bool isShowTyreStatus = false;

  void updateRightDoorLock() {
    isRightDoorLock = !isRightDoorLock;
    notifyListeners();
  }

  void updateLeftDoorLock() {
    isLeftDoorLock = !isLeftDoorLock;
    notifyListeners();
  }

  void updateTopDoorLock() {
    isTopDoorLock = !isTopDoorLock;
    notifyListeners();
  }

  void updateBottomDoorLock() {
    isBottomDoorLock = !isBottomDoorLock;
    notifyListeners();
  }

  setSelectedBottomTab(value) {
    selectedBottomTab = value;
    notifyListeners();
  }

  void updateCoolSelectedTab() {
    isCoolSelected = !isCoolSelected;
    notifyListeners();
  }

  void showTyreController(int index) {
    if (selectedBottomTab != 3 && index == 3) {
      Future.delayed(
          const Duration(milliseconds: 400), () => isShowTyre = true);
    } else {
      isShowTyre = false;
    }
    notifyListeners();
  }

  void tyreStatusController(int index) {
    if (selectedBottomTab != 3 && index == 3) {
      isShowTyreStatus = true;
    } else {
      Future.delayed(
          const Duration(milliseconds: 800), () => isShowTyreStatus = false);
    }
    notifyListeners();
  }
}
