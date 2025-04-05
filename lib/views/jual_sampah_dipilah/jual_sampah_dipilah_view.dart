import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/keranjang_jual_sampah_dipilah_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/views/jual_sampah_dipilah/jual_sampah_dipilah_widget/jual_sampah_dipilah_grid_content_widget.dart';
import 'package:jeknyong_app/views/jual_sampah_dipilah/jual_sampah_dipilah_widget/jual_sampah_dipilah_header_widget.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class JualSampahDipilahView extends StatefulWidget {
  const JualSampahDipilahView({super.key});

  @override
  State<JualSampahDipilahView> createState() => _JualSampahDipilahViewState();
}

class _JualSampahDipilahViewState extends State<JualSampahDipilahView> {
  final formatCurrency = NumberFormat.decimalPattern('id');
  
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JualSampahDipilahHeaderWidget(),
            JualSampahDipilahGridContentWidget(),
          ],
        ),
      ),
      floatingActionButton: Consumer<KeranjangJualSampahDipilahController>(
        builder: (context, controller, child) {
          if (controller.isEmpty) {
            return SizedBox.shrink(); // Sembunyikan FAB jika keranjang kosong
          }
          
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: scaleHelper.scaleWidth(16)),
            child: SizedBox(
              width: double.infinity,
              height: scaleHelper.scaleHeight(60),
              child: FloatingActionButton.extended(
                backgroundColor: ColorConstant.primaryColor,
                onPressed: () {
                  // Aksi ketika tombol ditekan
                  Navigator.pushNamed(context, '/keranjang-sampah');
                },
                isExtended: true,
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${controller.itemCount} Jenis Sampah",
                          style: TextStyleConstant.textStyleSemiBold.copyWith(
                            fontSize: scaleHelper.scaleText(14),
                            color: ColorConstant.whiteColor,
                          ),
                        ),
                        Text(
                          "Jual Sampah dengan Dipilah",
                          style: TextStyleConstant.textStyleRegular.copyWith(
                            fontSize: scaleHelper.scaleText(12),
                            color: ColorConstant.whiteColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: scaleHelper.scaleWidth(12)),
                    Row(
                      children: [
                        Text(
                          "Rp ${formatCurrency.format(controller.totalHarga)}",
                          style: TextStyleConstant.textStyleBold.copyWith(
                            fontSize: scaleHelper.scaleText(14),
                            color: ColorConstant.whiteColor,
                          ),
                        ),
                        SizedBox(width: scaleHelper.scaleWidth(8)),
                        Container(
                          width: scaleHelper.scaleWidth(26),
                          height: scaleHelper.scaleHeight(26),
                          decoration: BoxDecoration(
                            color: ColorConstant.whiteColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(child: SvgPicture.asset('assets/icons/cart.svg', width: scaleHelper.scaleWidth(15),)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
