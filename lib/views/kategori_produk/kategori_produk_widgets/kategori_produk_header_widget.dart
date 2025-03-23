import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class KategoriProdukHeaderWidget extends StatelessWidget {
  final String kategori;
  const KategoriProdukHeaderWidget({
    super.key,
    required this.kategori,
  });

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: scaleHelper.scaleWidth(40),
            height: scaleHelper.scaleHeight(40),
            decoration: BoxDecoration(
              color: ColorConstant.whiteColor,
              border: Border.all(color: ColorConstant.borderColor),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Icon(Icons.arrow_back, color: ColorConstant.blackColor),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              "Toko $kategori",
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: scaleHelper.scaleText(16),
                color: ColorConstant.blackColor,
              ),
            ),
          ),
        ),
        SizedBox(
          width: scaleHelper.scaleWidth(40),
        ), // To balance the back button
      ],
    );
  }
}
