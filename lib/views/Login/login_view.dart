import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/utils/scale_helper.dart';
import 'package:jeknyong_app/views/Login/login_widgets/login_button_widget.dart';
import 'package:jeknyong_app/views/Login/login_widgets/login_daftar_widget.dart';
import 'package:jeknyong_app/views/Login/login_widgets/login_form_widget.dart';
import 'package:jeknyong_app/views/Login/login_widgets/login_google_button_widget.dart';
import 'package:jeknyong_app/views/Login/login_widgets/login_logo_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late ScaleHelper _scaleHelper;
    
  @override
  Widget build(BuildContext context) {
    _scaleHelper = ScaleHelper(
      figmaWidth: 360,
      screenWidth: MediaQuery.of(context).size.width,
    );

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: _scaleHelper.scaleHeight(24)),
              LoginLogoWidget(),
              SizedBox(height: _scaleHelper.scaleHeight(24)),
              LoginFormWidget(),
              SizedBox(height: _scaleHelper.scaleHeight(24)),
              LoginButtonWidget(),
              SizedBox(height: _scaleHelper.scaleHeight(16)),
              LoginGoogleButtonWidget(),
              SizedBox(height: _scaleHelper.scaleHeight(40)),
              LoginDaftarWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
