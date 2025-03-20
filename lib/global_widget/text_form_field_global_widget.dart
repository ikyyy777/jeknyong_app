import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class TextFormFieldGlobalWidget extends StatelessWidget {
  const TextFormFieldGlobalWidget({
    super.key,
    required TextEditingController controller,
    required String hintText,
    this.inputType = TextInputType.text,
  }) : _controller = controller,
       _hintText = hintText;

  final TextEditingController _controller;
  final String _hintText;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.watch<ScaleFactorController>().scaleHelper;
    
    return SizedBox(
      height: scaleHelper.scaleHeight(60),
      child: TextField(
        controller: _controller,
        keyboardType: inputType,
        inputFormatters: [
          if (inputType == TextInputType.number)
            FilteringTextInputFormatter.digitsOnly
          else
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
        ],
        decoration: InputDecoration(
          hintText: _hintText,
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
    );
  }
}