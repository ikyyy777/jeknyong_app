import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class AnorganikFotoSampahWidget extends StatefulWidget {
  const AnorganikFotoSampahWidget({super.key});

  @override
  State<AnorganikFotoSampahWidget> createState() =>
      _AnorganikFotoSampahWidgetState();
}

class _AnorganikFotoSampahWidgetState extends State<AnorganikFotoSampahWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    return Container(
      width: double.infinity,
      height: scaleHelper.scaleHeight(170),
      decoration: BoxDecoration(
        color: ColorConstant.whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bukti Foto Sampah",
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: scaleHelper.scaleText(16),
              ),
            ),
            SizedBox(height: scaleHelper.scaleHeight(12)),
            Container(
              width: double.infinity,
              height: scaleHelper.scaleHeight(100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorConstant.darkColor4),
              ),
              child: Center(
                child: Icon(Icons.add, size: scaleHelper.scaleText(32), color: ColorConstant.darkColor4),
              ),
            )
          ],
        ),
      ),
    );
  }
}
