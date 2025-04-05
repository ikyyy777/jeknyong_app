import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class DaftarKebijakanWidget extends StatefulWidget {
  const DaftarKebijakanWidget({super.key});

  @override
  State<DaftarKebijakanWidget> createState() => _DaftarKebijakanWidgetState();
}

class _DaftarKebijakanWidgetState extends State<DaftarKebijakanWidget> {
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

    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "Dengan mendaftar, Anda menyetujui ",
              style: TextStyleConstant.textStyleRegular.copyWith(
                fontSize: scaleHelper.scaleText(14),
                color: ColorConstant.lightTextColor2,
              ),
            ),
            TextSpan(
              text: "Ketentuan Layanan ",
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: scaleHelper.scaleText(14),
                color: ColorConstant.primaryColor,
              ),
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () {
                      //TODO: Tambahkan logika untuk mengarahkan ke halaman ketentuan layanan
                    },
            ),
            TextSpan(
              text: "dan ",
              style: TextStyleConstant.textStyleRegular.copyWith(
                fontSize: scaleHelper.scaleText(14),
                color: ColorConstant.lightTextColor2,
              ),
            ),
            TextSpan(
              text: "Kebijakan Privasi. ",
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: scaleHelper.scaleText(14),
                color: ColorConstant.primaryColor,
              ),
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () {
                      //TODO: Tambahkan logika untuk mengarahkan ke halaman kebijakan privasi
                    },
            ),
          ],
        ),
      ),
    );
  }
}
