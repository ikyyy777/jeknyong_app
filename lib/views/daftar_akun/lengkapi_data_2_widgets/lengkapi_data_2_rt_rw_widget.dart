import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/daftar_akun_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/global_widget/text_form_field_global_widget.dart';
import 'package:provider/provider.dart';

class LengkapiData2RtRwWidget extends StatefulWidget {
  const LengkapiData2RtRwWidget({super.key});

  @override
  State<LengkapiData2RtRwWidget> createState() =>
      _LengkapiData2RtRwWidgetState();
}

class _LengkapiData2RtRwWidgetState extends State<LengkapiData2RtRwWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "RT",
                style: TextStyleConstant.textStyleRegular.copyWith(
                  fontSize: scaleHelper.scaleText(14),
                  color: ColorConstant.blackColor,
                ),
              ),
              SizedBox(height: scaleHelper.scaleHeight(4)),
              TextFormFieldGlobalWidget(
                controller: context.read<DaftarAkunController>().rtController,
                hintText: 'Masukkan RT',
                inputType: TextInputType.number,
              ),
            ],
          ),
        ),
        SizedBox(width: scaleHelper.scaleWidth(16)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "RW",
                style: TextStyleConstant.textStyleRegular.copyWith(
                  fontSize: scaleHelper.scaleText(14),
                  color: ColorConstant.blackColor,
                ),
              ),
              SizedBox(height: scaleHelper.scaleHeight(4)),
              TextFormFieldGlobalWidget(
                controller: context.read<DaftarAkunController>().rwController,
                hintText: 'Masukkan RW',
                inputType: TextInputType.number,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
