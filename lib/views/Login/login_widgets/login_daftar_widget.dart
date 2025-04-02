import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class LoginDaftarWidget extends StatefulWidget {
  const LoginDaftarWidget({super.key});

  @override
  State<LoginDaftarWidget> createState() => _LoginDaftarWidgetState();
}

class _LoginDaftarWidgetState extends State<LoginDaftarWidget> {
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

    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Belum punya akun? ",
              style: TextStyleConstant.textStyleRegular.copyWith(
                fontSize: scaleHelper.scaleText(14),
                color: ColorConstant.lightTextColor2,
              ),
            ),
            TextSpan(
              text: "Daftar",
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: scaleHelper.scaleText(14),
                color: ColorConstant.primaryColor,
              ),
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, '/daftar-akun');
                    },
            ),
          ],
        ),
      ),
    );
  }
}
