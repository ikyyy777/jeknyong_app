import 'package:flutter/material.dart';
import 'package:jeknyong_app/utils/scale_helper.dart';

class LengkapiDataView extends StatefulWidget {
  const LengkapiDataView({super.key});

  @override
  State<LengkapiDataView> createState() => _LengkapiDataViewState();
}

class _LengkapiDataViewState extends State<LengkapiDataView> {
  late ScaleHelper _scaleHelper;
  @override
  Widget build(BuildContext context) {
    _scaleHelper = ScaleHelper(
      figmaWidth: 360,
      screenWidth: MediaQuery.of(context).size.width,
    );
    return const Placeholder();
  }
}