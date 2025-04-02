import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class DaftarAkunButtonWidget extends StatefulWidget {
  const DaftarAkunButtonWidget({super.key});

  @override
  State<DaftarAkunButtonWidget> createState() => _DaftarAkunButtonWidgetState();
}

class _DaftarAkunButtonWidgetState extends State<DaftarAkunButtonWidget> {

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
    return SizedBox(
      width: double.infinity,
      height: scaleHelper.scaleHeight(50),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/lengkapi-data-1');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.lerp(
            ColorConstant.whiteColor,
            ColorConstant.primaryColor,
            0.95,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(scaleHelper.scaleWidth(10)),
            side: BorderSide(width: 1, color: ColorConstant.primaryColor),
          ),
        ),
        child: Text(
          "Daftar Akun",
          style: TextStyleConstant.textStyleSemiBold.copyWith(
            fontSize: scaleHelper.scaleText(16),
            color: ColorConstant.whiteColor,
          ),
        ),
      ),
    );
  }
}
