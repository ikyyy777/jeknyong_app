import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/daftar_akun_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/global_widget/drop_down_field_global_widget.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:provider/provider.dart';

class LengkapiData2KecamatanFormWidget extends StatefulWidget {
  const LengkapiData2KecamatanFormWidget({super.key});

  @override
  State<LengkapiData2KecamatanFormWidget> createState() => _LengkapiData2KecamatanFormWidgetState();
}

class _LengkapiData2KecamatanFormWidgetState extends State<LengkapiData2KecamatanFormWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kecamatan',
          style: TextStyleConstant.textStyleRegular.copyWith(
            fontSize: scaleHelper.scaleText(14),
            color: ColorConstant.blackColor,
          ),
        ),
        SizedBox(height: scaleHelper.scaleHeight(4)),
        DropDownFieldGlobalWidget(
          items: context.read<DaftarAkunController>().kecamatanList,
          hintText: 'Pilih Kecamatan',
          onChanged: (value) {
            context.read<DaftarAkunController>().setSelectedKecamatan(value ?? '');
          },
        ),
      ],
    );
  }
}