import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/daftar_akun_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/global_widget/text_form_field_global_widget.dart';
import 'package:provider/provider.dart';

class LengkapiDataNomorWidget extends StatefulWidget {
  const LengkapiDataNomorWidget({super.key});

  @override
  State<LengkapiDataNomorWidget> createState() =>
      _LengkapiDataNomorWidgetState();
}

class _LengkapiDataNomorWidgetState extends State<LengkapiDataNomorWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Nomor Whatsapp",
          style: TextStyleConstant.textStyleRegular.copyWith(
            fontSize: scaleHelper.scaleText(14),
            color: ColorConstant.blackColor,
          ),
        ),
        SizedBox(height: scaleHelper.scaleHeight(4)),
        TextFormFieldGlobalWidget(
          controller:
              context.read<DaftarAkunController>().nomorWhatsappController,
          hintText: 'Masukkan Nomor',
          inputType: TextInputType.number,
        ),
      ],
    );
  }
}
