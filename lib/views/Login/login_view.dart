import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/views/login/login_widgets/login_button_widget.dart';
import 'package:jeknyong_app/views/login/login_widgets/login_daftar_widget.dart';
import 'package:jeknyong_app/views/login/login_widgets/login_form_widget.dart';
import 'package:jeknyong_app/views/login/login_widgets/login_google_button_widget.dart';
import 'package:jeknyong_app/views/login/login_widgets/login_logo_widget.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScaleFactorController>().initScaleHelper(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.watch<ScaleFactorController>().scaleHelper;

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: scaleHelper.scaleHeight(24)),
              LoginLogoWidget(),
              SizedBox(height: scaleHelper.scaleHeight(24)),
              LoginFormWidget(),
              SizedBox(height: scaleHelper.scaleHeight(24)), 
              LoginButtonWidget(),
              SizedBox(height: scaleHelper.scaleHeight(16)),
              LoginGoogleButtonWidget(),
              SizedBox(height: scaleHelper.scaleHeight(40)),
              LoginDaftarWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
