import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/daftar_akun_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/global_widget/text_form_field_global_widget.dart';
import 'package:provider/provider.dart';

class LengkapiData2KodePosWidget extends StatefulWidget {
  const LengkapiData2KodePosWidget({super.key});

  @override
  State<LengkapiData2KodePosWidget> createState() => _LengkapiData2KodePosWidgetState();
}

class _LengkapiData2KodePosWidgetState extends State<LengkapiData2KodePosWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kode Pos',
          style: TextStyleConstant.textStyleReguler.copyWith(
            fontSize: scaleHelper.scaleText(14),
            color: ColorConstant.blackColor,
          ),
        ),
        SizedBox(height: scaleHelper.scaleHeight(4)),
        TextFormFieldGlobalWidget(
          controller: context.read<DaftarAkunController>().kodePosController,
          hintText: 'Masukkan Kode Pos',
          inputType: TextInputType.number,
        ),
      ],
    );
  }
}