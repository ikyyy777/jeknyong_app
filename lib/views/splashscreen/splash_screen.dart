import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to ensure the context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final scaleController = Provider.of<ScaleFactorController>(context, listen: false);
      scaleController.initScaleHelper(context);
      
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/login');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaleHelper = Provider.of<ScaleFactorController>(context).scaleHelper;

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: Center(
        child: Image.asset('assets/images/logo.png', width: scaleHelper.scaleWidth(100)),
      ),
    );
  }
}