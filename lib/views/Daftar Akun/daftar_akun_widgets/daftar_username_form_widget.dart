import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/utils/scale_helper.dart';

class DaftarUsernameFormWidget extends StatefulWidget {
  const DaftarUsernameFormWidget({super.key});

  @override
  State<DaftarUsernameFormWidget> createState() =>
      _DaftarUsernameFormWidgetState();
}

class _DaftarUsernameFormWidgetState extends State<DaftarUsernameFormWidget> {
  late ScaleHelper _scaleHelper;

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
          'Username',
          style: TextStyleConstant.textStyleReguler.copyWith(
            fontSize: _scaleHelper.scaleText(14),
            color: ColorConstant.blackColor,
          ),
        ),
        SizedBox(height: _scaleHelper.scaleHeight(4)),
        SizedBox(
          height: _scaleHelper.scaleHeight(60),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Masukkan Username",
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
