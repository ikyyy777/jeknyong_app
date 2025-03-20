import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/global_widget/text_form_field_global_widget.dart';
import 'package:provider/provider.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  bool _isObscure = true;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScaleFactorController>().initScaleHelper(context);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.watch<ScaleFactorController>().scaleHelper;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Masuk Akun',
          style: TextStyleConstant.textStyleSemiBold.copyWith(
            fontSize: scaleHelper.scaleText(24),
          ),
        ),
        SizedBox(height: scaleHelper.scaleHeight(8)),
        Text(
          "Masukan Informasi Akun berikut",
          style: TextStyleConstant.textStyleReguler.copyWith(
            fontSize: scaleHelper.scaleText(14),
            color: ColorConstant.lightTextColor,
          ),
        ),
        SizedBox(height: scaleHelper.scaleHeight(24)),
        Text(
          "Username",
          style: TextStyleConstant.textStyleReguler.copyWith(
            fontSize: scaleHelper.scaleText(14),
          ),
        ),
        SizedBox(height: scaleHelper.scaleHeight(4)),
        TextFormFieldGlobalWidget(controller: _controller, hintText: 'Masukkan Username'),

        SizedBox(height: scaleHelper.scaleHeight(16)),
        Text(
          "Kata Sandi",
          style: TextStyleConstant.textStyleReguler.copyWith(
            fontSize: scaleHelper.scaleText(14),
          ),
        ),
        SizedBox(height: scaleHelper.scaleHeight(4)),
        SizedBox(
          height: scaleHelper.scaleHeight(60),
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
                borderRadius: BorderRadius.circular(scaleHelper.scaleWidth(10)),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstant.borderColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(scaleHelper.scaleWidth(10)),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstant.borderColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(scaleHelper.scaleWidth(10)),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstant.borderColor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: scaleHelper.scaleHeight(16)),
        GestureDetector(
          onTap: () {
            // Tambahkan logika untuk mengarahkan ke halaman lupa password
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Lupa Password?",
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: scaleHelper.scaleText(14),
                color: ColorConstant.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
