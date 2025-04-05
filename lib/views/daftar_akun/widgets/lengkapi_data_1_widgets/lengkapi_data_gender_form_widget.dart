import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/daftar_akun_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class LengkapiDataGenderFormWidget extends StatefulWidget {
  const LengkapiDataGenderFormWidget({super.key});

  @override
  State<LengkapiDataGenderFormWidget> createState() =>
      _LengkapiDataGenderFormWidgetState();
}

class _LengkapiDataGenderFormWidgetState
    extends State<LengkapiDataGenderFormWidget> {

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
          'Jenis Kelamin',
          style: TextStyleConstant.textStyleRegular.copyWith(
            fontSize: scaleHelper.scaleText(14),
            color: ColorConstant.blackColor,
          ),
        ),
        SizedBox(height: scaleHelper.scaleHeight(4)),
        Consumer<DaftarAkunController>(
          builder: (context, daftarAkunController, child) {
            return Row(
              children: [
                Radio(
                  value: 'Laki-laki',
                  groupValue: daftarAkunController.selectedGender,
                  activeColor: ColorConstant.primaryColor,
                  onChanged: (value) {
                    setState(() {
                      daftarAkunController.setSelectedGender(value.toString());
                    });
                  },
                ),
                Text(
                  'Laki-laki',
                  style: TextStyleConstant.textStyleRegular.copyWith(
                    fontSize: scaleHelper.scaleText(14),
                    color: ColorConstant.blackColor,
                  ),
                ),
              ],
            );
          },
        ),
        SizedBox(width: scaleHelper.scaleWidth(24)),
        Consumer<DaftarAkunController>(
          builder: (context, daftarAkunController, child) {
            return Row(
              children: [
                Radio(
                  value: 'Perempuan',
                  groupValue: daftarAkunController.selectedGender,
                  activeColor: ColorConstant.primaryColor,
                  onChanged: (value) {
                    setState(() {
                      daftarAkunController.setSelectedGender(value.toString());
                    });
                  },
                ),
                Text(
                  'Perempuan',
                  style: TextStyleConstant.textStyleRegular.copyWith(
                    fontSize: scaleHelper.scaleText(14),
                    color: ColorConstant.blackColor,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
