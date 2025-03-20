import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/utils/navigation_service.dart';
import 'package:jeknyong_app/utils/scale_helper.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ScaleHelper _scaleHelper;

  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to ensure the context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navigationService = Provider.of<NavigationService>(context, listen: false);
      Future.delayed(const Duration(seconds: 3), () {
        navigationService.navigateTo('/login');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _scaleHelper = ScaleHelper(
      figmaWidth: 360,
      screenWidth: MediaQuery.of(context).size.width,
    );

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: Center(
        child: Image.asset('assets/images/logo.png', width: _scaleHelper.scaleWidth(100)),
      ),
    );
  }
}