import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/controllers/jual_sampah_dipilah_controller.dart';
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
    final controller = context.read<JualSampahDipilahController>();
    final addressData = await controller.getAddressFromSharedPreferences();

    setState(() {
      _address = addressData['address'] ?? '';
      _subLocality = addressData['subLocality'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(scaleHelper.scaleWidth(10)),
      ),
      elevation: 0,
      color: Colors.white,
      child: InkWell(
        onTap: () async {
          // Navigate to pilih lokasi
          final result = await Navigator.pushNamed(context, '/pilih-lokasi');
          if (result == true) {
            // Refresh alamat jika ada perubahan
            await _loadAddress();
            await context.read<JualSampahDipilahController>().syncAddressWithSharedPreferences();
          }
        },
        borderRadius: BorderRadius.circular(scaleHelper.scaleWidth(10)),
        child: Padding(
          padding: EdgeInsets.all(scaleHelper.scaleWidth(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Alamat Saya",
                style: TextStyleConstant.textStyleBold.copyWith(
                  fontSize: scaleHelper.scaleText(16),
                  color: ColorConstant.blackColor,
                ),
              ),
              SizedBox(height: scaleHelper.scaleHeight(16)),

              if (_subLocality.isNotEmpty)
                Text(
                  _subLocality,
                  style: TextStyleConstant.textStyleSemiBold.copyWith(
                    fontSize: scaleHelper.scaleText(14),
                    color: ColorConstant.blackColor,
                  ),
                ),

              if (_address.isNotEmpty)
                Text(
                  _address,
                  style: TextStyleConstant.textStyleRegular.copyWith(
                    fontSize: scaleHelper.scaleText(14),
                    color: ColorConstant.darkColor2,
                  ),
                ),

              if (_subLocality.isEmpty && _address.isEmpty)
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
                  (_subLocality.isEmpty && _address.isEmpty)
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