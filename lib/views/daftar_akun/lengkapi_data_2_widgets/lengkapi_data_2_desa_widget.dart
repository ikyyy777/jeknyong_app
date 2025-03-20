import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/daftar_akun_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/global_widget/drop_down_field_global_widget.dart';
import 'package:provider/provider.dart';

class LengkapiData2DesaWidget extends StatefulWidget {
  const LengkapiData2DesaWidget({super.key});

  @override
  State<LengkapiData2DesaWidget> createState() => _LengkapiData2DesaWidgetState();
}

class _LengkapiData2DesaWidgetState extends State<LengkapiData2DesaWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Desa',
          style: TextStyleConstant.textStyleReguler.copyWith(
            fontSize: scaleHelper.scaleText(14),
            color: ColorConstant.blackColor,
          ),
        ),
        SizedBox(height: scaleHelper.scaleHeight(4)),
        DropDownFieldGlobalWidget(
          items: context.read<DaftarAkunController>().desaList,
          hintText: 'Pilih Desa',
          onChanged: (value) {
            context.read<DaftarAkunController>().setSelectedDesa(value ?? '');
          },
        ),
      ],
    );
  }
}