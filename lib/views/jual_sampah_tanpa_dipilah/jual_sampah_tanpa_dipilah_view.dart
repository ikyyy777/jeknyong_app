import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/controllers/jual_sampah_tanpa_dipilah_controller.dart';
import 'package:jeknyong_app/global_widget/custom_appbar_global_widget.dart';
import 'package:jeknyong_app/views/jual_sampah_tanpa_dipilah/jual_sampah_tanpa_dipilah_widget/jual_sampah_alamat_widget.dart';
import 'package:jeknyong_app/views/jual_sampah_tanpa_dipilah/jual_sampah_tanpa_dipilah_widget/jual_sampah_foto_sampah_global_widget.dart';
import 'package:jeknyong_app/views/jual_sampah_tanpa_dipilah/jual_sampah_tanpa_dipilah_widget/jual_sampah_informasi_tambahan_global_widget.dart';
import 'package:provider/provider.dart';

class AnorganikTanpaDipilahView extends StatefulWidget {
  const AnorganikTanpaDipilahView({super.key});

  @override
  State<AnorganikTanpaDipilahView> createState() =>
      _AnorganikTanpaDipilahViewState();
}

class _AnorganikTanpaDipilahViewState extends State<AnorganikTanpaDipilahView> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    final controller = context.watch<JualSampahTanpaDipilahController>();

    return Scaffold(
      backgroundColor: ColorConstant.greyColor2,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppbarGlobalWidget(
              title: "Anorganik Tanpa Dipilah",
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  JualSampahAlamatWidget(),
                  SizedBox(height: scaleHelper.scaleHeight(16)),
                  JualSampahInformasiTambahanWidget(),
                  SizedBox(height: scaleHelper.scaleHeight(16)),
                  JualSampahFotoSampahWidget(),
                  SizedBox(height: scaleHelper.scaleHeight(16)),
                  
                  // Error message
                  if (controller.errorMessage != null)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.shade300),
                      ),
                      child: Text(
                        controller.errorMessage!,
                        style: TextStyleConstant.textStyleRegular.copyWith(
                          fontSize: scaleHelper.scaleText(14),
                          color: Colors.red.shade800,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: controller.isBottomNavVisible 
          ? Container(
              height: scaleHelper.scaleHeight(97),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: Container(
                height: scaleHelper.scaleHeight(40),
                margin: EdgeInsets.only(bottom: 16),
                child: ElevatedButton(
                  onPressed: controller.isSubmitting
                      ? null  // Disable button while submitting
                      : () async {
                          final success = await controller.submitForm();
                          if (success) {
                            // Reset form setelah berhasil
                            controller.resetForm();
                            
                            Navigator.pushNamed(context, '/transaksi-berhasil');
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primaryColor,
                    disabledBackgroundColor: ColorConstant.darkColor3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: controller.isSubmitting
                      ? SizedBox(
                          width: scaleHelper.scaleWidth(20),
                          height: scaleHelper.scaleHeight(20),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          'Jual Sampah Sekarang',
                          style: TextStyleConstant.textStyleSemiBold.copyWith(
                            fontSize: scaleHelper.scaleText(14),
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            )
          : null,  // Hidden when form is not complete
    );
  }
}
