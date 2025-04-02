import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class JualSampahDipilahWidget extends StatefulWidget {
  const JualSampahDipilahWidget({super.key});

  @override
  State<JualSampahDipilahWidget> createState() => _JualSampahDipilahWidgetState();
}

class _JualSampahDipilahWidgetState extends State<JualSampahDipilahWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/jual-sampah-dipilah');
      },
      child: Container(
        width: double.infinity,
        height: scaleHelper.scaleHeight(168),
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstant.blackColor.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Container(
                  width: scaleHelper.scaleWidth(60),
                  height: scaleHelper.scaleHeight(60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorConstant.greyColor,
                  ),
                  child: Center(
                    child: SvgPicture.asset('assets/icons/sampah_dipilah.svg'),
                  ),
                ),
                title: Text(
                  "Sampah Dengan Dipilah",
                  style: TextStyleConstant.textStyleSemiBold.copyWith(
                    fontSize: 16,
                  ),
                ),
                trailing: Container(
                  width: scaleHelper.scaleWidth(24),
                  height: scaleHelper.scaleHeight(24),
                  decoration: BoxDecoration(
                    color: ColorConstant.greyColor,
                    borderRadius: BorderRadius.circular(180),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 14,
                    color: ColorConstant.greenColor,
                  ),
                ),
              ),
              SizedBox(height: scaleHelper.scaleHeight(10)),
              Text(
                "Pisahkan sampah berdasarkan jenisnya (plastik, kertas, kaca, dll.) harga masing masing berbeda",
                style: TextStyleConstant.textStyleRegular.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}