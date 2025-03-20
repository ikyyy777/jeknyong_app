import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/utils/scale_helper.dart';

class DaftarKatasandiFormWidget extends StatefulWidget {
  const DaftarKatasandiFormWidget({super.key});

  @override
  State<DaftarKatasandiFormWidget> createState() =>
      _DaftarKatasandiFormWidgetState();
}

class _DaftarKatasandiFormWidgetState extends State<DaftarKatasandiFormWidget> {
  late ScaleHelper _scaleHelper;
  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    _scaleHelper = ScaleHelper(
      figmaWidth: 360,
      screenWidth: MediaQuery.of(context).size.width,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kata Sandi',
          style: TextStyleConstant.textStyleReguler.copyWith(
            fontSize: _scaleHelper.scaleText(14),
            color: ColorConstant.blackColor,
          ),
        ),
        SizedBox(height: _scaleHelper.scaleHeight(4)),
        SizedBox(
          height: _scaleHelper.scaleHeight(60),
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
                  _scaleHelper.scaleWidth(10),
                ),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstant.borderColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  _scaleHelper.scaleWidth(10),
                ),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstant.borderColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  _scaleHelper.scaleWidth(10),
                ),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstant.borderColor,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: _scaleHelper.scaleHeight(16)),

        Text(
          'Konfirmasi Kata Sandi',
          style: TextStyleConstant.textStyleReguler.copyWith(
            fontSize: _scaleHelper.scaleText(14),
            color: ColorConstant.blackColor,
          ),
        ),
        SizedBox(height: _scaleHelper.scaleHeight(4)),
        SizedBox(
          height: _scaleHelper.scaleHeight(60),
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
                  _scaleHelper.scaleWidth(10),
                ),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstant.borderColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  _scaleHelper.scaleWidth(10),
                ),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstant.borderColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  _scaleHelper.scaleWidth(10),
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
