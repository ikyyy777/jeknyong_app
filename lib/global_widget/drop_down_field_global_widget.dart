import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class DropDownFieldGlobalWidget extends StatelessWidget {
  const DropDownFieldGlobalWidget({
    super.key,
    required List<Map<String, dynamic>> items,
    required String hintText,
    required Function(String?) onChanged,
  }) : _items = items,
       _hintText = hintText,
       _onChanged = onChanged;

  final List<Map<String, dynamic>> _items;
  final String _hintText;
  final Function(String?) _onChanged;

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.watch<ScaleFactorController>().scaleHelper;
    
    return SizedBox(
      height: scaleHelper.scaleHeight(60),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorConstant.whiteColor,
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
        items: _items.map((item) {
          return DropdownMenuItem<String>(
            value: item['value'],
            child: Text(item['label']),
          );
        }).toList(),
        onChanged: _onChanged,
      ),
    );
  }
}