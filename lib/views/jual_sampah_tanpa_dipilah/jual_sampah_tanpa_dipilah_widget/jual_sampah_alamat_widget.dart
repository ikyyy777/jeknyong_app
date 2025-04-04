import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/controllers/jual_sampah_tanpa_dipilah_controller.dart';
import 'package:provider/provider.dart';

class JualSampahAlamatWidget extends StatefulWidget {
  const JualSampahAlamatWidget({super.key});

  @override
  State<JualSampahAlamatWidget> createState() => _JualSampahAlamatWidgetState();
}

class _JualSampahAlamatWidgetState extends State<JualSampahAlamatWidget> {
  String _address = '';
  String _subLocality = '';

  @override
  void initState() {
    super.initState();
    _loadAddress();
  }

  Future<void> _loadAddress() async {
    final controller = context.read<JualSampahTanpaDipilahController>();
    final addressData = await controller.getAddressFromSharedPreferences();

    setState(() {
      _address = addressData['address'];
      _subLocality = addressData['subLocality'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(context, '/pilih-lokasi');
        _loadAddress(); // Reload address after returning from location picker
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorConstant.whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(scaleHelper.scaleWidth(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Alamat Saya',
                    style: TextStyleConstant.textStyleSemiBold.copyWith(
                      fontSize: scaleHelper.scaleText(16),
                      color: ColorConstant.blackColor,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
              SizedBox(height: scaleHelper.scaleHeight(12)),

              if (_subLocality != '' && _address != '')
                Text(
                  _subLocality,
                  style: TextStyleConstant.textStyleSemiBold.copyWith(
                    fontSize: scaleHelper.scaleText(14),
                    color: ColorConstant.darkColor2,
                  ),
                ),
              Text(
                _address,
                style: TextStyleConstant.textStyleRegular.copyWith(
                  fontSize: scaleHelper.scaleText(14),
                  color: ColorConstant.darkColor2,
                ),
              ),

              if (_subLocality == '' && _address == '')
                Center(
                  child: Text(
                    "Belum ada alamat tersimpan",
                    style: TextStyleConstant.textStyleSemiBold.copyWith(
                      fontSize: 14,
                      color: ColorConstant.darkColor2,
                    ),
                  ),
                ),

              SizedBox(height: scaleHelper.scaleHeight(12)),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  (_subLocality == '' && _address == '')
                      ? "Tambah Alamat"
                      : "Ganti Alamat",
                  style: TextStyleConstant.textStyleSemiBold.copyWith(
                    color: ColorConstant.primaryColor,
                    fontSize: scaleHelper.scaleText(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
