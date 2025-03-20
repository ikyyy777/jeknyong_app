import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/utils/navigation_service.dart';
import 'package:jeknyong_app/utils/scale_helper.dart';
import 'package:provider/provider.dart';

class LoginDaftarWidget extends StatefulWidget {
  const LoginDaftarWidget({super.key});

  @override
  State<LoginDaftarWidget> createState() => _LoginDaftarWidgetState();
}

class _LoginDaftarWidgetState extends State<LoginDaftarWidget> {
  late ScaleHelper _scaleHelper;

  @override
  Widget build(BuildContext context) {
    _scaleHelper = ScaleHelper(
      figmaWidth: 360,
      screenWidth: MediaQuery.of(context).size.width,
    );

    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Belum punya akun? ",
              style: TextStyleConstant.textStyleReguler.copyWith(
                fontSize: _scaleHelper.scaleText(14),
                color: ColorConstant.lightTextColor2,
              ),
            ),
            TextSpan(
              text: "Daftar",
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: _scaleHelper.scaleText(14),
                color: ColorConstant.primaryColor,
              ),
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () {
                      final navigationService = Provider.of<NavigationService>(context, listen: false);
                      navigationService.navigateTo('/daftar-akun');
                    },
            ),
          ],
        ),
      ),
    );
  }
}
