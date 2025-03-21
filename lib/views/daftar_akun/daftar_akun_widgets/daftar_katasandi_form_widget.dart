import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class DaftarKatasandiFormWidget extends StatefulWidget {
  const DaftarKatasandiFormWidget({super.key});

  @override
  State<DaftarKatasandiFormWidget> createState() =>
      _DaftarKatasandiFormWidgetState();
}

class _DaftarKatasandiFormWidgetState extends State<DaftarKatasandiFormWidget> {
  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kata Sandi',
          style: TextStyleConstant.textStyleRegular.copyWith(
            fontSize: scaleHelper.scaleText(14),
            color: ColorConstant.blackColor,
          ),
        ),
        SizedBox(height: scaleHelper.scaleHeight(4)),
        SizedBox(
          height: scaleHelper.scaleHeight(60),
          child: TextField(
            obscureText: _isObscurePassword,
            decoration: InputDecoration(
              hintText: "Masukkan Kata Sandi",
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: ColorConstant.lightTextColor,
                ),
                onPressed: () {
                  setState(() {
                    _isObscurePassword = !_isObscurePassword;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  scaleHelper.scaleWidth(10),
                ),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstant.borderColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  scaleHelper.scaleWidth(10),
                ),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstant.borderColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  scaleHelper.scaleWidth(10),
                ),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstant.borderColor,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: scaleHelper.scaleHeight(16)),

        Text(
          'Konfirmasi Kata Sandi',
          style: TextStyleConstant.textStyleRegular.copyWith(
            fontSize: scaleHelper.scaleText(14),
            color: ColorConstant.blackColor,
          ),
        ),
        SizedBox(height: scaleHelper.scaleHeight(4)),
        SizedBox(
          height: scaleHelper.scaleHeight(60),
          child: TextField(
            obscureText: _isObscureConfirmPassword,
            decoration: InputDecoration(
              hintText: "Masukkan Kata Sandi",
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: ColorConstant.lightTextColor,
                ),
                onPressed: () {
                  setState(() {
                    _isObscureConfirmPassword = !_isObscureConfirmPassword;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  scaleHelper.scaleWidth(10),
                ),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstant.borderColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  scaleHelper.scaleWidth(10),
                ),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstant.borderColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  scaleHelper.scaleWidth(10),
                ),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstant.borderColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
