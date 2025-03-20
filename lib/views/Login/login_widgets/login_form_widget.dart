import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/utils/scale_helper.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  bool _isObscure = true;
  late ScaleHelper _scaleHelper;

  @override
  void initState() {
    super.initState();
  }

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
          'Masuk Akun',
          style: TextStyleConstant.textStyleSemiBold.copyWith(
            fontSize: _scaleHelper.scaleText(24),
          ),
        ),
        SizedBox(height: _scaleHelper.scaleHeight(8)),
        Text(
          "Masukan Informasi Akun berikut",
          style: TextStyleConstant.textStyleReguler.copyWith(
            fontSize: _scaleHelper.scaleText(14),
            color: ColorConstant.lightTextColor,
          ),
        ),
        SizedBox(height: _scaleHelper.scaleHeight(24)),
        Text(
          "Username",
          style: TextStyleConstant.textStyleReguler.copyWith(
            fontSize: _scaleHelper.scaleText(14),
          ),
        ),
        SizedBox(height: _scaleHelper.scaleHeight(4)),
        SizedBox(
          height: _scaleHelper.scaleHeight(60),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Masukkan Username",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_scaleHelper.scaleWidth(10)),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstant.borderColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_scaleHelper.scaleWidth(10)),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstant.borderColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_scaleHelper.scaleWidth(10)),
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
          "Kata Sandi",
          style: TextStyleConstant.textStyleReguler.copyWith(
            fontSize: _scaleHelper.scaleText(14),
          ),
        ),
        SizedBox(height: _scaleHelper.scaleHeight(4)),
        SizedBox(
          height: _scaleHelper.scaleHeight(60),
          child: TextField(
            obscureText: _isObscure,
            decoration: InputDecoration(
              hintText: "Masukkan Kata Sandi",
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                  color: ColorConstant.lightTextColor,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_scaleHelper.scaleWidth(10)),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstant.borderColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_scaleHelper.scaleWidth(10)),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstant.borderColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_scaleHelper.scaleWidth(10)),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstant.borderColor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: _scaleHelper.scaleHeight(16)),
        GestureDetector(
          onTap: () {
            // Tambahkan logika untuk mengarahkan ke halaman lupa password
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Lupa Password?",
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: _scaleHelper.scaleText(14),
                color: ColorConstant.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
