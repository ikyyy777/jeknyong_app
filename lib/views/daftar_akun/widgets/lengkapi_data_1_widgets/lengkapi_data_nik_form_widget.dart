import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/daftar_akun_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/global_widget/text_form_field_global_widget.dart';
import 'package:provider/provider.dart';

class LengkapiDataNikFormWidget extends StatefulWidget {
  const LengkapiDataNikFormWidget({super.key});

  @override
  State<LengkapiDataNikFormWidget> createState() =>
      _LengkapiDataNikFormWidgetState();
}

class _LengkapiDataNikFormWidgetState extends State<LengkapiDataNikFormWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScaleFactorController>().initScaleHelper(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.watch<ScaleFactorController>().scaleHelper;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "NIK",
          style: TextStyleConstant.textStyleRegular.copyWith(
            fontSize: scaleHelper.scaleText(14),
            color: ColorConstant.blackColor,
          ),
        ),
        SizedBox(height: scaleHelper.scaleHeight(4)),
        TextFormFieldGlobalWidget(
          controller: context.read<DaftarAkunController>().nikController,
          hintText: 'Masukkan NIK',
          inputType: TextInputType.number,
        ),
      ],
    );
  }
}
