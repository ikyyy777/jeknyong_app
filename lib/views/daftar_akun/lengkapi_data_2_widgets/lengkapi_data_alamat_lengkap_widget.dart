import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/daftar_akun_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/global_widget/text_form_field_global_widget.dart';
import 'package:provider/provider.dart';

class LengkapiDataAlamatLengkapWidget extends StatefulWidget {
  const LengkapiDataAlamatLengkapWidget({super.key});

  @override
  State<LengkapiDataAlamatLengkapWidget> createState() => _LengkapiDataAlamatLengkapWidgetState();
}

class _LengkapiDataAlamatLengkapWidgetState extends State<LengkapiDataAlamatLengkapWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Alamat Lengkap",
          style: TextStyleConstant.textStyleReguler.copyWith(
            fontSize: scaleHelper.scaleText(14),
          ),
        ),
        SizedBox(height: scaleHelper.scaleHeight(4)),
        TextFormFieldGlobalWidget(
          controller: context.read<DaftarAkunController>().alamatLengkapController,
          hintText: 'Masukkan Alamat',
        ),
      ],
    );
  }
}