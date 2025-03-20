import 'package:flutter/material.dart';
import 'package:jeknyong_app/utils/scale_helper.dart';

class ScaleFactorController extends ChangeNotifier {
  late ScaleHelper _scaleHelper = ScaleHelper(
    figmaWidth: 360,
    screenWidth: 0,
  );

  void initScaleHelper(BuildContext context) {
    _scaleHelper = ScaleHelper(
      figmaWidth: 360,
      screenWidth: MediaQuery.of(context).size.width,
    );
    notifyListeners();
  }

  ScaleHelper get scaleHelper => _scaleHelper;
}
